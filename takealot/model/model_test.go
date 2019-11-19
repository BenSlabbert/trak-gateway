package model

import (
	"context"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	log "github.com/sirupsen/logrus"
	"github.com/testcontainers/testcontainers-go"
	"github.com/testcontainers/testcontainers-go/wait"
	"os"
	"path/filepath"
	"testing"
	"time"
	"trak-gateway/connection"
)

// set up test infrastructure for all tests in this package
func TestMain(m *testing.M) {
	ctx, mariadbC := setUpMariaDB()
	defer terminate(ctx, mariadbC)
	os.Exit(m.Run())
}

var MariaDBContainerIP string
var MariaDBContainerPort int

const DB = "trak"
const Username = "user"
const Password = "password"

func setUpMariaDB() (context.Context, testcontainers.Container) {
	mounts := make(map[string]string)
	absPath, _ := filepath.Abs("../../test_assets/trak.sql")
	mounts[absPath] = "/docker-entrypoint-initdb.d/trak.sql"

	env := make(map[string]string)
	env["MYSQL_ROOT_PASSWORD"] = "root"
	env["MYSQL_DATABASE"] = DB
	env["MYSQL_USER"] = Username
	env["MYSQL_PASSWORD"] = Password

	ctx := context.Background()
	req := testcontainers.ContainerRequest{
		Image:        "mariadb:10.4.8-bionic",
		ExposedPorts: []string{"3306/tcp"},
		Env:          env,
		BindMounts:   mounts,
		WaitingFor: wait.ForLog("Version: '10.4.8-MariaDB-1:10.4.8+maria~bionic'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  mariadb.org binary distribution").
			WithPollInterval(1 * time.Second).
			WithStartupTimeout(5 * time.Minute),
	}
	mariadbC, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: req,
		Started:          true,
	})

	if err != nil {
		log.Error(err)
	}

	ip, err := mariadbC.Host(ctx)
	if err != nil {
		log.Error(err)
	}

	port, err := mariadbC.MappedPort(ctx, "3306")
	if err != nil {
		log.Error(err)
	}

	opts := connection.MariaDBConnectOpts{
		Host:            ip,
		Port:            port.Int(),
		Database:        "trak",
		User:            "user",
		Password:        "password",
		ConnMaxLifetime: time.Hour,
		MaxIdleConns:    10,
		MaxOpenConns:    100,
	}

	db, err := connection.GetMariaDB(opts)

	if err != nil {
		log.Errorf("should have no errors: %v", err)
	}

	if db == nil {
		log.Error("should not be nil")
	}

	MigrateModels(db)

	connection.CloseMariaDB(db)

	MariaDBContainerIP = ip
	MariaDBContainerPort = port.Int()

	return ctx, mariadbC
}

func getDB(t *testing.T) *gorm.DB {
	opts := connection.MariaDBConnectOpts{
		Host:            MariaDBContainerIP,
		Port:            MariaDBContainerPort,
		Database:        DB,
		User:            Username,
		Password:        Password,
		ConnMaxLifetime: time.Hour,
		MaxIdleConns:    10,
		MaxOpenConns:    100,
	}
	db, err := connection.GetMariaDB(opts)
	if err != nil {
		t.Errorf("should have no errors: %v", err)
	}
	if db == nil {
		t.Error("should not be nil")
	}
	return db
}

func terminate(ctx context.Context, container testcontainers.Container) {
	if container.Terminate(ctx) != nil {
		log.Warnf("error while terminating container: %v", container.Terminate(ctx))
	}
}

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
