package main

import (
	"os"
	"os/signal"
	"path/filepath"
	"time"
	"trak-gateway/connection"
	"trak-gateway/gateway/grpc"
	"trak-gateway/gateway/profile"
	"trak-gateway/gateway/rest"
	"trak-gateway/takealot/env"
	"trak-gateway/takealot/model"

	"github.com/gorilla/mux"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	log "github.com/sirupsen/logrus"
	"net/http"
)

var StaticFilesDir string
var Profile string
var Port string

func init() {
	StaticFilesDir = getStaticFilesDir()
	Port = getGatewayPort()
	Profile = getProfile()
}

func getStaticFilesDir() string {
	dir := os.Getenv("STATIC_FILES_DIR")

	if dir == "" {
		dir = "/static"
	}

	return dir
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
	opts := connection.MariaDBConnectOpts{
		Host:            takealotEnv.DB.Host,
		Port:            takealotEnv.DB.Port,
		Database:        takealotEnv.DB.Database,
		User:            takealotEnv.DB.Username,
		Password:        takealotEnv.DB.Password,
		ConnMaxLifetime: time.Hour,
		MaxIdleConns:    10,
		MaxOpenConns:    100,
	}

	db, e := connection.GetMariaDB(opts)

	if e != nil {
		log.Fatalf("failed to get mariadb connection: %v", e)
	}

	model.MigrateModels(db)
	handler := &rest.Handler{
		DB:          db,
		RedisClient: connection.CreateRedisClient(),
	}

	defer handler.Quit()

	router := setUpRoutes(handler)
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

func setUpRoutes(handler *rest.Handler) *mux.Router {
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

	if Profile == profile.DOCKER {
		absPath, _ := filepath.Abs(StaticFilesDir)
		router.PathPrefix("/").
			Handler(http.FileServer(http.Dir(absPath)))
	}

	return router
}
