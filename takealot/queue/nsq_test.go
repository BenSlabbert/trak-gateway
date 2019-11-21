package queue

import (
	"testing"
	"time"
)

func TestPromotionsScheduledTask(t *testing.T) {
	if PromotionsScheduledTask.ID != PromotionsScheduledTaskID {
		t.Errorf("%d should equal: %d", PromotionsScheduledTask.ID, PromotionsScheduledTaskID)
	}

	nextRun := PromotionsScheduledTask.NextRun()

	now := time.Now().Add(24 * time.Hour)
	if nextRun.Hour() != 7 {
		t.Errorf("%d should equal: %d", nextRun.Hour(), 7)
	}
	if nextRun.Day() != now.Day() {
		t.Errorf("%d should equal: %d", nextRun.Hour(), now.Day())
	}
	if nextRun.Month() != now.Month() {
		t.Errorf("%d should equal: %d", nextRun.Month(), now.Month())
	}
	if nextRun.Year() != now.Year() {
		t.Errorf("%d should equal: %d", nextRun.Year(), now.Year())
	}

	firstRun := PromotionsScheduledTask.FirstRun()
	now = time.Now().Add(24 * time.Hour)

	if firstRun.Hour() != 7 {
		t.Errorf("%d should equal: %d", firstRun.Hour(), 7)
	}
	if firstRun.Day() != now.Day()-2 {
		t.Errorf("%d should equal: %d", firstRun.Hour(), now.Day())
	}
	if firstRun.Month() != now.Month() {
		t.Errorf("%d should equal: %d", firstRun.Month(), now.Month())
	}
	if firstRun.Year() != now.Year() {
		t.Errorf("%d should equal: %d", firstRun.Year(), now.Year())
	}
}

func TestPriceUpdateScheduledTask(t *testing.T) {
	if PriceUpdateScheduledTask.ID != PriceUpdateScheduledTaskTaskID {
		t.Errorf("%d should equal: %d", PriceUpdateScheduledTask.ID, PriceUpdateScheduledTaskTaskID)
	}

	nextRun := PriceUpdateScheduledTask.NextRun()

	now := time.Now().Add(24 * time.Hour)
	if nextRun.Hour() != 7 {
		t.Errorf("%d should equal: %d", nextRun.Hour(), 7)
	}
	if nextRun.Day() != now.Day() {
		t.Errorf("%d should equal: %d", nextRun.Hour(), now.Day())
	}
	if nextRun.Month() != now.Month() {
		t.Errorf("%d should equal: %d", nextRun.Month(), now.Month())
	}
	if nextRun.Year() != now.Year() {
		t.Errorf("%d should equal: %d", nextRun.Year(), now.Year())
	}

	firstRun := PriceUpdateScheduledTask.FirstRun()
	now = time.Now().Add(24 * time.Hour)

	if firstRun.Hour() != 7 {
		t.Errorf("%d should equal: %d", firstRun.Hour(), 7)
	}
	if firstRun.Day() != now.Day()-2 {
		t.Errorf("%d should equal: %d", firstRun.Hour(), now.Day())
	}
	if firstRun.Month() != now.Month() {
		t.Errorf("%d should equal: %d", firstRun.Month(), now.Month())
	}
	if firstRun.Year() != now.Year() {
		t.Errorf("%d should equal: %d", firstRun.Year(), now.Year())
	}
}

func TestBrandUpdateScheduledTask(t *testing.T) {
	if BrandUpdateScheduledTask.ID != BrandUpdateScheduledTaskTaskID {
		t.Errorf("%d should equal: %d", BrandUpdateScheduledTask.ID, BrandUpdateScheduledTaskTaskID)
	}

	nextRun := BrandUpdateScheduledTask.NextRun()

	now := time.Now()
	hour := now.Hour() + 2
	if nextRun.Hour() != hour {
		t.Errorf("%d should equal: %d", nextRun.Hour(), hour)
	}
	if nextRun.Day() != now.Day() {
		t.Errorf("%d should equal: %d", nextRun.Hour(), now.Day())
	}
	if nextRun.Month() != now.Month() {
		t.Errorf("%d should equal: %d", nextRun.Month(), now.Month())
	}
	if nextRun.Year() != now.Year() {
		t.Errorf("%d should equal: %d", nextRun.Year(), now.Year())
	}

	firstRun := BrandUpdateScheduledTask.FirstRun()
	now = time.Now().Add(2 * time.Hour)

	if firstRun.Hour() != now.Hour() {
		t.Errorf("%d should equal: %d", firstRun.Hour(), 7)
	}
	if firstRun.Day() != now.Day()-2 {
		t.Errorf("%d should equal: %d", firstRun.Hour(), now.Day())
	}
	if firstRun.Month() != now.Month() {
		t.Errorf("%d should equal: %d", firstRun.Month(), now.Month())
	}
	if firstRun.Year() != now.Year() {
		t.Errorf("%d should equal: %d", firstRun.Year(), now.Year())
	}
}

func TestDailyDealPriceUpdateScheduledTask(t *testing.T) {
	if DailyDealPriceUpdateScheduledTask.ID != DailyDealPriceUpdateScheduledTaskTaskID {
		t.Errorf("%d should equal: %d", BrandUpdateScheduledTask.ID, DailyDealPriceUpdateScheduledTaskTaskID)
	}

	nextRun := DailyDealPriceUpdateScheduledTask.NextRun()

	now := time.Now()
	hour := now.Hour() + 1
	if nextRun.Hour() != hour {
		t.Errorf("%d should equal: %d", nextRun.Hour(), hour)
	}
	if nextRun.Day() != now.Day() {
		t.Errorf("%d should equal: %d", nextRun.Hour(), now.Day())
	}
	if nextRun.Month() != now.Month() {
		t.Errorf("%d should equal: %d", nextRun.Month(), now.Month())
	}
	if nextRun.Year() != now.Year() {
		t.Errorf("%d should equal: %d", nextRun.Year(), now.Year())
	}

	firstRun := DailyDealPriceUpdateScheduledTask.FirstRun()
	now = time.Now().Add(1 * time.Hour)

	if firstRun.Hour() != now.Hour() {
		t.Errorf("%d should equal: %d", firstRun.Hour(), 7)
	}
	if firstRun.Day() != now.Day()-2 {
		t.Errorf("%d should equal: %d", firstRun.Hour(), now.Day())
	}
	if firstRun.Month() != now.Month() {
		t.Errorf("%d should equal: %d", firstRun.Month(), now.Month())
	}
	if firstRun.Year() != now.Year() {
		t.Errorf("%d should equal: %d", firstRun.Year(), now.Year())
	}
}
