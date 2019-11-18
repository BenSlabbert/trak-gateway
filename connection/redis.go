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
		return nil, errors.New("failed to obtain lock")
	} else if err != nil {
		log.Fatalln(err)
	}
	_, err = lock.TTL()
	if err != nil {
		return nil, errors.New("failed to obtain lock")
	}
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
