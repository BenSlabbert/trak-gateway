package api

type ProductResponse struct {
	ExchangesAndReturns struct {
		TabTitle string `json:"tab_title"`
		Copy     string `json:"copy"`
	} `json:"exchanges_and_returns"`
	OtherOffers struct {
		Conditions []struct {
			Count int `json:"count"`
			Items []struct {
				DeliveryCharges struct {
				} `json:"delivery_charges"`
				ProductID         int     `json:"product_id"`
				Price             float32 `json:"price"`
				StockAvailability struct {
					Status                 string      `json:"status"`
					IsLeadTime             bool        `json:"is_leadtime"`
					EvtStatus              string      `json:"evt_status"`
					WhenDoIGetItText       string      `json:"when_do_i_get_it_text"`
					IsImported             bool        `json:"is_imported"`
					IsInStock              bool        `json:"is_in_stock"`
					DisplaySeasonalMessage bool        `json:"display_seasonal_message"`
					SeasonalMessageText    interface{} `json:"seasonal_message_text"`
					Display                bool        `json:"display"`
					WhenDoIGetItInfo       string      `json:"when_do_i_get_it_info"`
				} `json:"stock_availability"`
				EventData struct {
					Documents struct {
						Product struct {
							SkuID              int     `json:"sku_id"`
							ProductLineID      int     `json:"product_line_id"`
							PurchasePrice      float32 `json:"purchase_price"`
							InStock            bool    `json:"in_stock"`
							MarketPlaceListing bool    `json:"market_place_listing"`
							LeadTime           string  `json:"lead_time"`
						} `json:"product"`
					} `json:"documents"`
				} `json:"event_data"`
				IsTakealot bool `json:"is_takealot"`
				Seller     struct {
					SellerID    int    `json:"seller_id"`
					DisplayName string `json:"display_name"`
				} `json:"seller"`
				ID string `json:"id"`
			} `json:"items"`
			FromPrice float32 `json:"from_price"`
			ID        string  `json:"id"`
			Condition string  `json:"condition"`
		} `json:"conditions"`
		Title string `json:"title"`
	} `json:"other_offers"`
	StockAvailability struct {
		Status              string `json:"status"`
		IsLeadtime          bool   `json:"is_leadtime"`
		DistributionCentres []struct {
			Text        string `json:"text"`
			InfoType    string `json:"info_type"`
			ID          string `json:"id"`
			Description string `json:"description"`
		} `json:"distribution_centres"`
		WhenDoIGetItText       string `json:"when_do_i_get_it_text"`
		IsImported             bool   `json:"is_imported"`
		DisplaySeasonalMessage bool   `json:"display_seasonal_message"`
		WhenDoIGetItInfo       string `json:"when_do_i_get_it_info"`
	} `json:"stock_availability"`
	Meta struct {
		LinkData struct {
			Path   string `json:"path"`
			Fields struct {
				Platform   string `json:"platform"`
				APIVersion string `json:"api_version"`
				PlID       string `json:"plid"`
			} `json:"fields"`
		} `json:"link_data"`
		Href          string `json:"href"`
		DateRetrieved string `json:"date_retrieved"`
		Identifier    string `json:"identifier"`
		Type          string `json:"type"`
		Display       bool   `json:"display"`
	} `json:"meta"`
	Seo struct {
		Title string `json:"title"`
	} `json:"seo"`
	Badges struct {
		Items []struct {
			Type  string `json:"type"`
			ID    string `json:"id"`
			Value string `json:"value"`
		} `json:"items"`
	} `json:"badges"`
	BuyBox struct {
		IsPreOrder      bool `json:"is_preorder"`
		DeliveryCharges struct {
		} `json:"delivery_charges"`
		ProductID     int    `json:"product_id"`
		AddToCartText string `json:"add_to_cart_text"`
		LoyaltyPrices []struct {
			DisplayText string    `json:"display_text"`
			Prices      []float32 `json:"prices"`
			ID          string    `json:"id"`
			InfoText    string    `json:"info_text,omitempty"`
		} `json:"loyalty_prices"`
		ProductLineID            int       `json:"product_line_id"`
		MultiBuyDisplay          bool      `json:"multibuy_display"`
		IsDigital                bool      `json:"is_digital"`
		IsFreeShippingAvailable  bool      `json:"is_free_shipping_available"`
		IsAddToWishlistAvailable bool      `json:"is_add_to_wishlist_available"`
		IsAddToCartAvailable     bool      `json:"is_add_to_cart_available"`
		Prices                   []float32 `json:"prices"`
		PrettyPrice              string    `json:"pretty_price"`
		ListingPrice             float32   `json:"listing_price"`
	} `json:"buybox"`
	Title       string `json:"title"`
	Breadcrumbs struct {
		Items []struct {
			Type string `json:"type"`
			ID   int    `json:"id"`
			Name string `json:"name"`
			Slug string `json:"slug"`
		} `json:"items"`
	} `json:"breadcrumbs"`
	CustomersAlsoBought struct {
		Href     string `json:"href"`
		LinkData struct {
			Path   string `json:"path"`
			Fields struct {
				Platform   string `json:"platform"`
				APIVersion string `json:"api_version"`
				PlID       string `json:"plid"`
			} `json:"fields"`
		} `json:"link_data"`
	} `json:"customers_also_bought"`
	TopNavigation struct {
		Items []struct {
			Foreground string `json:"foreground"`
			Text       string `json:"text"`
			Href       string `json:"href"`
			Background string `json:"background"`
			ID         string `json:"id"`
		} `json:"items"`
	} `json:"top_navigation"`
	ProductInformation struct {
		Items []struct {
			DisplayableText string `json:"displayable_text"`
			DisplayName     string `json:"display_name"`
			// todo fix
			//Value           [][]struct {
			//	Slug     string        `json:"slug"`
			//	ID       int           `json:"id"`
			//	Name     string        `json:"name"`
			//	Parent   interface{}   `json:"parent,omitempty"`
			//	Level    int           `json:"level,omitempty"`
			//	Dept     int           `json:"dept,omitempty"`
			//	Children []interface{} `json:"children,omitempty"`
			//} `json:"value"`
			Source      string `json:"source"`
			ContentType string `json:"content_type"`
			ID          string `json:"id"`
			ItemType    string `json:"item_type,omitempty"`
		} `json:"items"`
		TabTitle   string `json:"tab_title"`
		Categories struct {
			DisplayableText string `json:"displayable_text"`
			DisplayName     string `json:"display_name"`
			Value           [][]struct {
				Slug  string `json:"slug"`
				ID    int    `json:"id"`
				Name  string `json:"name"`
				Level int    `json:"level,omitempty"`
				Dept  int    `json:"dept,omitempty"`
			} `json:"value"`
			Source      string `json:"source"`
			ContentType string `json:"content_type"`
			ID          string `json:"id"`
		} `json:"categories"`
	} `json:"product_information"`
	DataLayer struct {
		Sku            uint     `json:"sku"`
		CategoryName   []string `json:"categoryname"`
		TotalPrice     float32  `json:"totalPrice"`
		Name           string   `json:"name"`
		ProductlineSKU string   `json:"productlineSku"`
		DepartmentName string   `json:"departmentname"`
		Event          string   `json:"event"`
		DepartmentID   int      `json:"departmentid"`
		PageType       string   `json:"pageType"`
		CategoryID     []uint   `json:"categoryid"`
		ProdID         string   `json:"prodid"`
		Quantity       int      `json:"quantity"`
	} `json:"data_layer"`
	DesktopHref string `json:"desktop_href"`
	EventData   struct {
		Documents struct {
			Product struct {
				OriginalPrice      float64 `json:"original_price"`
				SkuID              int     `json:"sku_id"`
				ProductLineID      int     `json:"product_line_id"`
				MarketPlaceListing bool    `json:"market_place_listing"`
				InStock            bool    `json:"in_stock"`
				PurchasePrice      float64 `json:"purchase_price"`
				LeadTime           string  `json:"lead_time"`
			} `json:"product"`
		} `json:"documents"`
	} `json:"event_data"`
	FlixMedia struct {
		Language         string `json:"language"`
		Ean              string `json:"ean"`
		Mpn              string `json:"mpn"`
		TabTitle         string `json:"tab_title"`
		Distributor      string `json:"distributor"`
		FallbackLanguage string `json:"fallback_language"`
	} `json:"flixmedia"`
	Core struct {
		Subtitle *string `json:"subtitle"`
		Title    string  `json:"title"`
		Brand    *string `json:"brand"`
		Formats  []struct {
			IDFormatType int    `json:"idFormatType"`
			Type         string `json:"type"`
			ID           int    `json:"id"`
			LinkData     struct {
				Action     string `json:"action"`
				Context    string `json:"context"`
				Parameters struct {
					Search struct {
						Filters struct {
							Available bool   `json:"Available"`
							Format    string `json:"Format"`
						} `json:"filters"`
					} `json:"search"`
				} `json:"parameters"`
			} `json:"link_data"`
			Name string `json:"name"`
		} `json:"formats"`
		Slug    string `json:"slug"`
		Authors []struct {
			IDAuthor int `json:"idAuthor"`
			LinkData struct {
				Fields struct {
					AuthorSlug string `json:"author_slug"`
				} `json:"fields"`
				Path string `json:"path"`
			} `json:"link_data"`
			Author string `json:"Author"`
		} `json:"authors"`
		ID int `json:"id"`
	} `json:"core"`
	Sharing struct {
		URL  string `json:"url"`
		Copy struct {
			Body struct {
				Email     string `json:"email"`
				Twitter   string `json:"twitter"`
				Facebook  string `json:"facebook"`
				Whatsapp  string `json:"whatsapp"`
				Pinterest string `json:"pinterest"`
			} `json:"body"`
			Subject struct {
				Email string `json:"email"`
			} `json:"subject"`
		} `json:"copy"`
		Enabled []string `json:"enabled"`
	} `json:"sharing"`
	Description struct {
		TabTitle string `json:"tab_title"`
		HTML     string `json:"html"`
	} `json:"description"`
	BulletPointAttributes struct {
		Items []struct {
			Description string `json:"description"`
			Positive    bool   `json:"positive"`
			Text        string `json:"text"`
			InfoMode    string `json:"info_mode"`
			Type        string `json:"type"`
			ID          string `json:"id"`
		} `json:"items"`
	} `json:"bullet_point_attributes"`
	Gallery struct {
		Images    []string `json:"images"`
		SizeGuide struct {
			Href     string `json:"href"`
			LinkData struct {
				Path   string `json:"path"`
				Fields struct {
					Platform   string `json:"platform"`
					APIVersion string `json:"api_version"`
				} `json:"fields"`
			} `json:"link_data"`
		} `json:"size_guide"`
	} `json:"gallery"`
	Reviews struct {
		Count    int `json:"count"`
		LinkData struct {
			Path   string `json:"path"`
			Fields struct {
				Platform   string `json:"platform"`
				APIVersion string `json:"api_version"`
				PlID       string `json:"plid"`
			} `json:"fields"`
		} `json:"link_data"`
		TabTitle string `json:"tab_title"`
		Href     string `json:"href"`
	} `json:"reviews"`
	FrequentlyBoughtTogether struct {
		Href     string `json:"href"`
		LinkData struct {
			Path   string `json:"path"`
			Fields struct {
				Platform   string `json:"platform"`
				APIVersion string `json:"api_version"`
				PlID       string `json:"plid"`
			} `json:"fields"`
		} `json:"link_data"`
	} `json:"frequently_bought_together"`
}

