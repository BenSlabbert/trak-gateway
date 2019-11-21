package api

import (
	"encoding/json"
	"io/ioutil"
	"path/filepath"
	"testing"
)

func TestUrls(t *testing.T) {
	expected := "https://api.takealot.com/rest/v-1-8-0/product-details/PLID%d?platform=desktop"
	if ProductUrlFormat != expected {
		t.Errorf("%s should equal %s", ProductUrlFormat, expected)
	}

	expected = "https://api.takealot.com/rest/v-1-8-0/promotions"
	if PromotionsUrl != expected {
		t.Errorf("%s should equal %s", ProductUrlFormat, expected)
	}
}

func TestFetchPLIDsOnPromotion(t *testing.T) {
	fullPath, e := filepath.Abs("./test_plids_on_promotion_test.json")
	if e != nil {
		t.Errorf("Should not have errors: %v", e)
	}

	dat, e := ioutil.ReadFile(fullPath)

	if e != nil {
		t.Errorf("Should not have errors: %v", e)
	}

	resp := &PLIDsOnPromotionResponse{}
	e = json.Unmarshal(dat, resp)

	if e != nil {
		t.Errorf("Should not have errors: %v", e)
	}

	response, e := FetchPLIDsOnPromotion(58597)

	if e != nil {
		t.Errorf("Should not have errors: %v", e)
	}

	if response == nil {
		t.Error("Should return an array")
	}
}

func TestFetchPromotions(t *testing.T) {
	fullPath, e := filepath.Abs("./test_promotions_response.json")
	if e != nil {
		t.Errorf("Should not have errors: %v", e)
	}

	dat, e := ioutil.ReadFile(fullPath)

	if e != nil {
		t.Errorf("Should not have errors: %v", e)
	}

	resp := &PromotionsResponse{}
	e = json.Unmarshal(dat, resp)

	if e != nil {
		t.Errorf("Should not have errors: %v", e)
	}

	resp, e = FetchPromotions()

	if e != nil {
		t.Errorf("Should not have errors: %v", e)
	}

	if resp == nil {
		t.Error("Response should not be nil")
	}
}

func TestFetchProduct(t *testing.T) {
	fullPath, e := filepath.Abs("./test_product_response.json")
	if e != nil {
		t.Errorf("Should not have errors: %v", e)
	}

	dat, e := ioutil.ReadFile(fullPath)

	if e != nil {
		t.Errorf("Should not have errors: %v", e)
	}

	pr := &ProductResponse{}
	e = json.Unmarshal(dat, pr)

	if e != nil {
		t.Errorf("Should not have errors: %v", e)
	}

	productResponse, e := FetchProduct(48894338)

	if e == nil {
		t.Errorf("Should have error: %v", e)
	}

	if productResponse != nil {
		t.Error("Response should be nil")
	}
}
