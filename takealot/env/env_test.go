package env

import (
	"testing"
)

func TestLoadEnv_default(t *testing.T) {
	env := LoadEnv()
	if env.MasterNode {
		t.Error("Should be false")
	}

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
}
