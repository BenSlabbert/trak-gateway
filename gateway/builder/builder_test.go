package builder

import "testing"

func TestProductMessageBuilder_Build(t *testing.T) {
	pmb := ProductMessageBuilder{}
	msg, err := pmb.Build()

	if err == nil {
		t.Error("there should be an error")
	}

	if msg != nil {
		t.Error("the msg should be nil")
	}
}

func TestProductStatsBuilder_Build(t *testing.T) {
	pmb := ProductStatsBuilder{}
	msg, err := pmb.Build()

	if err == nil {
		t.Error("there should be an error")
	}

	if msg != nil {
		t.Error("the msg should be nil")
	}
}
