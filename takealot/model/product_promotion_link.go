package model

import (
	"context"
	"database/sql"
	"github.com/jinzhu/gorm"
)

type ProductPromotionLinkModel struct {
	ID          uint `gorm:"primary_key"`
	ProductPLID uint `gorm:"index"`
	PromotionID uint `gorm:"index"`
}

func (*ProductPromotionLinkModel) TableName() string {
	return "product_promotion_link"
}

func migrateProductPromotionLinkModel(db *gorm.DB) {
	// do not create a FK on the plid, as this table may be updated before the product is created in the db
	db.AutoMigrate(&ProductPromotionLinkModel{})
}

func FindProductPLIDsByPromotion(promotionID uint, page, size int, db *gorm.DB) []uint {
	arr := make([]*ProductPromotionLinkModel, 0)
	db.Model(&ProductPromotionLinkModel{}).
		Order("id desc").
		Offset(page).
		Limit(size).
		Where("promotion_id = ?", promotionID).
		Find(&arr)

	ids := make([]uint, 0)
	for _, a := range arr {
		ids = append(ids, a.ProductPLID)
	}
	return ids
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
