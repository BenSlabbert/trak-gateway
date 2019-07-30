package main

import (
	"os"
	"trak-gateway/gateway"
	"trak-gateway/gateway/rest"

	"github.com/gorilla/mux"
	log "github.com/sirupsen/logrus"
	"net/http"
)

func main() {
	log.Println("Starting gateway")

	latestItems, ok := gateway.GetLatestItems()
	defer gateway.CloseConnections()

	if !ok {
		log.Println("Failed to get latest items")
	}

	log.Printf("Latest: %v", latestItems)

	// set up REST handlers for ReactJS
	router := mux.NewRouter()

	router.HandleFunc("/", rest.HomeHandler)

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
		HandlerFunc(rest.DailyDeals).
		Name("DailyDeals")

	http.Handle("/", router)
	serve := http.ListenAndServe(":"+getGatewayPort(), router)

	if serve != nil {
		log.Panicf("Failed to serve: %v", serve)
	}
}

func getGatewayPort() string {
	port := os.Getenv("API_PORT")

	if port == "" {
		port = "5000"
	}

	log.Printf("Running gateway on port: %s", port)

	return port
}