type PromotionsResponse struct {
	Response []struct {
		Name               string `json:"name"`
		ID                 uint   `json:"id"`
		Start              string `json:"start"`
		ShortDisplayName   string `json:"short_display_name"`
		End                string `json:"end"`
		QualifyingQuantity int    `json:"qualifying_quantity"`
		Active             bool   `json:"active"`
	} `json:"response"`
}

type PLIDsOnPromotionResponse struct {
	UUID    string `json:"uuid"`
	Results struct {
		NumFound     int `json:"num_found"`
		ProductLines []struct {
			Rating struct {
				Count   int     `json:"count"`
				Average float32 `json:"average"`
			} `json:"rating"`
			Exclusive       bool    `json:"exclusive"`
			WebSellingPrice float32 `json:"web_selling_price"`
			Saving          string  `json:"saving"`
			Availability    struct {
				Jhb      int  `json:"jhb"`
				Min      int  `json:"min"`
				Max      int  `json:"max"`
				Seller   bool `json:"seller"`
				Supplier bool `json:"supplier"`
				Cpt      int  `json:"cpt"`
			} `json:"availability"`
			SellerListingID int    `json:"sellerlistingid"`
			UUID            string `json:"uuid"`
			Title           string `json:"title"`
			Quotable        bool   `json:"quotable"`
			PromotePrice    bool   `json:"promote_price"`
			Prepaid         bool   `json:"prepaid"`
			Preselect       struct {
			} `json:"preselect"`
			Dailydeal      bool    `json:"dailydeal"`
			Reviews        int     `json:"reviews"`
			Voucher        bool    `json:"voucher"`
			SellingPrice   float32 `json:"selling_price"`
			ColourVariants bool    `json:"colourvariants"`
			HasVariants    bool    `json:"has_variants"`
			ID             uint    `json:"id"`
			Seller         struct {
				ID   int    `json:"id"`
				Name string `json:"name"`
			} `json:"seller"`
			DailyDealQty struct {
			} `json:"dailydeal_qty"`
			OldSellingPrice float32 `json:"old_selling_price"`
			BuyBoxUsed      struct {
				TotalResults      int     `json:"total_results"`
				IsTakealot        bool    `json:"is_takealot"`
				MinPrice          float32 `json:"min_price"`
				SubConditionTypes struct {
					Unboxed int `json:"unboxed"`
				} `json:"sub_condition_types"`
				SkuID int `json:"sku_id"`
			} `json:"buybox_used,omitempty"`
			Available bool `json:"available"`
			EBook     bool `json:"ebook"`
			HasSkus   bool `json:"has_skus"`
			Active    bool `json:"active"`
			BuyBox    struct {
				TotalResults int     `json:"total_results"`
				IsTakealot   bool    `json:"is_takealot"`
				MinPrice     float32 `json:"min_price"`
				SkuID        int     `json:"sku_id"`
			} `json:"buybox"`
			Promotions []struct {
				DealID                      int     `json:"deal_id"`
				Qty                         int     `json:"qty"`
				Showleftnav                 bool    `json:"showleftnav"`
				ID                          int     `json:"id"`
				ProductQualifyingQuantity   int     `json:"product_qualifying_quantity"`
				DisplayName                 string  `json:"display_name"`
				ShowTopNav                  bool    `json:"showtopnav"`
				ShowTimer                   bool    `json:"showtimer"`
				Start                       int     `json:"start"`
				ShowFlyOut                  bool    `json:"showflyout"`
				ShowSideBanner              bool    `json:"showsidebanner"`
				Price                       float32 `json:"price"`
				IsLeadTimeAllowed           bool    `json:"is_lead_time_allowed"`
				MarketingSubsidy            float32 `json:"marketing_subsidy"`
				Active                      bool    `json:"active"`
				End                         int     `json:"end"`
				LandingPage                 string  `json:"landingpage"`
				Name                        string  `json:"name"`
				PromotionQualifyingQuantity int     `json:"promotion_qualifying_quantity"`
				Position                    int     `json:"position"`
				GroupID                     int     `json:"group_id"`
				SupplierSubsidy             float32 `json:"supplier_subsidy"`
			} `json:"promotions"`
			WebSaving string `json:"web_saving"`
			Dates     struct {
				Released string `json:"released"`
			} `json:"dates"`
			ServerInfo struct {
				DataTimestamp string `json:"data_timestamp"`
				Ts            int    `json:"ts"`
				Server        string `json:"server"`
			} `json:"server_info"`
			Cover struct {
				URL      string `json:"url"`
				Filename string `json:"filename"`
				Modified int    `json:"modified"`
				Key      string `json:"key"`
				Size     int    `json:"size"`
			} `json:"cover"`
			URI         string `json:"uri"`
			Departments []int  `json:"departments"`
			Views       struct {
				Badges struct {
					Entries []struct {
						ID    string `json:"id"`
						Type  string `json:"type"`
						Value string `json:"value"`
					} `json:"entries"`
					AppEntries []struct {
						ID    string `json:"id"`
						Type  string `json:"type"`
						Value string `json:"value"`
					} `json:"app_entries"`
					PromotionID int `json:"promotion_id"`
				} `json:"badges"`
			} `json:"views"`
		} `json:"productlines"`
	} `json:"results"`
	Params struct {
		Version []string `json:"version"`
		Sort    []string `json:"sort"`
		Rows    []string `json:"rows"`
		Start   []string `json:"start"`
		Detail  []string `json:"detail"`
		Filter  []string `json:"filter"`
	} `json:"params"`
	Backend string `json:"backend"`
}

