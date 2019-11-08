package env

import (
	log "github.com/sirupsen/logrus"
	"os"
	"strconv"
)

type DBEnv struct {
	Host     string
	Port     int
	Database string
	Username string
	Password string
}

type RedisEnv struct {
	URL      string
	Password string
}

type NSQEnv struct {
	NsqdURL                        string
	NumberOfNewProductConsumers    int
	NumberOfScheduledTaskConsumers int
}

type PPROFEnv struct {
	PPROFEnabled bool
	PPROFPort    int
}

type TrakEnv struct {
	DB         DBEnv
	Redis      RedisEnv
	MasterNode bool
	Nsq        NSQEnv
	PPROFEnv   PPROFEnv
}

func LoadEnv() TrakEnv {
	return TrakEnv{
		DB: DBEnv{
			Host:     getDBHost(),
			Port:     getDBPort(),
			Database: getDBDataBase(),
			Username: getDBUserName(),
			Password: getDBPassword(),
		},
		MasterNode: getMasterNodeConfig(),
		Redis: RedisEnv{
			URL:      getRedisURL(),
			Password: getRedisPassword(),
		},
		Nsq: NSQEnv{
			NsqdURL:                        getNsqdURL(),
			NumberOfNewProductConsumers:    getNsqProductConsumers(),
			NumberOfScheduledTaskConsumers: getNsqScheduledTaskConsumers(),
		},
		PPROFEnv: PPROFEnv{
			PPROFPort:    getPPROFPort(),
			PPROFEnabled: getPPROFEnabled(),
		},
	}
}

func getPPROFEnabled() bool {
	e := os.Getenv("PPROF_ENABLED")
	if e == "true" {
		return true
	}
	return false
}

func getPPROFPort() int {
	e := os.Getenv("PPROF_PORT")

	if e != "" {
		i, err := strconv.ParseInt(e, 10, 0)
		if err != nil {
			log.Warnf("failed to parse string '%s' to int, setting to default 8080", e)
			i = 8080
		}
		return int(i)
	}
	return 8080
}

func getNsqScheduledTaskConsumers() int {
	e := os.Getenv("NSQD_NUMBER_OF_SCHEDULED_TASK_CONSUMERS")

	if e != "" {
		i, err := strconv.ParseInt(e, 10, 0)
		if err != nil {
			log.Warnf("failed to parse string '%s' to int, setting to default 1", e)
			i = 1
		}
		return int(i)
	}
	return 1
}

func getNsqProductConsumers() int {
	e := os.Getenv("NSQD_NUMBER_OF_NEW_PRODUCT_CONSUMERS")

	if e != "" {
		i, err := strconv.ParseInt(e, 10, 0)
		if err != nil {
			log.Warnf("failed to parse string '%s' to int, setting to default 3", e)
			i = 3
		}
		return int(i)
	}
	return 3
}

func getNsqdURL() string {
	e := os.Getenv("NSQD_URL")

	if e == "" {
		return "127.0.0.1:4150"
	}
	return e
}

func getRedisPassword() string {
	e := os.Getenv("REDIS_PASSWORD")

	if e == "" {
		return "password"
	}
	return e
}

func getRedisURL() string {
	e := os.Getenv("REDIS_URL")

	if e == "" {
		return "127.0.0.1:6379"
	}
	return e
}

func getMasterNodeConfig() bool {
	e := os.Getenv("MASTER_NODE")

	if e == "true" {
		return true
	}
	return false
}

func getDBPassword() string {
	e := os.Getenv("DB_PASSWORD")

	if e == "" {
		return "password"
	}
	return e
}

func getDBUserName() string {
	e := os.Getenv("DB_USERNAME")

	if e == "" {
		return "user"
	}
	return e
}

func getDBDataBase() string {
	e := os.Getenv("DB_DATABASE")

	if e == "" {
		return "trak"
	}
	return e
}

func getDBPort() int {
	e := os.Getenv("DB_PORT")

	if e != "" {
		i, err := strconv.ParseInt(e, 10, 0)
		if err != nil {
			log.Warnf("failed to parse string '%s' to int, setting to default 3306", e)
			i = 3306
		}
		return int(i)
	}
	return 3306
}

func getDBHost() string {
	e := os.Getenv("DB_HOST")

	if e == "" {
		return "127.0.0.1"
	}
	return e
}
