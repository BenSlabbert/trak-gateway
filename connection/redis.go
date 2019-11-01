package connection

import (
	"errors"
	"github.com/bsm/redislock"
	"github.com/go-redis/redis"
	log "github.com/sirupsen/logrus"
	"time"
	"trak-gateway/takealot/env"
)

func CreateRedisClient() *redis.Client {
	e := env.LoadEnv()
	return redis.NewClient(&redis.Options{
		Network:    "tcp",
		Addr:       e.Redis.URL,
		Password:   e.Redis.Password,
		MaxRetries: 3,
		PoolSize:   1,
		OnConnect:  onConnect,
	})
}

func ReleaseRedisLock(lock *redislock.Lock) error {
	if e := lock.Release(); e != nil {
		log.Warnf("failed to release redis lock: %s %v", lock.Key(), e)
		return errors.New("failed to release redis lock")
	}
	return nil
}

func ObtainRedisLock(client *redislock.Client, key string) *redislock.Lock {
	lock, err := client.Obtain(key, 5*time.Second, nil)
	if err == redislock.ErrNotObtained {
		log.Warnf("could not obtain lock: %s, sleep and retry...", key)
		<-time.NewTicker(250 * time.Millisecond).C
		return ObtainRedisLock(client, key)
	} else if err != nil {
		log.Fatalln(err)
	}
	log.Debugf("obtained lock with key: %s", key)
	return lock
}

func CloseRedisClient(client *redis.Client) {
	e := client.Close()
	if e != nil {
		log.Warnf("failed to close redis client: %v", e)
	}
}

func onConnect(conn *redis.Conn) error {
	log.Debugf("%s connected to redis", conn.ClientID().String())
	return nil
}
