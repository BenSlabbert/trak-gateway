package model

import (
	"context"
	"database/sql"
	"github.com/jinzhu/gorm"
	log "github.com/sirupsen/logrus"
	"strings"
)

type Format string

const ProductImageSizeDefault Format = "pdpxl"
const ProductImageSizePreview Format = "xlpreview"
const ProductImageSizeThumbnail Format = "xlthumbnail"
const ProductImageSizeListGrid Format = "listgrid"
const ProductImageSizeFB Format = "fb"
const ProductImageSizeFull Format = "full"

type ProductImageModel struct {
	ID        uint `gorm:"primary_key"`
	ProductID uint `gorm:"index"`
	// response comes in the format: https://media.takealot.com/covers_tsins/48075814/190198393173-1-{size}.jpg
	// {size} can be replaced with: pdpxl, xlpreview, xlthumbnail
	URLFormat string `gorm:"type:text"`
}

// formats the image URL for the specific size
func (img *ProductImageModel) FormatURL(size Format) string {
	return strings.Replace(img.URLFormat, "{size}", string(size), 1)
}

func FindProductImageModel(productID uint, db *gorm.DB) (*ProductImageModel, bool) {
	m := &ProductImageModel{}

	db.Model(m).
		Where("product_id = ?", productID).
		Limit(1).
		FirstOrInit(m)

	if m.ID == 0 {
		return nil, false
	}

	return m, true
}

func CreateProductImageModel(model *ProductImageModel, db *gorm.DB) (*ProductImageModel, error) {
	sqlOpts := &sql.TxOptions{
		Isolation: sql.LevelDefault,
		ReadOnly:  false,
	}
	tx := db.BeginTx(context.Background(), sqlOpts)
	tx.Create(model)
	e := tx.Commit().Error

	if e != nil {
		return model, e
	}

	return model, nil
}

func migrateProductImageModel(db *gorm.DB) {
	db.AutoMigrate(&ProductImageModel{}).
		AddForeignKey("product_id", "product(id)", "RESTRICT", "RESTRICT")
}

func (*ProductImageModel) TableName() string {
	return "product_image"
}

type CrawlerModel struct {
	gorm.Model
	Name     string `gorm:"unique_index"`
	LastPLID uint
}

func migrateCrawlerModel(db *gorm.DB) {
	db.AutoMigrate(&CrawlerModel{})
}

func (*CrawlerModel) TableName() string {
	return "crawler"
}

func FindCrawlerModelByName(name string, db *gorm.DB) (*CrawlerModel, bool) {
	model := &CrawlerModel{}
	db.Model(model).Where("name = ?", name).FirstOrInit(model)

	if model.ID == 0 {
		log.Infof("no crawler found for name %s", name)
		return nil, false
	}

	return model, true
}

func UpserCrawlerModel(model *CrawlerModel, db *gorm.DB) (*CrawlerModel, error) {
	sqlOpts := &sql.TxOptions{
		Isolation: sql.LevelDefault,
		ReadOnly:  false,
	}
	tx := db.BeginTx(context.Background(), sqlOpts)
	dbModel := &CrawlerModel{}
	tx.Model(model).Where("name = ?", model.Name).FirstOrInit(dbModel)

	if dbModel.ID == 0 {
		tx.Create(model)
	} else {
		tx.Save(model)
	}
	e := tx.Commit().Error

	if e != nil {
		log.Warnf("failed to persist model: %v with err: %v roll back transaction", model, e)
		tx.Rollback()
		return model, e
	}

	return model, nil
}

type ProductCategoryLinkModel struct {
	ID         uint `gorm:"primary_key"`
	ProductID  uint `gorm:"index"`
	CategoryID uint `gorm:"index"`
}

func (*ProductCategoryLinkModel) TableName() string {
	return "product_category_link"
}

func migrateProductCategoryLinkModel(db *gorm.DB) {
	db.AutoMigrate(&ProductCategoryLinkModel{})
}

type ProductBrandLinkModel struct {
	ID        uint `gorm:"primary_key"`
	ProductID uint `gorm:"index"`
	BrandID   uint `gorm:"index"`
}

func (*ProductBrandLinkModel) TableName() string {
	return "product_brand_link"
}

func migrateProductBrandLinkModel(db *gorm.DB) {
	db.AutoMigrate(&ProductBrandLinkModel{})
}

func CreateProductCategoryLinkModel(productID, categoryID uint, db *gorm.DB) error {
	sqlOpts := &sql.TxOptions{
		Isolation: sql.LevelDefault,
		ReadOnly:  false,
	}
	tx := db.BeginTx(context.Background(), sqlOpts)
	model := &ProductCategoryLinkModel{ProductID: productID, CategoryID: categoryID}
	tx.Create(model)
	e := tx.Commit().Error

	if e != nil {
		return e
	}

	return nil
}

func CreateProductBrandLinkModel(productID, brandID uint, db *gorm.DB) error {
	sqlOpts := &sql.TxOptions{
		Isolation: sql.LevelDefault,
		ReadOnly:  false,
	}
	tx := db.BeginTx(context.Background(), sqlOpts)
	model := &ProductBrandLinkModel{ProductID: productID, BrandID: brandID}
	tx.Create(model)
	e := tx.Commit().Error

	if e != nil {
		return e
	}

	return nil
}

func MigrateModels(db *gorm.DB) {
	tx := db.Begin()
	migrateProductModel(tx)
	migrateBrandModel(tx)
	migrateCategoryModel(tx)
	migratePriceModel(tx)
	migrateProductCategoryLinkModel(tx)
	migrateProductBrandLinkModel(tx)
	migrateCrawlerModel(tx)
	migrateProductImageModel(tx)
	migrateScheduleTaskModel(tx)
	migratePromotionModel(tx)
	migrateProductPromotionLinkModel(tx)
	e := tx.Commit().Error

	if e != nil {
		log.Errorf("failed to migrate DB: %v", e)
		panic("failed to migrate db")
	}
}