type BrandProductResponse struct {
	UUID    string `json:"uuid"`
	Results struct {
		Start            int    `json:"start"`
		NextIsAfter      string `json:"next_is_after"`
		PreviousIsBefore string `json:"previous_is_before"`
		NumFound         int    `json:"num_found"`
		Facets           []struct {
			Name        string `json:"name"`
			DisplayName string `json:"display_name"`
			Type        string `json:"type"`
			Entries     []struct {
				Filter      string `json:"filter"`
				Name        string `json:"name"`
				DisplayName string `json:"display_name"`
				NumDocs     int    `json:"num_docs"`
			} `json:"entries"`
		} `json:"facets"`
		Filters []struct {
			Filter       string `json:"filter"`
			Title        string `json:"title"`
			NumDocs      int    `json:"num_docs"`
			DisplayName  string `json:"display_name"`
			DisplayValue string `json:"display_value"`
			Type         string `json:"type"`
			Name         string `json:"name"`
		} `json:"filters"`
		Breadcrumbs  []interface{} `json:"breadcrumbs"`
		ProductLines []struct {
			ID                   string      `json:"id"`
			Title                string      `json:"title"`
			Subtitle             interface{} `json:"subtitle"`
			URI                  string      `json:"uri"`
			NonPromoSellingPrice int         `json:"non_promo_selling_price"`
			SellingPrice         int         `json:"selling_price"`
			WebSellingPrice      int         `json:"web_selling_price"`
			OldSellingPrice      int         `json:"old_selling_price"`
			StockCpt             int         `json:"stock_cpt"`
			StockJhb             int         `json:"stock_jhb"`
			StockSupplier        bool        `json:"stock_supplier"`
			StockOnHand          int         `json:"stock_on_hand"`
			IsAvailable          bool        `json:"is_available"`
			IsPrepaid            bool        `json:"is_prepaid"`
			IsVoucher            bool        `json:"is_voucher"`
			IsPreorder           bool        `json:"is_preorder"`
			IsLiquor             bool        `json:"is_liquor"`
			DateReleased         string      `json:"date_released"`
			HasSkus              bool        `json:"has_skus"`
			Image                struct {
				Small    string `json:"small"`
				Large    string `json:"large"`
				Listgrid string `json:"listgrid"`
				Fb       string `json:"fb"`
				Full     string `json:"full"`
			} `json:"image"`
			IsActive   bool `json:"is_active"`
			PriceRange struct {
			} `json:"price_range"`
			WebPriceRange struct {
			} `json:"web_price_range"`
			StarRating          float64       `json:"star_rating"`
			Saving              interface{}   `json:"saving"`
			WebSaving           interface{}   `json:"web_saving"`
			Exclusive           bool          `json:"exclusive"`
			DailyDeal           bool          `json:"dailydeal"`
			Promotions          interface{}   `json:"promotions"`
			Promos              []interface{} `json:"promos"`
			ShippingInformation struct {
				String          string   `json:"string"`
				InStock         bool     `json:"in_stock"`
				StockWarehouses []string `json:"stock_warehouses"`
			} `json:"shipping_information"`
			SkuID           int         `json:"sku_id"`
			Sellerlistingid interface{} `json:"sellerlistingid"`
			SellerID        interface{} `json:"seller_id"`
			SellerName      interface{} `json:"seller_name"`
			IsEbook         bool        `json:"is_ebook"`
			PromotionsQty   struct {
			} `json:"promotions_qty"`
			Authors     []interface{} `json:"authors"`
			Formats     []interface{} `json:"formats"`
			HasVariants bool          `json:"has_variants"`
			Variants    []interface{} `json:"variants"`
			Buybox      struct {
				MinPrice     float64 `json:"min_price"`
				TotalResults int     `json:"total_results"`
				IsTakealot   bool    `json:"is_takealot"`
				SkuID        int     `json:"sku_id"`
			} `json:"buybox"`
			Views struct {
				Badges struct {
					Entries     []interface{} `json:"entries"`
					AppEntries  []interface{} `json:"app_entries"`
					PromotionID interface{}   `json:"promotion_id"`
				} `json:"badges"`
			} `json:"views"`
		} `json:"productlines"`
	} `json:"results"`
	Params struct {
		Version []string `json:"version"`
		Rows    []string `json:"rows"`
		Start   []string `json:"start"`
		Detail  []string `json:"detail"`
		Filter  []string `json:"filter"`
	} `json:"params"`
	Backend string `json:"backend"`
}
