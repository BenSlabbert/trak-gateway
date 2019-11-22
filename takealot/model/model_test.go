package model

import "testing"

func TestProductImageModel_FormatURL(t *testing.T) {
	productImageModel := &ProductImageModel{
		ID:        0,
		ProductID: 0,
		URLFormat: "https://media.takealot.com/covers_tsins/48075814/190198393173-1-{size}.jpg",
	}

	formattedURL := productImageModel.FormatURL(ProductImageSizeDefault)

	expectedURL := "https://media.takealot.com/covers_tsins/48075814/190198393173-1-pdpxl.jpg"
	if formattedURL != expectedURL {
		t.Errorf("%s should equal %s", formattedURL, expectedURL)
	}
}

func TestPriceModel_TableName(t *testing.T) {
	s := "price"

	m := &PriceModel{}
	if s != m.TableName() {
		t.Errorf("%s should equal %s", m.TableName(), s)
	}
}

func TestProductModel_TableName(t *testing.T) {
	s := "product"

	m := &ProductModel{}
	if s != m.TableName() {
		t.Errorf("%s should equal %s", m.TableName(), s)
	}
}

func TestCrawlerModel_TableName(t *testing.T) {
	s := "crawler"

	m := &CrawlerModel{}
	if s != m.TableName() {
		t.Errorf("%s should equal %s", m.TableName(), s)
	}
}

func TestProductImageModel_TableName(t *testing.T) {
	s := "product_image"

	m := &ProductImageModel{}
	if s != m.TableName() {
		t.Errorf("%s should equal %s", m.TableName(), s)
	}
}

func TestBrandModel_TableName(t *testing.T) {
	s := "brand"

	m := &BrandModel{}
	if s != m.TableName() {
		t.Errorf("%s should equal %s", m.TableName(), s)
	}
}

func TestProductCategoryLinkModel_TableName(t *testing.T) {
	s := "product_category_link"

	m := &ProductCategoryLinkModel{}
	if s != m.TableName() {
		t.Errorf("%s should equal %s", m.TableName(), s)
	}
}

func TestCategoryModel_TableName(t *testing.T) {
	s := "category"

	m := &CategoryModel{}
	if s != m.TableName() {
		t.Errorf("%s should equal %s", m.TableName(), s)
	}
}

func TestProductBrandLinkModel_TableName(t *testing.T) {
	s := "product_brand_link"

	m := &ProductBrandLinkModel{}
	if s != m.TableName() {
		t.Errorf("%s should equal %s", m.TableName(), s)
	}
}
