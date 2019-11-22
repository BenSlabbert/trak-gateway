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

func RemoveProductDuplicatePrices(productID uint, db *gorm.DB) error {
	sqlOpts := &sql.TxOptions{
		Isolation: sql.LevelDefault,
		ReadOnly:  false,
	}

	uniqueCurrentPrices := make([]*PriceModel, 0)

	tx := db.BeginTx(context.Background(), sqlOpts)
	tx.Table("price").
		Where("product_id = ?", productID).
		Order("created_at").
		Group("current_price").
		Find(&uniqueCurrentPrices)

	if len(uniqueCurrentPrices) > 15 {
		ids := make([]uint, 0, len(uniqueCurrentPrices))
		for _, a := range uniqueCurrentPrices {
			ids = append(ids, a.ID)
		}

		// permanent delete
		tx.Unscoped().
			Delete(&PriceModel{}, "product_id = ? and id not in (?)", productID, ids)
	}

	err := tx.Commit().Error

	if err != nil {
		tx.Rollback()
		return err
	}

	return nil
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
		Where("product_id = ?", productID).
		Order("id desc").
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
