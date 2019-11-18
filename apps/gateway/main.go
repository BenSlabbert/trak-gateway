package main

import (
	"archive/zip"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"os/signal"
	"path"
	"path/filepath"
	"strings"
	"time"
	"trak-gateway/connection"
	"trak-gateway/gateway/grpc"
	"trak-gateway/gateway/metrics"
	"trak-gateway/gateway/profile"
	"trak-gateway/gateway/rest"
	"trak-gateway/takealot/env"
	"trak-gateway/takealot/model"

	"github.com/gorilla/mux"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	log "github.com/sirupsen/logrus"
	"net/http"
)

var Profile string
var Port string

func init() {
	Port = getGatewayPort()
	Profile = getProfile()
}

func getGatewayPort() string {
	port := os.Getenv("API_PORT")

	if port == "" {
		port = "5000"
	}

	log.Infof("Running gateway on port: %s", port)

	return port
}

func getProfile() string {
	p := os.Getenv("PROFILE")

	if p == "" {
		p = "DEV"
	}

	log.Infof("Running gateway in profile: %s", p)

	return p
}

func main() {
	log.Infof("Starting gateway")

	takealotEnv := env.LoadEnv()

	db, e := connection.GetMariaDB(connection.MariaDBConnectOpts{
		Host:            takealotEnv.DB.Host,
		Port:            takealotEnv.DB.Port,
		Database:        takealotEnv.DB.Database,
		User:            takealotEnv.DB.Username,
		Password:        takealotEnv.DB.Password,
		ConnMaxLifetime: time.Hour,
		MaxIdleConns:    10,
		MaxOpenConns:    100,
	})

	if e != nil {
		log.Fatalf("failed to get mariadb connection: %v", e)
	}

	model.MigrateModels(db)
	handler := &rest.Handler{
		DB:          db,
		RedisClient: connection.CreateRedisClient(),
	}

	defer handler.Quit()

	if takealotEnv.PPROFEnv.PPROFEnabled {
		log.Infof("exposing pprof and db stats on port: %d", takealotEnv.PPROFEnv.PPROFPort)
		router := mux.NewRouter()
		metrics.ExposePPROF(router)
		metrics.ExposeDBStats(router, db)
		go func() {
			err := http.ListenAndServe(fmt.Sprintf(":%d", takealotEnv.PPROFEnv.PPROFPort), router)
			log.Warnf("failed to serve on port %d: %v", takealotEnv.PPROFEnv.PPROFPort, err)
		}()
	}

	router := setUpRoutes(takealotEnv, handler)
	http.Handle("/", router)

	go func() {
		serve := http.ListenAndServe(":"+Port, router)

		if serve != nil {
			log.Panicf("Failed to serve: %v", serve)
		}
	}()

	defer grpc.CloseConnections()

	// wait for Ctrl + C to exit
	ch := make(chan os.Signal, 1)
	signal.Notify(ch, os.Interrupt)

	// Block until signal is received
	<-ch
}

