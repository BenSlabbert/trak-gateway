package model

import (
	"context"
	"database/sql"
	"github.com/jinzhu/gorm"
	log "github.com/sirupsen/logrus"
	"time"
)

const PromotionsScheduledTask = "PromotionsScheduledTask"
const PriceUpdateScheduledTask = "PriceUpdateScheduledTask"

type ScheduledTaskModel struct {
	gorm.Model
	Name    string `gorm:"unique_index"`
	LastRun time.Time
	NextRun time.Time
}

func (*ScheduledTaskModel) TableName() string {
	return "scheduled_task"
}

func migrateScheduleTaskModel(db *gorm.DB) {
	model := &ScheduledTaskModel{}
	db.AutoMigrate(model)
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
