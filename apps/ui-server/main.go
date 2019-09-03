package main

import (
	"os"
	"os/signal"
	"path/filepath"
	"trak-gateway/gateway/grpc"
	"trak-gateway/gateway/profile"
	"trak-gateway/gateway/rest"

	"github.com/gorilla/mux"
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

	// set up REST handlers for ReactJS
	router := setUpRoutes()
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

func setUpRoutes() *mux.Router {
	router := mux.NewRouter()

	router.Path("/api/latest").
		HandlerFunc(rest.LatestHandler).
		Name("LatestHandler")

	router.Path("/api/product/{productId:[0-9]+}").
		HandlerFunc(rest.GetProductById).
		Name("GetProductById")

	router.Path("/api/brand/{brandId}").
		HandlerFunc(rest.GetBrandById).
		Name("GetBrandById")

	router.Path("/api/category/{categoryId}").
		HandlerFunc(rest.GetCategoryId).
		Name("GetCategoryId")

	router.Path("/api/search/product").
		Queries("s", "{s}").
		HandlerFunc(rest.ProductSearch).
		Name("ProductSearch")

	router.Path("/api/search/brand").
		Queries("s", "{s}").
		HandlerFunc(rest.BrandSearch).
		Name("BrandSearch")

	router.Path("/api/search/category").
		Queries("s", "{s}").
		HandlerFunc(rest.CategorySearch).
		Name("CategorySearch")

	router.Path("/api/daily-deals").
		Queries("page", "{page}").
		HandlerFunc(rest.DailyDeals).
		Name("DailyDeals")

	router.Path("/api/promotion").
		Queries("id", "{id}", "page", "{page}").
		HandlerFunc(rest.GetPromotion).
		Name("GetPromotion")

	router.Path("/api/all-promotions").
		Queries("page", "{page}").
		HandlerFunc(rest.GetAllPromotions).
		Name("GetAllPromotions")

	if Profile == profile.DOCKER {
		absPath, _ := filepath.Abs(StaticFilesDir)
		router.PathPrefix("/").
			Handler(http.FileServer(http.Dir(absPath)))
	}

	return router
}
