package model

import (
	"github.com/jinzhu/gorm"
	"os"
	"testing"
	"trak-gateway/connection"
	tu "trak-gateway/test_utils"
)

// set up test infrastructure for all tests in this package
func TestMain(m *testing.M) {
	ctx, mariadbC := tu.SetUpMariaDB("../../test_utils/trak.sql")
	defer tu.Terminate(ctx, mariadbC)
	os.Exit(m.Run())
}

func TestFindManyProductModel(t *testing.T) {
	db := tu.GetDB(t)
	defer connection.CloseMariaDB(db)

	productModels := FindProducts(0, 10, db)

	if len(productModels) != 10 {
		t.Errorf("should have %d models", 10)
	}

	ids := make([]uint, 0)
	for _, pm := range productModels {
		ids = append(ids, pm.ID)
	}

	modelsWithId := FindManyProductModel(ids, db)

	if len(modelsWithId) != 10 {
		t.Errorf("should have %d models", 10)
	}
}

func TestFindLatestProducts(t *testing.T) {
	db := tu.GetDB(t)
	defer connection.CloseMariaDB(db)

	productModels, page := FindLatestProducts(0, 10, db)

	if len(productModels) == 0 {
		t.Error("should not be empty")
	}

	if page.IsLastPage {
		t.Error("should not be last page")
	}

	if !page.IsFirstPage {
		t.Error("should not be first page")
	}
}

func TestFindProductCategories(t *testing.T) {
	db := tu.GetDB(t)
	defer connection.CloseMariaDB(db)

	productModels := FindProducts(0, 1, db)

	if len(productModels) != 1 {
		t.Errorf("should have %d models", 1)
	}

	productID := productModels[0].ID

	if productModels[0].PLID != 41469993 {
		t.Error("plID should be 41469993")
	}

	if productModels[0].Title != "Krusell Boden Cover for the HTC One M9 - Transparent Black" {
		t.Error("plID should be 'Krusell Boden Cover for the HTC One M9 - Transparent Black'")
	}

	categories := FindProductCategories(productID, db)

	if len(categories) != 3 {
		t.Error("categories should not be empty")
	}

	productsByCategory := FindProductsByCategory(categories[0].ID, 0, 10, db)

	if len(productsByCategory) != 10 {
		t.Error("should have 10 products")
	}

	productsByCategory = FindProductsByCategory(categories[0].ID, 1, 10, db)

	if len(productsByCategory) != 8 {
		t.Error("should have 8 products")
	}
}

func TestFindProductBrand(t *testing.T) {
	db := tu.GetDB(t)
	defer connection.CloseMariaDB(db)

	productModels := FindProducts(0, 1, db)

	if len(productModels) != 1 {
		t.Errorf("should have %d models", 1)
	}

	productID := productModels[0].ID

	if productModels[0].PLID != 41469993 {
		t.Error("plID should be 41469993")
	}

	brandModel, ok := FindProductBrand(productID, db)

	if !ok {
		t.Error("should find brand for product")
	}

	if brandModel.Name != "Krusell" {
		t.Error("brand name should be Krusell")
	}
}

func TestFindProductsByBrand(t *testing.T) {
	db := tu.GetDB(t)
	defer connection.CloseMariaDB(db)

	productModels := FindProducts(0, 1, db)

	if len(productModels) != 1 {
		t.Errorf("should have %d models", 1)
	}

	productID := productModels[0].ID

	if productModels[0].PLID != 41469993 {
		t.Error("plID should be 41469993")
	}

	brandModel, ok := FindProductBrand(productID, db)

	if !ok {
		t.Error("should find brand for product")
	}

	productsByBrand := FindProductsByBrand(brandModel.ID, 0, 10, db)

	if len(productsByBrand) != 3 {
		t.Error("should have 3 products")
	}
}

func TestFindProductModel(t *testing.T) {
	db := tu.GetDB(t)
	defer connection.CloseMariaDB(db)

	model, ok := FindProductModel(1, db)

	if !ok {
		t.Error("should find product")
	}

	if model.PLID != 41469993 {
		t.Error("plID should be 41469993")
	}
}

func TestProductModelExists(t *testing.T) {
	db := tu.GetDB(t)
	defer connection.CloseMariaDB(db)

	_, ok := ProductModelExistsByPLID(41469993, db)

	if !ok {
		t.Error("should find product")
	}
}

func TestUpsertProductModel(t *testing.T) {
	db := tu.GetDB(t)
	defer connection.CloseMariaDB(db)

	model := &ProductModel{
		Model: gorm.Model{},
		PLID:  41469993,
	}

	productModel, err := UpsertProductModel(model, db)

	if err != nil {
		t.Error("should not give an error")
	}

	if productModel != nil && productModel.ID != 1 {
		t.Error("should return existing model in db")
	}

	if productModel != nil && productModel.Title != "Krusell Boden Cover for the HTC One M9 - Transparent Black" {
		t.Error("should return existing model in db")
	}

	model = &ProductModel{
		Model: gorm.Model{},
		PLID:  123,
		Title: "new title",
	}

	productModel, err = UpsertProductModel(model, db)

	if err != nil {
		t.Error("should not give an error")
	}

	if productModel != nil && productModel.ID == 0 {
		t.Error("should create new model")
	}

	if productModel != nil && productModel.PLID != 123 {
		t.Error("should create new model")
	}

	if productModel != nil && productModel.Title != "new title" {
		t.Error("should create new model")
	}
}

func TestFindProductsByPromotion(t *testing.T) {
	db := tu.GetDB(t)
	defer connection.CloseMariaDB(db)

	models, page := FindProductsByPromotion(30, 0, 10, db)

	if len(models) != 4 {
		t.Error("should have 4 model")
	}

	if !page.IsLastPage {
		t.Error("should be last page")
	}

	if !page.IsFirstPage {
		t.Error("should not be first page")
	}
}
