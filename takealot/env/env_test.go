package env

import (
	"testing"
)

func TestLoadEnv_default(t *testing.T) {
	env := LoadEnv()

	// node type
	if env.MasterNode {
		t.Error("Should be false")
	}

	// db env
	if env.DB.Host != "127.0.0.1" {
		t.Errorf("%s Should be 127.0.0.1", env.DB.Host)
	}

	if env.DB.Database != "trak" {
		t.Errorf("%s Should be trak", env.DB.Database)
	}

	if env.DB.Password != "password" {
		t.Errorf("%s Should be password", env.DB.Password)
	}

	if env.DB.Username != "user" {
		t.Errorf("%s Should be user", env.DB.Username)
	}

	if env.DB.Port != 3306 {
		t.Errorf("%d Should be 3306", env.DB.Port)
	}

	// redis
	if env.Redis.URL != "127.0.0.1:6379" {
		t.Errorf("%s Should be 127.0.0.1:6379", env.Redis.URL)
	}

	if env.Redis.Password != "password" {
		t.Errorf("%s Should be password", env.Redis.Password)
	}

	// nsq
	if env.Nsq.NsqdURL != "127.0.0.1:4150" {
		t.Errorf("%s Should be 127.0.0.1:4150", env.Nsq.NsqdURL)
	}

	if env.Nsq.NumberOfNewProductConsumers != 3 {
		t.Errorf("%d Should be 3", env.Nsq.NumberOfNewProductConsumers)
	}

	if env.Nsq.NumberOfScheduledTaskConsumers != 1 {
		t.Errorf("%d Should be 1", env.Nsq.NumberOfScheduledTaskConsumers)
	}

	// pprof
	if env.PPROFEnv.PPROFPort != 8080 {
		t.Errorf("%d Should be 8080", env.PPROFEnv.PPROFPort)
	}

	if env.PPROFEnv.PPROFEnabled {
		t.Error("Should be false")
	}

	// crawler
	if env.Crawler.TakealotInitialPLID != 41469985 {
		t.Errorf("%d Should be 41469985", env.Crawler.TakealotInitialPLID)
	}

	if env.Crawler.NumberOfNewProductTasks != 10 {
		t.Errorf("%d Should be 10", env.Crawler.NumberOfNewProductTasks)
	}

	if env.Crawler.Enabled {
		t.Error("Should be false")
	}

	// ui
	if env.UI.Path != "/static" {
		t.Errorf("%s Should be /static", env.UI.Path)
	}

	if env.UI.ReleaseAssetURL != "https://github.com/BenSlabbert/trak-ui/releases/download/2.0.0/ui.zip" {
		t.Errorf("%s Should be https://github.com/BenSlabbert/trak-ui/releases/download/2.0.0/ui.zip", env.UI.ReleaseAssetURL)
	}
}
