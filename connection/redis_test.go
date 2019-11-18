package connection

import (
	"context"
	"fmt"
	"github.com/bsm/redislock"
	"github.com/go-redis/redis"
	log "github.com/sirupsen/logrus"
	"testing"

	"github.com/testcontainers/testcontainers-go"
)

func terminate(ctx context.Context, container testcontainers.Container) {
	if container.Terminate(ctx) != nil {
		log.Warnf("error while terminating container: %v", container.Terminate(ctx))
	}
}

func TestCreateRedisClient(t *testing.T) {
	ctx := context.Background()
	req := testcontainers.ContainerRequest{
		Image:        "redis:5.0.6-alpine",
		ExposedPorts: []string{"6379/tcp"},
	}
	redisC, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: req,
		Started:          true,
	})
	if err != nil {
		t.Error(err)
	}
	defer terminate(ctx, redisC)

	ip, err := redisC.Host(ctx)
	if err != nil {
		t.Error(err)
	}

	port, err := redisC.MappedPort(ctx, "6379")
	if err != nil {
		t.Error(err)
	}

	redisClient := redis.NewClient(&redis.Options{
		Network:    "tcp",
		Addr:       fmt.Sprintf("%s:%s", ip, port.Port()),
		MaxRetries: 3,
		PoolSize:   3,
		OnConnect:  onConnect,
	})

	lockClient := redislock.New(redisClient)

	lock, err := ObtainRedisLock(lockClient, "some-key")

	if err != nil {
		t.Errorf("should not have an error: %v", err)
	}

	if lock == nil {
		t.Error("should not be nil")
	}

	err = ReleaseRedisLock(lock)
	if err != nil {
		t.Errorf("should not have an error: %v", err)
	}

	CloseRedisClient(redisClient)
}
