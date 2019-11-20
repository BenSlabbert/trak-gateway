package api

import (
	"encoding/json"
	"fmt"
	"github.com/go-resty/resty/v2"
	log "github.com/sirupsen/logrus"
	"strconv"
	"strings"
	"time"
)

const ProductUrlFormat = "https://api.takealot.com/rest/v-1-8-0/product-details/PLID%d?platform=desktop"
const PromotionsUrl = "https://api.takealot.com/rest/v-1-8-0/promotions"
const PLIDsOnPromotionUrlFormat = "https://api.takealot.com/rest/v-1-8-0/productlines/search?rows=100&daily_deals_rows=100&start=%d&detail=listing&filter=Available:true&filter=Promotions:%d"
const BrandProductUrlFormat = "https://api.takealot.com/rest/v-1-9-0/productlines/search?rows=100&start=%d&detail=mlisting&filter=Available:true&filter=Brand:%s"

func FetchBrandPLIDs(brand string) ([]uint, error) {
	plIDS := make([]uint, 0)
	start := 0

	for {
		url := fmt.Sprintf(BrandProductUrlFormat, start, brand)
		client := resty.New().
			SetRedirectPolicy(resty.FlexibleRedirectPolicy(5)).
			SetTimeout(10 * time.Second)

		resp, err := client.R().Get(url)

		if err != nil {
			return nil, err
		}

		log.Debugf("FetchBrandPLIDs returned with HTTP status code: %d", resp.StatusCode())

		if !resp.IsSuccess() {
			return nil, fmt.Errorf(fmt.Sprintf("no brand with name: %s", brand))
		}

		brandProducts := &BrandProductResponse{}
		err = json.Unmarshal(resp.Body(), brandProducts)

		if err != nil {
			return nil, err
		}

		start += 100

		if len(brandProducts.Results.ProductLines) == 0 {
			break
		}

		for _, pl := range brandProducts.Results.ProductLines {
			if strings.HasPrefix(pl.ID, "PLID") {
				plID, err := strconv.ParseUint(pl.ID[4:], 10, 32)
				if err != nil {
					log.Warnf("%s: unable to convert: %s to uint", brand, pl.ID[4:])
					continue
				}
				plIDS = append(plIDS, uint(plID))
			}
		}
	}

	return plIDS, nil
}

// this can take a while...
func FetchPLIDsOnPromotion(promotionID uint) ([]uint, error) {
	plIDS := make([]uint, 0)
	start := 0

	for {
		url := fmt.Sprintf(PLIDsOnPromotionUrlFormat, start, promotionID)
		client := resty.New().
			SetRedirectPolicy(resty.FlexibleRedirectPolicy(5)).
			SetTimeout(10 * time.Second)

		resp, err := client.R().Get(url)

		if err != nil {
			return nil, err
		}

		log.Debugf("FetchPLIDsOnPromotion returned with HTTP status code: %d", resp.StatusCode())

		if !resp.IsSuccess() {
			log.Warnf("no promotion for promotionID: %d", promotionID)
			return nil, fmt.Errorf(fmt.Sprintf("no promotion for promotionID: %d", promotionID))
		}

		plIDsOnPromotion := &PLIDsOnPromotionResponse{}
		err = json.Unmarshal(resp.Body(), plIDsOnPromotion)

		if err != nil {
			return nil, err
		}

		start += 100

		if len(plIDsOnPromotion.Results.ProductLines) == 0 {
			break
		}

		for _, pl := range plIDsOnPromotion.Results.ProductLines {
			plIDS = append(plIDS, pl.ID)
		}
	}

	return plIDS, nil
}

func FetchProduct(plID uint) (*ProductResponse, error) {
	url := fmt.Sprintf(ProductUrlFormat, plID)
	client := resty.New().
		SetRedirectPolicy(resty.FlexibleRedirectPolicy(5)).
		SetTimeout(10 * time.Second)

	resp, err := client.R().Get(url)
	client.GetClient().CloseIdleConnections()

	if err != nil {
		return nil, err
	}

	if !resp.IsSuccess() {
		return nil, fmt.Errorf(fmt.Sprintf("no product for PLID: %d", plID))
	}

	pr := &ProductResponse{}
	err = json.Unmarshal(resp.Body(), pr)

	if err != nil {
		return nil, err
	}

	return pr, nil
}

func FetchPromotions() (*PromotionsResponse, error) {
	client := resty.New().
		SetRedirectPolicy(resty.FlexibleRedirectPolicy(5)).
		SetTimeout(10 * time.Second)
	resp, err := client.R().Get(PromotionsUrl)

	client.GetClient().CloseIdleConnections()
	if err != nil {
		return nil, err
	}

	log.Debugf("FetchPromotions returned with HTTP status code: %d", resp.StatusCode())

	if !resp.IsSuccess() {
		log.Warnf("no promotions available")
		return nil, fmt.Errorf(fmt.Sprintf("no promotions available"))
	}

	promotions := &PromotionsResponse{}
	err = json.Unmarshal(resp.Body(), promotions)

	if err != nil {
		return nil, err
	}

	return promotions, nil
}
