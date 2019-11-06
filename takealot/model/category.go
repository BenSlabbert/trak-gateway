package model

import (
	"context"
	"database/sql"
	"github.com/jinzhu/gorm"
)

type CategoryModel struct {
	gorm.Model
	Name string `gorm:"unique_index"`
}

func (*CategoryModel) TableName() string {
	return "category"
}

func migrateCategoryModel(db *gorm.DB) {
	db.AutoMigrate(&CategoryModel{})
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

func FindCategoryModel(id uint, db *gorm.DB) (*CategoryModel, bool) {
	model := &CategoryModel{}

	db.Model(model).Where("id = ?", id).FirstOrInit(model)

	if model.ID == 0 {
		return nil, false
	}

	return model, true
}
