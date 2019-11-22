package connection

import (
	"fmt"
	"github.com/jinzhu/gorm"
	log "github.com/sirupsen/logrus"
	"os"
	"time"
)

type MariaDBConnectOpts struct {
	Host            string
	Port            int
	Database        string
	User            string
	Password        string
	ConnMaxLifetime time.Duration
	MaxIdleConns    int
	MaxOpenConns    int
}

func GetMariaDB(opts MariaDBConnectOpts) (*gorm.DB, error) {
	connString := "%s:%s@tcp(%s:%d)/%s?charset=utf8&parseTime=True&loc=UTC"
	connString = fmt.Sprintf(connString, opts.User, opts.Password, opts.Host, opts.Port, opts.Database)
	db, err := gorm.Open("mysql", connString)

	if err != nil {
		log.Errorf("unable to connect to mysql instance with '%s' %v", connString, err)
		return nil, err
	}

	logSql := os.Getenv("GORM_LOG_SQL")

	if logSql == "true" {
		db.LogMode(true)
	}

	db.DB().SetConnMaxLifetime(opts.ConnMaxLifetime)
	db.DB().SetMaxIdleConns(opts.MaxIdleConns)
	db.DB().SetMaxOpenConns(opts.MaxOpenConns)

	return db, nil
}

func CloseMariaDB(db *gorm.DB) {
	e := db.Close()

	if e != nil {
		log.Warnf("failed to close mariadb connection: %v", e)
	}
}
