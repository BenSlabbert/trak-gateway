package model

import (
	"context"
	"database/sql"
	"github.com/jinzhu/gorm"
)

const UnknownBrand = "UNKNOWN"

type BrandModel struct {
	gorm.Model
	Name string `gorm:"unique_index"`
}

func (*BrandModel) TableName() string {
	return "brand"
}

func migrateBrandModel(db *gorm.DB) {
	model := &BrandModel{}
	db.AutoMigrate(model)

	db.Model(model).Where("name = ?", UnknownBrand).FirstOrInit(model)

	if model.ID == 0 {
		model.Name = UnknownBrand
		db.Create(model)
	}
}

// FindProducts returns products with IDs greater than greaterThanID
// limited by size
func FindBrands(greaterThanID uint, size int, db *gorm.DB) []*BrandModel {
	arr := make([]*BrandModel, 0)
	db.Model(&BrandModel{}).
		Order("id asc").
		Where("id > ?", greaterThanID).
		Limit(size).
		Find(&arr)

	return arr
}

func FindDefaultBrand(db *gorm.DB) *BrandModel {
	model := &BrandModel{}

	db.Model(model).Where("name = ?", UnknownBrand).FirstOrInit(model)

	if model.ID == 0 {
		return nil
	}

	return model
}

func FindBrandModel(id uint, db *gorm.DB) (*BrandModel, bool) {
	model := &BrandModel{}

	db.Model(model).Where("id = ?", id).FirstOrInit(model)

	if model.ID == 0 {
		return nil, false
	}

	return model, true
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
