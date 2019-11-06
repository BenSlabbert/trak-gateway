package connection

import (
	"context"
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
		PoolSize:   3,
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

func ObtainRedisLock(client *redislock.Client, key string) (*redislock.Lock, error) {
	options := &redislock.Options{
		RetryStrategy: redislock.LimitRetry(redislock.LinearBackoff(1*time.Second), 5),
		Metadata:      "",
		Context:       context.Background(),
	}
	lock, err := client.Obtain(key, 5*time.Second, options)
	if err == redislock.ErrNotObtained {
		log.Warnf("could not obtain lock: %s", key)
		return nil, errors.New("failed to obtain lock")
	} else if err != nil {
		log.Fatalln(err)
	}
	duration, err := lock.TTL()
	if err != nil {
		log.Warnf("failed to get lock ttl: %v", err)
		return nil, errors.New("failed to obtain lock")
	}
	log.Debugf("obtained lock with duration: %s key: %s", duration.String(), key)
	return lock, nil
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
