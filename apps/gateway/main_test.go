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
