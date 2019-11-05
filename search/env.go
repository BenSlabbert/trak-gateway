package search

import (
	log "github.com/sirupsen/logrus"
	"os"
	"strconv"
)

type Env struct {
	SonicHost             string
	SonicPort             int
	SonicPassword         string
	SonicIngesterPoolSize int
	SonicSearchPoolSize   int
}

func LoadEnv() Env {
	return Env{
		SonicHost:             getSonicHost(),
		SonicPort:             getSonicPort(),
		SonicPassword:         getSonicPassword(),
		SonicIngesterPoolSize: getSonicIngestPoolSize(),
		SonicSearchPoolSize:   getSonicSearchPoolSize(),
	}
}

func getSonicSearchPoolSize() int {
	e := os.Getenv("SONIC_SEARCH_POOL_SIZE")

	if e == "" {
		log.Infof("using default search pool size: 2")
		return 2
	}

	i, err := strconv.ParseInt(e, 10, 0)

	if err != nil {
		log.Warnf("failed to parse %s as int, using default search pool size: 2", e)
		return 2
	}

	return int(i)
}

func getSonicIngestPoolSize() int {
	e := os.Getenv("SONIC_INGEST_POOL_SIZE")

	if e == "" {
		log.Infof("using default ingest pool size: 2")
		return 2
	}

	i, err := strconv.ParseInt(e, 10, 0)

	if err != nil {
		log.Warnf("failed to parse %s as int, using default ingest pool size: 2", e)
		return 2
	}

	return int(i)
}

func getSonicPassword() string {
	e := os.Getenv("SONIC_PASSWORD")

	if e == "" {
		log.Infof("using default sonic password")
		return "password"
	}

	return e
}

func getSonicPort() int {
	e := os.Getenv("SONIC_PORT")

	if e == "" {
		log.Infof("using default sonic port: 1491")
		return 1491
	}

	i, err := strconv.ParseInt(e, 10, 0)

	if err != nil {
		log.Warnf("failed to parse %s as int, using default sonic port: 1491", e)
		return 1491
	}

	return int(i)
}

func getSonicHost() string {
	e := os.Getenv("SONIC_HOST")

	if e == "" {
		log.Infof("using default sonic host: localhost")
		return "localhost"
	}

	return e
}
