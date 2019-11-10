package rest

import "testing"

func TestHandler_AddProduct_getPLID(t *testing.T) {
	h := &Handler{}
	plID, e := h.plIDFromURL("https://www.takealot.com/kenwood-hand-mixer-hm330/PLID17259217")

	if e != nil {
		t.Errorf("should not give an error: %v", e)
	}

	if plID != 17259217 {
		t.Errorf("%d should equal %d", plID, 17259217)
	}
}

func TestHandler_AddProduct_getPLID_notTakealotHost(t *testing.T) {
	h := &Handler{}
	plID, e := h.plIDFromURL("https://www.another-host.com/kenwood-hand-mixer-hm330/PLID17259217")

	if e == nil {
		t.Errorf("should give an error: %v", e)
	}

	if plID != 0 {
		t.Errorf("%d should equal %d", plID, 0)
	}
}

func TestHandler_AddProduct_getPLID_notEnoughSegments(t *testing.T) {
	h := &Handler{}
	plID, e := h.plIDFromURL("https://www.takealot.com/PLID123")

	if e == nil {
		t.Errorf("should give an error: %v", e)
	}

	if plID != 0 {
		t.Errorf("%d should equal %d", plID, 0)
	}
}

func TestHandler_AddProduct_getPLID_noPLID(t *testing.T) {
	h := &Handler{}
	plID, e := h.plIDFromURL("https://www.takealot.com/deals")

	if e == nil {
		t.Errorf("should give an error: %v", e)
	}

	if plID != 0 {
		t.Errorf("%d should equal %d", plID, 0)
	}
}
