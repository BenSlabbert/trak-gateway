package model

import (
	"context"
	"database/sql"
	"github.com/jinzhu/gorm"
	"github.com/prometheus/common/log"
	"strings"
	"time"
	"trak-gateway/takealot/api"
)

type Format string

const ProductImageSizeDefault Format = "pdpxl"
const ProductImageSizePreview Format = "xlpreview"
const ProductImageSizeThumbnail Format = "xlthumbnail"

const PromotionsScheduledTask = "PromotionsScheduledTask"

type ProductPromotionLinkModel struct {
	ID          uint `gorm:"primary_key"`
	ProductPLID uint `gorm:"index"`
	PromotionID uint `gorm:"index"`
}

func CreateProductPromotionLinkModel(productPLID, PromotionID uint, db *gorm.DB) error {
	sqlOpts := &sql.TxOptions{
		Isolation: sql.LevelDefault,
		ReadOnly:  false,
	}
	tx := db.BeginTx(context.Background(), sqlOpts)
	model := &ProductPromotionLinkModel{ProductPLID: productPLID, PromotionID: PromotionID}
	tx.Create(model)
	e := tx.Commit().Error

	if e != nil {
		return e
	}

	return nil
}

func (*ProductPromotionLinkModel) TableName() string {
	return "product_promotion_link"
}

func migrateProductPromotionLinkModel(db *gorm.DB) {
	// do not create a FK on the plid, as this table may be updated before the product is created in the db
	db.AutoMigrate(&ProductPromotionLinkModel{})
}

type PromotionModel struct {
	gorm.Model
	PromotionID uint `gorm:"unique_index"`
	Name        string
	DisplayName string
	Start       string
	End         string
}

func UpsertPromotionModel(model *PromotionModel, db *gorm.DB) (*PromotionModel, error) {
	sqlOpts := &sql.TxOptions{
		Isolation: sql.LevelDefault,
		ReadOnly:  false,
	}
	tx := db.BeginTx(context.Background(), sqlOpts)
	dbModel := &PromotionModel{}
	tx.Model(model).Where("promotion_id = ?", model.PromotionID).FirstOrInit(dbModel)

	if dbModel.ID == 0 {
		tx.Create(model)
	} else {
		// todo verify this isn't a problem
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

func migratePromotionModel(db *gorm.DB) {
	model := &PromotionModel{}
	db.AutoMigrate(model)
}

func (*PromotionModel) TableName() string {
	return "promotion"
}

type ScheduledTaskModel struct {
	gorm.Model
	Name    string `gorm:"unique_index"`
	LastRun time.Time
	NextRun time.Time
}

func UpsertScheduledTaskModel(model *ScheduledTaskModel, db *gorm.DB) (*ScheduledTaskModel, error) {
	sqlOpts := &sql.TxOptions{
		Isolation: sql.LevelDefault,
		ReadOnly:  false,
	}
	tx := db.BeginTx(context.Background(), sqlOpts)
	dbModel := &ScheduledTaskModel{}
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

func FindScheduledTaskModelByName(name string, db *gorm.DB) (*ScheduledTaskModel, bool) {
	model := &ScheduledTaskModel{}
	db.Model(model).Where("name = ?", name).FirstOrInit(model)

	if model.ID == 0 {
		return nil, false
	}

	return model, true
}

func migrateScheduleTaskModel(db *gorm.DB) {
	model := &ScheduledTaskModel{}
	db.AutoMigrate(model)
}

func (*ScheduledTaskModel) TableName() string {
	return "scheduled_task"
}

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

type ProductModel struct {
	gorm.Model
	PLID     uint `gorm:"unique_index"`
	SKU      uint `gorm:"index"`
	Title    string
	Subtitle string
}

func migrateProductModel(db *gorm.DB) {
	db.AutoMigrate(&ProductModel{})
}

func (*ProductModel) TableName() string {
	return "product"
}

func UpsertProductModel(model *ProductModel, db *gorm.DB) (*ProductModel, error) {
	sqlOpts := &sql.TxOptions{
		Isolation: sql.LevelDefault,
		ReadOnly:  false,
	}
	tx := db.BeginTx(context.Background(), sqlOpts)
	dbModel := &ProductModel{}
	tx.Model(model).Where("pl_id = ?", model.PLID).FirstOrInit(dbModel)

	if dbModel.ID == 0 {
		tx.Create(model)
	} else {
		model = dbModel
	}
	e := tx.Commit().Error

	if e != nil {
		log.Warnf("failed to persist model: %v with err: %v roll back transaction", model, e)
		tx.Rollback()
		return model, e
	}

	return model, nil
}

func (p *ProductModel) MapResponseToModel(resp *api.ProductResponse) {
	p.SKU = resp.DataLayer.Sku
	p.Title = resp.Core.Title

	if resp.Core.Subtitle != nil {
		p.Subtitle = *resp.Core.Subtitle
	}
}

func CreatePrice(model *PriceModel, db *gorm.DB) (*PriceModel, error) {
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

type PriceModel struct {
	gorm.Model
	ProductID    uint `gorm:"index"` // todo add fk
	ListPrice    float32
	CurrentPrice float32
}

func (*PriceModel) TableName() string {
	return "price"
}

func migratePriceModel(db *gorm.DB) {
	db.AutoMigrate(&PriceModel{}).
		AddForeignKey("product_id", "product(id)", "RESTRICT", "RESTRICT")
}

type CategoryModel struct {
	gorm.Model
	Name string `gorm:"unique_index"`
}

func UpsertCategoryModel(model *CategoryModel, db *gorm.DB) (*CategoryModel, error) {
	sqlOpts := &sql.TxOptions{
		Isolation: sql.LevelDefault,
		ReadOnly:  false,
	}
	tx := db.BeginTx(context.Background(), sqlOpts)
	dbModel := &CategoryModel{}
	tx.Model(dbModel).Where("name = ?", model.Name).FirstOrInit(dbModel)

	if dbModel.ID == 0 {
		tx.Create(model)
	} else {
		model = dbModel
	}

	e := tx.Commit().Error

	if e != nil {
		return model, e
	}

	return model, nil
}

func migrateCategoryModel(db *gorm.DB) {
	db.AutoMigrate(&CategoryModel{})
}

func (*CategoryModel) TableName() string {
	return "category"
}

type BrandModel struct {
	gorm.Model
	Name string `gorm:"unique_index"`
}

func migrateBrandModel(db *gorm.DB) {
	db.AutoMigrate(&BrandModel{})
}

func (*BrandModel) TableName() string {
	return "brand"
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

func UpsertBrandModel(model *BrandModel, db *gorm.DB) (*BrandModel, error) {
	sqlOpts := &sql.TxOptions{
		Isolation: sql.LevelDefault,
		ReadOnly:  false,
	}
	tx := db.BeginTx(context.Background(), sqlOpts)
	dbModel := &BrandModel{}
	tx.Model(dbModel).Where("name = ? ", model.Name).FirstOrInit(dbModel)

	if dbModel.ID == 0 {
		tx.Create(model)
	} else {
		model = dbModel
	}

	e := tx.Commit().Error

	if e != nil {
		return model, e
	}

	return model, nil
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