func setUpRoutes(trakEnv env.TrakEnv, handler *rest.Handler) *mux.Router {
	router := mux.NewRouter()

	router.Path("/api/latest").
		HandlerFunc(handler.LatestHandler).
		Name("LatestHandler")

	router.Path("/api/product/{productId:[0-9]+}").
		HandlerFunc(handler.GetProductById).
		Name("GetProductById")

	router.Path("/api/brand/{brandId}").
		HandlerFunc(handler.GetBrandById).
		Name("GetBrandById")

	router.Path("/api/category/{categoryId}").
		HandlerFunc(handler.GetCategoryById).
		Name("GetCategoryById")

	router.Path("/api/search/product").
		Queries("s", "{s}").
		HandlerFunc(handler.ProductSearch).
		Name("ProductSearch")

	router.Path("/api/search/brand").
		Queries("s", "{s}").
		HandlerFunc(handler.BrandSearch).
		Name("BrandSearch")

	router.Path("/api/search/category").
		Queries("s", "{s}").
		HandlerFunc(handler.CategorySearch).
		Name("CategorySearch")

	router.Path("/api/daily-deals").
		Queries("page", "{page}").
		HandlerFunc(handler.DailyDeals).
		Name("DailyDeals")

	router.Path("/api/promotion").
		Queries("id", "{id}", "page", "{page}").
		HandlerFunc(handler.GetPromotion).
		Name("GetPromotion")

	router.Path("/api/all-promotions").
		Queries("page", "{page}").
		HandlerFunc(handler.GetAllPromotions).
		Name("GetAllPromotions")

	router.Path("/api/add-product").
		HandlerFunc(handler.AddProduct).
		Name("GetAllPromotions")

	if Profile == profile.DOCKER {
		e := CleanDir(trakEnv.UI.Path)
		if e != nil {
			log.Fatalf("failed to clean dir: %s with err: %v", trakEnv.UI.Path, e)
		}
		DownloadAndExtractUIAssets(trakEnv.UI)
		absPath, _ := filepath.Abs(trakEnv.UI.Path + "/ui")
		router.PathPrefix("/").Handler(http.FileServer(http.Dir(absPath)))
	}

	return router
}

func CleanDir(uiPath string) error {
	dir, err := ioutil.ReadDir(uiPath)

	if err != nil {
		return err
	}

	for _, d := range dir {
		err := os.RemoveAll(path.Join([]string{uiPath, d.Name()}...))
		if err != nil {
			return err
		}
	}

	return nil
}

func DownloadAndExtractUIAssets(ui env.UI) {
	err := DownloadFile(ui.Path+"/ui.zip", ui.ReleaseAssetURL)
	if err != nil {
		log.Fatalf("failed to download trak ui from url: %s: %v", ui.ReleaseAssetURL, err)
	}
	_, err = Unzip(ui.Path+"/ui.zip", ui.Path+"/ui")
	if err != nil {
		log.Fatalf("failed to extract ui.zip: %v", err)
	}
}

// https://golangcode.com/unzip-files-in-go/
func Unzip(src string, dest string) ([]string, error) {
	var filenames []string

	r, err := zip.OpenReader(src)
	if err != nil {
		return filenames, err
	}
	defer r.Close()

	for _, f := range r.File {

		// Store filename/path for returning and using later on
		fpath := filepath.Join(dest, f.Name)

		// Check for ZipSlip. More Info: http://bit.ly/2MsjAWE
		if !strings.HasPrefix(fpath, filepath.Clean(dest)+string(os.PathSeparator)) {
			return filenames, fmt.Errorf("%s: illegal file path", fpath)
		}

		filenames = append(filenames, fpath)

		if f.FileInfo().IsDir() {
			// Make Folder
			os.MkdirAll(fpath, os.ModePerm)
			continue
		}

		// Make File
		if err = os.MkdirAll(filepath.Dir(fpath), os.ModePerm); err != nil {
			return filenames, err
		}

		outFile, err := os.OpenFile(fpath, os.O_WRONLY|os.O_CREATE|os.O_TRUNC, f.Mode())
		if err != nil {
			return filenames, err
		}

		rc, err := f.Open()
		if err != nil {
			return filenames, err
		}

		_, err = io.Copy(outFile, rc)

		// Close the file without defer to close before next iteration of loop
		outFile.Close()
		rc.Close()

		if err != nil {
			return filenames, err
		}
	}
	return filenames, nil
}

// https://golangcode.com/download-a-file-from-a-url/
func DownloadFile(filepath string, url string) error {
	// Get the data
	resp, err := http.Get(url)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	// Create the file
	out, err := os.Create(filepath)
	if err != nil {
		return err
	}
	defer out.Close()

	// Write the body to file
	_, err = io.Copy(out, resp.Body)
	return err
}
