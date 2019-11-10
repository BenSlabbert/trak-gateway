package model

import (
	"context"
	"database/sql"
	"github.com/jinzhu/gorm"
	log "github.com/sirupsen/logrus"
)

type QueryPage struct {
	CurrentPage uint
	LastPage    uint
	TotalItems  uint
	PageSize    uint
	IsFirstPage bool
	IsLastPage  bool
}

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
		Where("display_name = ?", "Daily Deals").
		FirstOrInit(model)

	if model.ID == 0 {
		return nil, false
	}

	return model, true
}

func FindLatestPromotions(page, size int, db *gorm.DB) ([]*PromotionModel, QueryPage) {
	arr := make([]*PromotionModel, 0)
	db.Model(&PromotionModel{}).
		Order("id desc").
		Offset(page * size).
		Limit(size).
		Find(&arr)

	count := uint(0)

	db.Model(&PromotionModel{}).Count(&count)

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
