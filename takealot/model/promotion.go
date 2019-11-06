package model

import (
	"context"
	"database/sql"
	"github.com/jinzhu/gorm"
	"github.com/prometheus/common/log"
)

type PromotionModel struct {
	gorm.Model
	PromotionID uint   `gorm:"unique_index"`
	Name        string `gorm:"index"`
	DisplayName string
	Start       string
	End         string
}

func (*PromotionModel) TableName() string {
	return "promotion"
}

func migratePromotionModel(db *gorm.DB) {
	model := &PromotionModel{}
	db.AutoMigrate(model)
}

func FindLatestDailyDealPromotion(db *gorm.DB) (*PromotionModel, bool) {
	model := &PromotionModel{}
	db.Model(model).
		Order("id desc").
		Where("name = ?", "Daily Deals").
		FirstOrInit(model)

	if model.ID == 0 {
		return nil, false
	}

	return model, true
}

func FindLatestPromotions(page, size int, db *gorm.DB) []*PromotionModel {
	arr := make([]*PromotionModel, 0)
	db.Model(&PromotionModel{}).
		Order("id desc").
		Offset(page).
		Limit(size).
		Find(&arr)

	return arr
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
