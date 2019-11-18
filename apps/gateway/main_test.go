package main

import (
	"testing"
	"trak-gateway/takealot/env"
)

func TestDownloadAndExtractUIAssets(t *testing.T) {
	ui := env.UI{
		Path:            "/tmp/trak",
		ReleaseAssetURL: env.LoadEnv().UI.ReleaseAssetURL,
	}
	DownloadAndExtractUIAssets(ui)
}

func TestCleanDir(t *testing.T) {
	e := CleanDir("/tmp/trak")

	if e != nil {
		t.Errorf("should not give an error: %v", e)
	}
}
