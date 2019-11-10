package model

import (
	"context"
	"database/sql"
	"github.com/jinzhu/gorm"
)

type PriceModel struct {
	gorm.Model
	ProductID    uint `gorm:"index"`
	ListPrice    float64
	CurrentPrice float64
}

func (*PriceModel) TableName() string {
	return "price"
}

func migratePriceModel(db *gorm.DB) {
	db.AutoMigrate(&PriceModel{}).
		AddForeignKey("product_id", "product(id)", "RESTRICT", "RESTRICT")
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

func FindProductLatestPrices(productID uint, page, size int, db *gorm.DB) []*PriceModel {
	prices := make([]*PriceModel, 0)
	db.Model(&PriceModel{}).
		Offset(page*size).
		Limit(size).
		Order("id desc").
		Where("product_id = ?", productID).
		Find(&prices)
	return prices
}

func FindProductLatestPrice(productID uint, db *gorm.DB) (*PriceModel, bool) {
	m := &PriceModel{}

	db.Model(m).
		Limit(1).
		Order("id desc").
		Where("product_id = ?", productID).
		FirstOrInit(m)

	if m.ID == 0 {
		return nil, false
	}

	return m, true
}
