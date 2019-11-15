package model

import (
	"context"
	"database/sql"
	"github.com/jinzhu/gorm"
	log "github.com/sirupsen/logrus"
	"trak-gateway/takealot/api"
)

type ProductModel struct {
	gorm.Model
	PLID     uint `gorm:"unique_index"`
	SKU      uint `gorm:"index"`
	Title    string
	Subtitle string
	URL      string `gorm:"type:text"`
}

func (*ProductModel) TableName() string {
	return "product"
}

func migrateProductModel(db *gorm.DB) {
	db.AutoMigrate(&ProductModel{})
}

// FindProducts returns products with IDs greater than greaterThanID
// limited by size
func FindProducts(greaterThanID uint, size int, db *gorm.DB) []*ProductModel {
	arr := make([]*ProductModel, 0)
	db.Model(&ProductModel{}).
		Order("id asc").
		Where("id > ?", greaterThanID).
		Limit(size).
		Find(&arr)

	return arr
}

func FindLatestProducts(page, size int, db *gorm.DB) ([]*ProductModel, QueryPage) {
	arr := make([]*ProductModel, 0)
	db.Model(&ProductModel{}).
		Order("id desc").
		Offset(page * size).
		Limit(size).
		Find(&arr)

	count := uint(0)

	db.Model(&ProductModel{}).Count(&count)

	pages := count/uint(size) + 1
	isFirst := page == 0
	isLast := false

	if len(arr) < size {
		isLast = true
	}

	return arr, QueryPage{
		CurrentPage: uint(page),
		LastPage:    pages,
		TotalItems:  count,
		PageSize:    uint(size),
		IsFirstPage: isFirst,
		IsLastPage:  isLast,
	}
}

func FindProductsByCategory(categoryID uint, page, size int, db *gorm.DB) []*ProductModel {
	arr := make([]*ProductCategoryLinkModel, 0)

	db.Model(&ProductCategoryLinkModel{}).
		Offset(page*size).
		Limit(size).
		Where("category_id = ?", categoryID).
		Find(&arr)

	ids := make([]uint, 0)
	for _, a := range arr {
		ids = append(ids, a.ProductID)
	}

	return FindManyProductModel(ids, db)
}

func FindProductCategories(productID uint, db *gorm.DB) []*CategoryModel {
	models := make([]*ProductCategoryLinkModel, 0)
	db.Model(&ProductCategoryLinkModel{}).Where("product_id = ?", productID).Find(&models)

	categoryModels := make([]*CategoryModel, 0)

	for _, m := range models {
		model := &CategoryModel{}
		db.Model(model).Where("id = ?", m.CategoryID).FirstOrInit(model)
		if model.ID > 0 {
			categoryModels = append(categoryModels, model)
		}
	}

	return categoryModels
}

func FindProductBrand(productID uint, db *gorm.DB) (*BrandModel, bool) {
	model := &ProductBrandLinkModel{}
	db.Model(model).Where("product_id = ?", productID).FirstOrInit(model)

	if model.ID == 0 {
		return nil, false
	}

	brandModel := &BrandModel{}
	db.Model(brandModel).Where("id = ?", model.BrandID).FirstOrInit(brandModel)

	if brandModel.ID == 0 {
		return nil, false
	}

	return brandModel, true
}

func FindProductsByBrand(brandID uint, page, size int, db *gorm.DB) []*ProductModel {
	arr := make([]*ProductBrandLinkModel, 0)

	db.Model(&ProductBrandLinkModel{}).
		Offset(page*size).
		Limit(size).
		Where("brand_id = ?", brandID).
		Find(&arr)

	ids := make([]uint, 0)
	for _, a := range arr {
		ids = append(ids, a.ProductID)
	}

	return FindManyProductModel(ids, db)
}

func FindManyProductModel(ids []uint, db *gorm.DB) []*ProductModel {
	arr := make([]*ProductModel, 0)
	db.Model(&ProductModel{}).Where("id in (?)", ids).Find(&arr)
	return arr
}

func FindProductModel(id uint, db *gorm.DB) (*ProductModel, bool) {
	model := &ProductModel{}

	db.Model(model).Where("id = ?", id).FirstOrInit(model)

	if model.ID == 0 {
		return nil, false
	}

	return model, true
}

func ProductModelExists(plID uint, db *gorm.DB) (uint, bool) {
	dbModel := &ProductModel{}
	db.Model(dbModel).Where("pl_id = ?", plID).FirstOrInit(dbModel)

	if dbModel.ID == 0 {
		return 0, false
	}

	return dbModel.ID, true
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

func FindProductsByPromotion(promotionID uint, page, size int, db *gorm.DB) ([]*ProductModel, QueryPage) {
	arr := make([]*ProductModel, 0)
	plIDs, queryPage := FindProductPLIDsByPromotion(promotionID, page, size, db)
	db.Model(&ProductModel{}).
		Where("pl_id in (?)", plIDs).
		Find(&arr)

	return arr, queryPage
}

func (p *ProductModel) MapResponseToModel(resp *api.ProductResponse) {
	p.SKU = resp.DataLayer.Sku
	p.Title = resp.Core.Title
	p.URL = resp.Sharing.URL

	if resp.Core.Subtitle != nil {
		p.Subtitle = *resp.Core.Subtitle
	}
}
