package api

import (
	"encoding/json"
	"errors"
	"fmt"
	"github.com/go-resty/resty/v2"
	log "github.com/sirupsen/logrus"
)

const ProductUrlFormat = "https://api.takealot.com/rest/v-1-8-0/product-details/PLID%d?platform=desktop"
const PromotionsUrl = "https://api.takealot.com/rest/v-1-8-0/promotions"
const PLIDsOnPromotionUrlFormat = "https://api.takealot.com/rest/v-1-8-0/productlines/search?rows=100&daily_deals_rows=100&start=%d&detail=listing&filter=Available:true&filter=Promotions:%d"

func FetchPLIDsOnPromotion(promotionID uint) ([]uint, error) {
	var plIDS []uint
	start := 0
	lastPage := 1

	for start < lastPage {
		url := fmt.Sprintf(PLIDsOnPromotionUrlFormat, start, promotionID)
		client := resty.New().SetRedirectPolicy(resty.FlexibleRedirectPolicy(5))

		resp, err := client.R().Get(url)

		if err != nil {
			return nil, err
		}

		log.Debugf("fetch Product returned with HTTP status code: %d", resp.StatusCode())

		if !resp.IsSuccess() {
			log.Warnf("no promotion for promotionID: %d", promotionID)
			return nil, errors.New(fmt.Sprintf("no promotion for promotionID: %d", promotionID))
		}

		plIDsOnPromotion := &PLIDsOnPromotionResponse{}
		err = json.Unmarshal(resp.Body(), plIDsOnPromotion)

		if err != nil {
			return nil, err
		}

		lastPage = plIDsOnPromotion.Results.NumFound
		start++

		for _, pl := range plIDsOnPromotion.Results.ProductLines {
			plIDS = append(plIDS, pl.ID)
		}
	}

	return plIDS, nil
}

func FetchProduct(plID uint) (*ProductResponse, error) {
	url := fmt.Sprintf(ProductUrlFormat, plID)
	client := resty.New().SetRedirectPolicy(resty.FlexibleRedirectPolicy(5))

	resp, err := client.R().Get(url)

	if err != nil {
		return nil, err
	}

	log.Debugf("fetch Product returned with HTTP status code: %d", resp.StatusCode())

	if !resp.IsSuccess() {
		log.Warnf("no product for PLID: %d", plID)
		return nil, errors.New(fmt.Sprintf("no product for PLID: %d", plID))
	}

	pr := &ProductResponse{}
	err = json.Unmarshal(resp.Body(), pr)

	if err != nil {
		return nil, err
	}

	return pr, nil
}

func FetchPromotions() (*PromotionsResponse, error) {
	client := resty.New().SetRedirectPolicy(resty.FlexibleRedirectPolicy(5))

	resp, err := client.R().Get(PromotionsUrl)

	if err != nil {
		return nil, err
	}

	log.Debugf("fetch Product returned with HTTP status code: %d", resp.StatusCode())

	if !resp.IsSuccess() {
		log.Warnf("no promotions available")
		return nil, errors.New(fmt.Sprintf("no promotions available"))
	}

	promotions := &PromotionsResponse{}
	err = json.Unmarshal(resp.Body(), promotions)

	if err != nil {
		return nil, err
	}

	return promotions, nil
}
