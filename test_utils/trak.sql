CREATE TABLE product
(
    id         int UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    created_at timestamp    NULL,
    updated_at timestamp    NULL,
    deleted_at timestamp    NULL,
    pl_id      int UNSIGNED NULL,
    sku        int UNSIGNED NULL,
    title      varchar(255) NULL,
    subtitle   varchar(255) NULL,
    url        text         NULL,
    CONSTRAINT uix_product_pl_id
        UNIQUE (pl_id)
);

CREATE TABLE brand
(
    id         int UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    created_at timestamp    NULL,
    updated_at timestamp    NULL,
    deleted_at timestamp    NULL,
    name       varchar(255) NULL,
    CONSTRAINT uix_brand_name
        UNIQUE (name)
);

CREATE TABLE product_brand_link
(
    id         int UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    product_id int UNSIGNED NULL,
    brand_id   int UNSIGNED NULL
);

CREATE TABLE price
(
    id            int UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    created_at    timestamp    NULL,
    updated_at    timestamp    NULL,
    deleted_at    timestamp    NULL,
    product_id    int UNSIGNED NULL,
    list_price    double       NULL,
    current_price double       NULL
#     CONSTRAINT price_product_id_product_id_
#         FOREIGN KEY (product_id) REFERENCES product (id)
);

CREATE TABLE category
(
    id         int UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    created_at timestamp    NULL,
    updated_at timestamp    NULL,
    deleted_at timestamp    NULL,
    name       varchar(255) NULL,
    CONSTRAINT uix_category_name
        UNIQUE (name)
);

CREATE TABLE promotion
(
    id           int UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    created_at   timestamp    NULL,
    updated_at   timestamp    NULL,
    deleted_at   timestamp    NULL,
    promotion_id int UNSIGNED NULL,
    name         varchar(255) NULL,
    display_name varchar(255) NULL,
    start        varchar(255) NULL,
    end          varchar(255) NULL,
    CONSTRAINT uix_promotion_promotion_id
        UNIQUE (promotion_id)
);

CREATE TABLE scheduled_task
(
    id         int UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    created_at timestamp    NULL,
    updated_at timestamp    NULL,
    deleted_at timestamp    NULL,
    name       varchar(255) NULL,
    last_run   timestamp    NULL,
    next_run   timestamp    NULL,
    CONSTRAINT uix_scheduled_task_name
        UNIQUE (name)
);

CREATE TABLE product_category_link
(
    id          int UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    product_id  int UNSIGNED NULL,
    category_id int UNSIGNED NULL
);

CREATE TABLE product_image
(
    id         int UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    product_id int UNSIGNED NULL,
    url_format text         NULL
#     CONSTRAINT product_image_product_id_product_id_foreign
#         FOREIGN KEY (product_id) REFERENCES product (id)
);

CREATE TABLE product_promotion_link
(
    id            int UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    product_pl_id int UNSIGNED NULL,
    promotion_id  int UNSIGNED NULL
);

CREATE TABLE crawler
(
    id         int UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    created_at timestamp    NULL,
    updated_at timestamp    NULL,
    deleted_at timestamp    NULL,
    name       varchar(255) NULL,
    last_pl_id int UNSIGNED NULL,
    CONSTRAINT uix_crawler_name
        UNIQUE (name)
);

INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:35', '2019-11-18 22:17:35', NULL, 'UNKNOWN');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 'Krusell');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'Samsung');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'Croxley');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'ASUS');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'Huawei');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 'HP');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 'Philips');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'Tamron');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'Casio');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'Apple');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'Hercules');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'Sigma');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'Xiaomi');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'Melissa & Doug');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'Olympus');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'Nintendo');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'Vanish');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'Nerf');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'Djeco');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'Finish');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'Xbox');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 'Epson');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 'L''OR');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 'Fitbit');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 'Voss');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 'Shield Auto');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 'Canon');
INSERT INTO trak.brand (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 'Sony Playstation');


INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 'CELLPHONES & WEARABLES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 'CELLULAR ACCESSORIES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 'SCREEN PROTECTORS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 'CASES & COVERS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'CELLPHONES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'SMARTPHONES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'ACCOUNTING & LOG BOOKS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'ACCOUNTING BOOKS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'OFFICE & STATIONERY');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'STATIONERY');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'STUDENT SUPPLIES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'NOTEBOOKS & WRITING PADS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'HARD COVER BOOKS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'OFFICE SUPPLIES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, '2-IN-1');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'NOTEBOOKS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'COMPUTERS & TABLETS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 'LAPTOPS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 'OFFICE');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 'PRINTERS, SCANNERS & COPIERS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 'PRINTERS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 'INKJET PRINTERS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 'HEALTH');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 'PERSONAL CARE');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 'SHAVING & HAIR REMOVAL');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 'SHAVING EQUIPMENT & DEVICES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 'SHAVERS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 'HAIR REMOVAL');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 'MEN''S GROOMING');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 'BEAUTY');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'ORAL CARE');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'TOOTHBRUSHES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'ELECTRIC TOOTHBRUSHES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'CAMERAS & LENSES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'LENSES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'ZOOM');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'CAMERAS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'BODY CARE');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'MUSIC');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'MUSICAL INSTRUMENTS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'KEYBOARDS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'ELECTRONIC KEYBOARD');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'TELEPHOTO');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'DJ & MUSIC PRODUCTION GEAR');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'ACTION CAMERAS & DRONES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 'DRONES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'MAGNETIC');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'GAMES & PUZZLES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'PUZZLES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'PEGGED PUZZLES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'TOYS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'INDOOR PLAY');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'BUILDING & CONSTRUCTION');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'GAMING');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'CONSOLES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'HOME & KITCHEN');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'HOUSEHOLD & FOOD');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'LAUNDRY');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'STAIN REMOVERS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'HOBBY TOYS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'RC VEHICLES & PARTS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'EDUCATIONAL TOYS (STEM)');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'MATHEMATICS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'DRESS UP & ROLEPLAY');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'ACCESSORIES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'FASHION DOLLS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'HOUSEHOLD CLEANING');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'PRETEND PLAY');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'DISHWASHING');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'TABLETS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'DOLLS & ACCESSORIES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 'GAMES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 'BOARD GAMES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 'KIDS BOARD GAMES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 'INK TANK PRINTERS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 'FIGURINES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 'ACTION FIGURES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 'SMALL KITCHEN APPLIANCES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 'MERCHANDISE');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 'COFFEE & TEA');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 'COLLECTABLES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 'COFFEE & TEA SUPPLIES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 'CAPSULES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 'WEARABLES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 'ACTIVITY TRACKERS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 'LUGGAGE & TRAVEL');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 'LUGGAGE');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 'CABIN CASES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 'POLISHES');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 'DIY TOOLS & MACHINERY');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 'POWER TOOLS & MACHINERY');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 'DIY POWER TOOLS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 'SANDERS, PLANERS & POLISHERS');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 'GARDEN, POOL & PATIO');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 'AUTOMOTIVE');
INSERT INTO trak.category (created_at, updated_at, deleted_at, name)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 'CAR CARE & CLEANING');


INSERT INTO trak.crawler (created_at, updated_at, deleted_at, name, last_pl_id)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 'Takealot', 41469995);

INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 16);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 15);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 14);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 13);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 12);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 11);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 10);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 9);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 8);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 7);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 6);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 5);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 4);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 3);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 1);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 1);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 1, 194, 2);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 2, 0, 49);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 3, 349, 159);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 4, 6499, 3999);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 5, 275, 65);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 6, 5199, 3999);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 7, 7999, 3999);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 8, 1999, 941);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 9, 6499, 4499);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 10, 6499, 3999);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 11, 1399, 1249);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 12, 1399, 1249);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 13, 4499, 3999);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 14, 1299, 619);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 15, 6699, 5799);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 16, 6699, 5799);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 17, 538, 538);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 18, 6499, 3999);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 19, 7999, 5995);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 20, 4699, 3699);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 21, 7999, 5995);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 22, 440, 440);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 23, 2869, 2489);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 24, 1099, 689);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 25, 2999, 1695);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 27, 13499, 12749);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 26, 12619, 11289);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 28, 4899, 3599);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 29, 11699, 10989);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 30, 1499, 999);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 31, 195, 195);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 32, 2869, 2489);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 33, 385, 385);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 34, 8489, 7699);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 35, 6499, 5899);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 36, 195, 195);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 37, 169, 129);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 38, 389, 439);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 39, 395, 350);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 40, 158, 129);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 41, 12619, 11289);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 42, 195, 195);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 43, 179, 159);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 44, 899, 399);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 45, 5999, 4999);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 46, 167, 159);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 47, 7499, 5999);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 48, 5999, 4999);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 49, 179, 159);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 45, 5999, 4999);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 50, 899, 399);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 51, 225, 159);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 52, 899, 399);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 54, 499, 125);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 53, 89, 59);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 55, 499, 269);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 56, 5999, 5499);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 57, 5199, 5199);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 58, 1999, 1499);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 59, 2989, 2789);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 60, 8999, 7999);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 61, 899, 399);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 62, 89, 59);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 63, 8999, 7999);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 56, 5999, 5499);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 64, 8499, 7899);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 65, 5999, 5499);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 66, 699, 449);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 67, 449, 275);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 68, 499, 229);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 69, 180, 95);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 70, 899, 449);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 71, 1495, 1449);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 72, 735, 599);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 73, 399, 199);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 74, 449, 275);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 75, 8589, 8289);
INSERT INTO trak.price (created_at, updated_at, deleted_at, product_id, list_price, current_price)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 76, 568, 249);

INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 41469993, 44239712,
        'Krusell Boden Cover for the HTC One M9 - Transparent Black', '90057',
        'https://www.takealot.com/krusell-boden-cover-for-the-htc-one-m9-transparent-black/PLID41469993');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 32846180, 44239710,
        'Krusell Tierp - Screen Protector for the Sony Xperia Z3/Z3 Dual - Clear', '20204',
        'https://www.takealot.com/krusell-tierp-screen-protector-for-the-sony-xperia-z3-z3-dual-clear/PLID41469991');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 41469994, 44239713,
        'Krusell Malmo FlipCase for the Nokia Lumia 1320 - Black ', '75676',
        'https://www.takealot.com/krusell-malmo-flipcase-for-the-nokia-lumia-1320-black/PLID41469994');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 53469865, 56456231,
        'Samsung Galaxy A7 64GB (2018) Single Sim - Blue', '',
        'https://www.takealot.com/samsung-galaxy-a7-64gb-2018-single-sim-blue/PLID53469865');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 28026441, 30629663,
        'Croxley JD150 2-Quire 192 Page F&M Counter Book', 'Feint Ruled | 297 x 138mm',
        'https://www.takealot.com/croxley-jd150-2-quire-192-page-f-m-counter-book/PLID28026441');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 54711273, 57767350,
        'ASUS Transformer 10 - Z8350 2GB 64GB EMMC 10.1" Notebook - Grey', 'Quad-Core Atom | 2GB | 64GB EMMC | 10.1"',
        'https://www.takealot.com/asus-transformer-10-z8350-2gb-64gb-emmc-10-1-notebook-grey/PLID54711273');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:47', '2019-11-18 22:17:47', NULL, 53331013, 56311929, 'Huawei P10 64GB Dual Sim - Silver', '',
        'https://www.takealot.com/huawei-p10-64gb-dual-sim-silver/PLID53331013');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 44051487, 46879292,
        'HP OfficeJet Pro 6960 4-in-1 Wi-Fi Inkjet Printer', 'J7K33A',
        'https://www.takealot.com/hp-officejet-pro-6960-4-in-1-wi-fi-inkjet-printer/PLID44051487');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 55063197, 58137174,
        'HP OfficeJet Pro 9023 4-in-1 Wi-Fi Inkjet Printer ', '1MR70B',
        'https://www.takealot.com/hp-officejet-pro-9023-4-in-1-wi-fi-inkjet-printer/PLID55063197');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 54496023, 57509590,
        'Samsung Galaxy A7 64GB (2018) Single Sim - Black', '',
        'https://www.takealot.com/samsung-galaxy-a7-64gb-2018-single-sim-black/PLID54496023');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 54496776, 57511129,
        'Samsung Galaxy A2 Core 8GB Dual Sim - Blue', 'SM-A260FZBDXFA',
        'https://www.takealot.com/samsung-galaxy-a2-core-8gb-dual-sim-blue/PLID54496776');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 54496777, 57511130,
        'Samsung Galaxy A2 Core 8GB Dual Sim - Dark Grey', 'SM-A260FZKDXFA',
        'https://www.takealot.com/samsung-galaxy-a2-core-8gb-dual-sim-dark-grey/PLID54496777');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 44948410, 47795157, 'Huawei P10 64GB Dual Sim - Black', '',
        'https://www.takealot.com/huawei-p10-64gb-dual-sim-black/PLID44948410');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 28038139, 30642043, 'Philips AT 790 Aqua Touch Shaver',
        'Gently cuts heads just above skin level for smooth skin. This product is part of the Philips Double Delite Campaign - T&C''s Apply',
        'https://www.takealot.com/philips-at-790-aqua-touch-shaver/PLID28038139');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 57048405, 60168090,
        'Samsung Galaxy A50 128GB Single Sim - Black', '',
        'https://www.takealot.com/samsung-galaxy-a50-128gb-single-sim-black/PLID57048405');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 57048403, 60168088,
        'Samsung Galaxy A50 128GB Single Sim - Blue', '',
        'https://www.takealot.com/samsung-galaxy-a50-128gb-single-sim-blue/PLID57048403');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 41529704, 44307483,
        'Philips S1510/04 Series 1000 Dry Electric Shaver',
        'This product is part of the Philips Double Delite Campaign - T&C''s Apply',
        'https://www.takealot.com/philips-s1510-04-series-1000-dry-electric-shaver/PLID41529704');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 54496024, 57509591,
        'Samsung Galaxy A7 64GB (2018) Single Sim - Gold', '',
        'https://www.takealot.com/samsung-galaxy-a7-64gb-2018-single-sim-gold/PLID54496024');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 54494868, 57507322,
        'Samsung Galaxy A9 128GB (2018) Single Sim - Lemonade Blue', '',
        'https://www.takealot.com/samsung-galaxy-a9-128gb-2018-single-sim-lemonade-blue/PLID54494868');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:48', '2019-11-18 22:17:48', NULL, 36959679, 39688314,
        'Philips Series 9000 Wet And Dry Shaver',
        'This product is part of the Philips Double Delite Campaign - T&C''s Apply',
        'https://www.takealot.com/philips-series-9000-wet-and-dry-shaver/PLID36959679');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 54496025, 57509592,
        'Samsung Galaxy A9 128GB (2018) Single Sim - Caviar Black', '',
        'https://www.takealot.com/samsung-galaxy-a9-128gb-2018-single-sim-caviar-black/PLID54496025');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 52353838, 55289770,
        'Philips AquaTouch Wet/Dry Electric Shaver With Pop-up Trimmer',
        'This product is part of the Philips Double Delite Campaign - T&C''s Apply',
        'https://www.takealot.com/philips-aquatouch-wet-dry-electric-shaver-with-pop-up-trimmer/PLID52353838');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 27953177, 30553351, 'Tamron 70-300mm f/4-5.6 A17 Di Lens',
        'For Nikon', 'https://www.takealot.com/tamron-70-300mm-f-4-5-6-a17-di-lens/PLID27953177');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 20574361, 20662973,
        'Philips - AquaTouch Wet And Dry Electric Shaver ',
        'Quick rinse sytem, easy glide shave, model number - AT750/16. This product is part of the Philips Double Delite Campaign - T&C''s Apply',
        'https://www.takealot.com/philips-aquatouch-wet-and-dry-electric-shaver/PLID20574361');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 49162118, 52078870, 'Casio CTK-1500K2 Musical Keyboard', '',
        'https://www.takealot.com/casio-ctk-1500k2-musical-keyboard/PLID49162118');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 46668281, 49533711,
        'Tamron 18-400mm f/3.5-6.3 Di II VC HLD Lens for Canon', 'All-in-One Zoom',
        'https://www.takealot.com/tamron-18-400mm-f-3-5-6-3-di-ii-vc-hld-lens-for-canon/PLID46668281');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 52854621, 55824787, 'Apple iPhone XR 64GB - Blue',
        'MRYA2AA/A', 'https://www.takealot.com/apple-iphone-xr-64gb-blue/PLID52854621');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 54708998, 57763164, 'Hercules DJ Starter Kit', '',
        'https://www.takealot.com/hercules-dj-starter-kit/PLID54708998');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 28058627, 30662947, 'Sigma 18-35mm F1.8 DC HSM Lens',
        'For Nikon', 'https://www.takealot.com/sigma-18-35mm-f1-8-dc-hsm-lens/PLID28058627');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 55023245, 58090916, 'Xiaomi Mi Drone Mini', '',
        'https://www.takealot.com/xiaomi-mi-drone-mini/PLID55023245');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 29395211, 32044529,
        'Melissa & Doug Maggie Leigh Magnetic Wooden Dress-up Doll', '',
        'https://www.takealot.com/melissa-doug-maggie-leigh-magnetic-wooden-dress-up-doll/PLID29395211');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:49', '2019-11-18 22:17:49', NULL, 27953175, 30553349, 'Tamron 70-300mm f/4-5.6 A17 Di Lens ',
        'For Canon', 'https://www.takealot.com/tamron-70-300mm-f-4-5-6-a17-di-lens/PLID27953175');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 53256148, 56237045, 'Djeco Games - Little Collect', '',
        'https://www.takealot.com/djeco-games-little-collect/PLID53256148');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 56055846, 59154345, 'Olympus TG-6 Black', '',
        'https://www.takealot.com/olympus-tg-6-black/PLID56055846');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 44046816, 46874553,
        'Nintendo Switch Console With Neon Red And Neon Blue Joy-Con (NS)', '',
        'https://www.takealot.com/nintendo-switch-console-with-neon-red-and-neon-blue-joy-con-ns/PLID44046816');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 29395215, 32044533,
        'Melissa & Doug Nina Magnetic Wooden Ballerina', '',
        'https://www.takealot.com/melissa-doug-nina-magnetic-wooden-ballerina/PLID29395215');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 51978681, 54903483,
        'Vanish Power 02 - Fabric Stain Remover - Powder - 1kg', 'Vanish Fabric Stain Remover Powder',
        'https://www.takealot.com/vanish-power-02-fabric-stain-remover-powder-1kg/PLID51978681');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 51985144, 54910245, 'Nerf Nitro DoubleClutch Inferno Set',
        '', 'https://www.takealot.com/nerf-nitro-doubleclutch-inferno-set/PLID51985144');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 42116785, 44918465,
        'Djeco  Board Game  Navy loto (wooden fishing game)', '',
        'https://www.takealot.com/djeco-board-game-navy-loto-wooden-fishing-game/PLID42116785');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 51978675, 54903477,
        'Vanish Crystal Whites - Fabric Stain Remover - Powder - 800g', 'Vanish Fabric Stain Remover Powder',
        'https://www.takealot.com/vanish-crystal-whites-fabric-stain-remover-powder-800g/PLID51978675');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 46668282, 49533712,
        'Tamron 18-400mm f/3.5-6.3 Di II VC HLD Lens for Nikon', 'All-in-One Zoom',
        'https://www.takealot.com/tamron-18-400mm-f-3-5-6-3-di-ii-vc-hld-lens-for-nikon/PLID46668282');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 51790529, 54724703,
        'Melissa & Doug Magnetic Dress Up - Tutus & Wings', '',
        'https://www.takealot.com/melissa-doug-magnetic-dress-up-tutus-wings/PLID51790529');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 51978660, 54903462,
        'Finish Auto Dishwashing All in One Tablets Lemon - 42''s', 'Finish Auto Dishwashing Tablets',
        'https://www.takealot.com/finish-auto-dishwashing-all-in-one-tablets-lemon-42-s/PLID51978660');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 44748341, 47588016, 'Middle Earth Shadow of War (PS4)', '',
        'https://www.takealot.com/middle-earth-shadow-of-war-ps4/PLID44748341');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 56055693, 59154155,
        'Xbox One S 1TB Console + Fifa 20 (Xbox One)', '',
        'https://www.takealot.com/xbox-one-s-1tb-console-fifa-20-xbox-one/PLID56055693');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:50', '2019-11-18 22:17:50', NULL, 51978670, 54903472,
        'Finish Auto Dishwashing Quantum Tablets - 30''s', 'Finish Auto Dishwashing Quantum Tablets',
        'https://www.takealot.com/finish-auto-dishwashing-quantum-tablets-30-s/PLID51978670');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 50099325, 53028313,
        'Epson Ecotank ITS L6190 4-in-1 Wi-Fi Printer', 'C11CG19403',
        'https://www.takealot.com/epson-ecotank-its-l6190-4-in-1-wi-fi-printer/PLID50099325');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 57688485, 60809892,
        'Xbox One S 1TB Console + Need for Speed  PAYBACK + Grand Theft Auto V (Xbox One)', '',
        'https://www.takealot.com/xbox-one-s-1tb-console-need-for-speed-payback-grand-theft-auto-v-xbox-one/PLID57688485');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 51978659, 54903461,
        'Finish Auto Dishwashing All in One Tablets Regular - 42''s', 'Finish Auto Dishwashing Tablets',
        'https://www.takealot.com/finish-auto-dishwashing-all-in-one-tablets-regular-42-s/PLID51978659');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 44748342, 47588017, 'Middle Earth Shadow of War (Xbox One)',
        '', 'https://www.takealot.com/middle-earth-shadow-of-war-xbox-one/PLID44748342');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 51978661, 54903463,
        'Finish Auto Dishwashing All in One Tablets Regular - 56''s', 'Finish Auto Dishwashing Tablets',
        'https://www.takealot.com/finish-auto-dishwashing-all-in-one-tablets-regular-56-s/PLID51978661');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 46847300, 49715292, 'The Evil Within II (PS4)', '',
        'https://www.takealot.com/the-evil-within-ii-ps4/PLID46847300');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 53598066, 56592249,
        'L''OR - Espresso Satinato Intensity 6 - Nespresso Compatible Aluminium Coffee Capsules',
        'LOR. Why Pursue anything other than Gold - Pack of 10 Capsules',
        'https://www.takealot.com/l-or-espresso-satinato-intensity-6-nespresso-compatible-aluminium-coffee-capsules/PLID53598066');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 52950260, 55925854, 'Starlink Pilot Pack - Startail ',
        '*EXCLUSIVE TO TAKEALOT*', 'https://www.takealot.com/starlink-pilot-pack-startail/PLID52950260');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 49652726, 52578947, 'Tennis World Tour (Nintendo Switch)',
        '', 'https://www.takealot.com/tennis-world-tour-nintendo-switch/PLID49652726');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:51', '2019-11-18 22:17:51', NULL, 56055691, 59154153,
        'Xbox One S 1TB Console + Gears of War 5 (Xbox One)', '',
        'https://www.takealot.com/xbox-one-s-1tb-console-gears-of-war-5-xbox-one/PLID56055691');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 43680999, 46499695, 'Apple iPhone 6s 32GB - Space Grey',
        'MN0W2AA/A', 'https://www.takealot.com/apple-iphone-6s-32gb-space-grey/PLID43680999');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 45065640, 47915899, 'Epson L120 Ink Tank System Printer',
        'C11CD76411', 'https://www.takealot.com/epson-l120-ink-tank-system-printer/PLID45065640');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 52542657, 55487503,
        'Fitbit Charge 3 Activity Tracker - Graphite Black', '',
        'https://www.takealot.com/fitbit-charge-3-activity-tracker-graphite-black/PLID52542657');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 47081896, 49966910, 'Xbox One X 1TB Console (Xbox One X)',
        '', 'https://www.takealot.com/xbox-one-x-1tb-console-xbox-one-x/PLID47081896');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 46847308, 49715296,
        'Wolfenstein II: The New Colossus (Xbox One)', '',
        'https://www.takealot.com/wolfenstein-ii-the-new-colossus-xbox-one/PLID46847308');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 53598064, 56592247,
        'L''OR - Espresso Lungo Profundo Intensity 8', 'LOR. Why Pursue anything other than Gold - Pack of 10 Capsules',
        'https://www.takealot.com/l-or-espresso-lungo-profundo-intensity-8/PLID53598064');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 55390655, 58479713,
        'Xbox One X 1TB - Gears of war 5 Limited Edition Console (Xbox One)', '',
        'https://www.takealot.com/xbox-one-x-1tb-gears-of-war-5-limited-edition-console-xbox-one/PLID55390655');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 42975277, 45781167, 'Apple iPhone 7 32GB - Black',
        'MN8X2AA/A', 'https://www.takealot.com/apple-iphone-7-32gb-black/PLID42975277');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 56132872, 59233494, 'Xbox One S 1TB Console + Controller',
        '', 'https://www.takealot.com/xbox-one-s-1tb-console-controller/PLID56132872');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:52', '2019-11-18 22:17:52', NULL, 52951555, 55927675,
        'Rollercoaster Tycoon Adventures (Nintendo Switch)', '',
        'https://www.takealot.com/rollercoaster-tycoon-adventures-nintendo-switch/PLID52951555');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 53598062, 56592245,
        'L''OR - Espresso Forza Intensity 9 - Nespresso Compatible Aluminium Coffee Capsules',
        'LOR. Why Pursue anything other than Gold - Pack of 10 Capsules',
        'https://www.takealot.com/l-or-espresso-forza-intensity-9-nespresso-compatible-aluminium-coffee-capsules/PLID53598062');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 52539302, 55483178,
        'Starlink Battle For Atlas - Cerberus Starship Pack (Figurine)', '*LIMITED STOCK - SEMI EXCLUSIVE*',
        'https://www.takealot.com/starlink-battle-for-atlas-cerberus-starship-pack-figurine/PLID52539302');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 52290292, 55225533, 'Starlink: Pilot Pack Razor (Figurine)',
        '', 'https://www.takealot.com/starlink-pilot-pack-razor-figurine/PLID52290292');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 52226679, 55161566, 'V Rally 4 (Xbox One)', '',
        'https://www.takealot.com/v-rally-4-xbox-one/PLID52226679');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 47193080, 50085307, 'Voss Hard 29L Trolley Case - Fuchsia',
        '', 'https://www.takealot.com/voss-hard-29l-trolley-case-fuchsia/PLID47193080');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 38161268, 40887232, 'Shield - Orbital Polisher', '',
        'https://www.takealot.com/shield-orbital-polisher/PLID38161268');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 44766362, 47606079, 'Starblood Arena (PSVR)', '',
        'https://www.takealot.com/starblood-arena-psvr/PLID44766362');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 53598059, 56592242,
        'L''OR - Espresso Sontuoso Intensity 8 - Nespresso Compatible Aluminium Coffee Capsules',
        'LOR. Why Pursue anything other than Gold - Pack of 10 Capsules',
        'https://www.takealot.com/l-or-espresso-sontuoso-intensity-8-nespresso-compatible-aluminium-coffee-capsules/PLID53598059');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 54542371, 57585938,
        'Canon 250D 24MP DSLR Starter Value Bundle', 'Includes 18-55mm DC lens, 16GB Card & Bag',
        'https://www.takealot.com/canon-250d-24mp-dslr-starter-value-bundle/PLID54542371');
INSERT INTO trak.product (created_at, updated_at, deleted_at, pl_id, sku, title, subtitle, url)
VALUES ('2019-11-18 22:17:53', '2019-11-18 22:17:53', NULL, 51858001, 54788020, 'Monster Hunter World (PS4)', '',
        'https://www.takealot.com/monster-hunter-world-ps4/PLID51858001');


INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (1, 2);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (2, 2);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (3, 2);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (4, 3);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (5, 4);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (6, 5);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (7, 6);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (8, 7);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (9, 7);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (10, 3);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (12, 3);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (13, 6);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (14, 8);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (15, 3);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (16, 3);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (17, 8);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (18, 3);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (19, 3);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (20, 8);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (21, 3);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (11, 3);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (22, 8);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (23, 9);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (24, 8);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (25, 10);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (27, 11);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (26, 9);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (28, 12);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (29, 13);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (30, 14);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (31, 15);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (32, 9);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (34, 16);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (35, 17);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (36, 15);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (37, 18);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (38, 19);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (39, 20);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (40, 18);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (41, 9);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (42, 15);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (43, 21);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (45, 22);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (46, 21);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (47, 23);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (49, 21);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (48, 22);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (51, 21);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (53, 24);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (55, 17);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (56, 22);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (57, 11);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (58, 23);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (59, 25);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (60, 22);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (62, 24);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (63, 22);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (64, 11);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (65, 22);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (67, 24);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (71, 26);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (72, 27);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (74, 24);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (75, 28);
INSERT INTO trak.product_brand_link (product_id, brand_id)
VALUES (76, 29);


INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (1, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (1, 2);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (2, 3);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (1, 4);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (2, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (2, 2);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (3, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (3, 2);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (3, 4);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (4, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (4, 5);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (4, 6);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (5, 7);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (5, 8);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (5, 9);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (5, 10);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (5, 11);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (5, 12);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (5, 13);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (5, 14);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (6, 15);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (6, 16);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (6, 17);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (6, 18);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (7, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (7, 5);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (7, 6);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (8, 9);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (8, 19);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (8, 17);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (8, 20);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (8, 21);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (8, 22);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (9, 17);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (9, 20);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (9, 21);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (9, 22);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (9, 9);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (9, 19);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (10, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (10, 5);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (10, 6);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (12, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (12, 5);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (12, 6);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (13, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (13, 5);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (13, 6);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (14, 23);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (14, 24);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (14, 25);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (14, 26);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (14, 27);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (14, 28);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (15, 6);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (15, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (15, 5);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (16, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (16, 5);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (16, 6);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (17, 29);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (17, 23);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (17, 24);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (17, 25);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (17, 26);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (17, 27);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (17, 28);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (17, 22);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (18, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (18, 5);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (18, 6);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (19, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (19, 5);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (19, 6);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (20, 24);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (20, 25);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (20, 26);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (20, 27);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (20, 28);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (20, 22);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (20, 29);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (20, 23);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (21, 6);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (21, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (21, 5);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (11, 5);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (11, 6);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (11, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (22, 27);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (22, 31);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (22, 32);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (22, 33);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (22, 25);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (22, 24);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (22, 26);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (22, 28);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (22, 23);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (23, 34);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (23, 35);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (23, 36);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (23, 37);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (24, 38);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (24, 22);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (25, 39);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (25, 40);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (25, 41);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (25, 42);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (27, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (27, 5);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (26, 37);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (27, 6);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (26, 34);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (26, 35);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (26, 43);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (28, 39);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (28, 40);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (28, 44);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (29, 37);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (29, 34);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (29, 35);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (29, 36);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (30, 37);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (30, 45);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (30, 46);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (31, 47);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (32, 34);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (32, 35);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (31, 48);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (32, 36);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (31, 49);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (32, 37);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (31, 50);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (31, 51);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (31, 52);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (31, 53);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (34, 34);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (34, 37);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (35, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (35, 55);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (36, 53);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (36, 47);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (36, 48);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (36, 49);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (36, 50);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (36, 51);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (37, 56);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (36, 52);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (37, 57);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (37, 58);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (37, 59);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (38, 51);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (38, 52);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (38, 60);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (39, 51);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (38, 61);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (39, 52);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (39, 62);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (39, 63);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (41, 35);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (41, 43);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (41, 37);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (41, 34);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (42, 51);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (42, 64);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (42, 65);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (42, 66);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (42, 53);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (43, 57);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (42, 47);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (43, 67);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (42, 68);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (43, 69);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (42, 52);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (43, 70);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (42, 71);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (43, 56);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (44, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (44, 72);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (45, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (45, 55);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (46, 57);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (46, 67);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (46, 69);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (46, 70);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (46, 56);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (33, 51);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (33, 48);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (33, 73);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (33, 74);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (47, 20);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (47, 21);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (49, 56);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (48, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (49, 57);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (48, 55);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (47, 75);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (49, 67);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (47, 9);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (49, 69);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (47, 19);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (49, 70);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (47, 17);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (50, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (50, 72);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (51, 67);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (51, 69);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (51, 70);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (51, 56);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (51, 57);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (52, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (54, 52);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (52, 72);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (54, 76);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (54, 77);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (53, 56);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (54, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (53, 78);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (54, 79);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (53, 80);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (54, 81);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (54, 51);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (53, 82);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (53, 83);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (55, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (55, 72);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (56, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (56, 55);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (57, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (57, 5);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (57, 6);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (58, 21);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (59, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (58, 75);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (58, 9);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (59, 84);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (58, 19);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (58, 17);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (59, 85);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (58, 20);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (60, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (60, 55);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (61, 72);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (61, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (62, 56);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (62, 78);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (62, 80);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (62, 82);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (62, 83);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (63, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (63, 55);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (64, 1);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (64, 5);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (64, 6);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (65, 55);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (65, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (66, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (66, 72);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (67, 56);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (67, 78);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (67, 80);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (67, 82);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (67, 83);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (68, 77);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (69, 52);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (68, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (69, 76);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (68, 79);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (69, 77);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (68, 81);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (69, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (68, 51);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (69, 79);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (68, 52);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (69, 81);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (68, 76);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (69, 51);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (71, 86);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (71, 87);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (71, 88);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (72, 89);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (72, 90);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (72, 91);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (72, 92);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (72, 93);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (72, 94);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (72, 95);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (72, 96);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (73, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (73, 72);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (74, 82);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (75, 37);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (74, 83);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (76, 54);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (75, 34);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (74, 56);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (76, 72);
INSERT INTO trak.product_category_link (product_id, category_id)
VALUES (74, 78);


INSERT INTO trak.product_image (product_id, url_format)
VALUES (1, 'https://media.takealot.com/covers_tsins/44239712/7394090900573-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (1, 'https://media.takealot.com/covers_tsins/44239712/7394090900573-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (2, 'https://media.takealot.com/covers_tsins/44239710/20204_Front_HR_Krusell_ScreenPro_20204_Front-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (3, 'https://media.takealot.com/covers_tsins/44239713/7394090756767-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (4, 'https://media.takealot.com/covers_tsins/56456231/56456231-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (4, 'https://media.takealot.com/covers_tsins/56456231/56456231-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (4, 'https://media.takealot.com/covers_tsins/56456231/56456231-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (4, 'https://media.takealot.com/covers_tsins/56456231/56456231-4-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (4, 'https://media.takealot.com/covers_tsins/56456231/56456231-5-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (4, 'https://media.takealot.com/covers_tsins/56456231/56456231-6-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (5, 'https://media.takealot.com/covers/29828012/52259f884cb1d-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (6, 'https://media.takealot.com/covers_tsins/57767350/4718017286954 (2)-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (6, 'https://media.takealot.com/covers_tsins/57767350/4718017286954 (1)-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (6, 'https://media.takealot.com/covers_tsins/57767350/4718017286954 (3)-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (6, 'https://media.takealot.com/covers_tsins/57767350/4718017286954-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (6, 'https://media.takealot.com/covers_tsins/57767350/4718017286954-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (6, 'https://media.takealot.com/covers_tsins/57767350/4718017286954-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (6, 'https://media.takealot.com/covers_tsins/57767350/4718017286954-4-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (7, 'https://media.takealot.com/covers_tsins/56311929/6901443177820-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (8, 'https://media.takealot.com/covers_tsins/46879292/889894644220-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (8, 'https://media.takealot.com/covers_tsins/46879292/889894644220-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (8, 'https://media.takealot.com/covers_tsins/46879292/889894644220-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (8, 'https://media.takealot.com/covers_tsins/46879292/889894644220-4-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (8, 'https://media.takealot.com/covers_tsins/46879292/889894644220-5-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (9, 'https://media.takealot.com/covers_tsins/58137174/193424191901-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (9, 'https://media.takealot.com/covers_tsins/58137174/193424191901-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (9, 'https://media.takealot.com/covers_tsins/58137174/193424191901-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (9, 'https://media.takealot.com/covers_tsins/58137174/193424191901-4-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (9, 'https://media.takealot.com/covers_tsins/58137174/58137174-1-{size}.jpeg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (9, 'https://media.takealot.com/covers_tsins/58137174/58137174-2-{size}.jpeg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (9, 'https://media.takealot.com/covers_tsins/58137174/58137174-3-{size}.jpeg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (9, 'https://media.takealot.com/covers_tsins/58137174/58137174-4-{size}.jpeg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (11, 'https://media.takealot.com/covers_tsins/57511129/8801643837082-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (10, 'https://media.takealot.com/covers_tsins/57509590/8801643503550-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (10, 'https://media.takealot.com/covers_tsins/57509590/8801643503550-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (11, 'https://media.takealot.com/covers_tsins/57511129/8801643837082-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (10, 'https://media.takealot.com/covers_tsins/57509590/8801643503550-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (11, 'https://media.takealot.com/covers_tsins/57511129/8801643837082-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (11, 'https://media.takealot.com/covers_tsins/57511129/8801643837082-4-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (12, 'https://media.takealot.com/covers_tsins/57511130/8801643867157-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (12, 'https://media.takealot.com/covers_tsins/57511130/57511130-1-{size}.jpeg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (12, 'https://media.takealot.com/covers_tsins/57511130/8801643867157-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (13, 'https://media.takealot.com/covers_tsins/47795157/6901443177837-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (13, 'https://media.takealot.com/covers_tsins/47795157/6901443177837-1-{size}.png');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (14, 'https://media.takealot.com/covers_tsins/30642043/8710103630197-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (15, 'https://media.takealot.com/covers_tsins/60168090/8801643864491-1-full-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (15, 'https://media.takealot.com/covers_tsins/60168090/8801643864491-2-full-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (15, 'https://media.takealot.com/covers_tsins/60168090/8801643864491-3-full-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (16, 'https://media.takealot.com/covers_tsins/60168088/a505f-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (16, 'https://media.takealot.com/covers_tsins/60168088/8801643864477-1-full-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (16, 'https://media.takealot.com/covers_tsins/60168088/a505f1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (17, 'https://media.takealot.com/covers_tsins/44307483/8710103771579-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (17, 'https://media.takealot.com/covers_tsins/44307483/8710103771579-2A-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (17, 'https://media.takealot.com/covers_tsins/44307483/8710103771579-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (18, 'https://media.takealot.com/covers_tsins/57509591/8801643503338-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (19, 'https://media.takealot.com/covers_tsins/57507322/8801643608040-4-{size}.png');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (19, 'https://media.takealot.com/covers_tsins/57507322/8801643608040-5-{size}.png');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (20, 'https://media.takealot.com/covers/44602679/552df989c83c4-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (21, 'https://media.takealot.com/covers_tsins/57509592/8801643607838-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (21, 'https://media.takealot.com/covers_tsins/57509592/8801643607838-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (21, 'https://media.takealot.com/covers_tsins/57509592/8801643607838-3-{size}.png');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (22, 'https://media.takealot.com/covers_tsins/55289770/8710103865780-1A-{size}.JPG');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (23, 'https://media.takealot.com/covers/29660182/2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (24, 'https://media.takealot.com/covers_tsins/20662973/20662973-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (25, 'https://media.takealot.com/covers_tsins/52078870/4971850314707-1-{size}.jpeg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (26, 'https://media.takealot.com/covers_tsins/49533711/4960371006277-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (26, 'https://media.takealot.com/covers_tsins/49533711/4960371006277-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (27, 'https://media.takealot.com/covers_tsins/55824787/55824787-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (26, 'https://media.takealot.com/covers_tsins/49533711/4960371006277-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (26, 'https://media.takealot.com/covers_tsins/49533711/4960371006277-4-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (26, 'https://media.takealot.com/covers_tsins/49533711/4960371006277-5-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (26, 'https://media.takealot.com/covers_tsins/49533711/4960371006277-6-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (28, 'https://media.takealot.com/covers_tsins/57763164/3362934745806-1-{size}.JPG');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (29, 'https://media.takealot.com/covers/29921042/sigma_18-35mm_lens-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (30, 'https://media.takealot.com/covers_tsins/58090916/6934177701399  - Mi Drone 2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (30, 'https://media.takealot.com/covers_tsins/58090916/6934177701399  - Mi Drone 1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (30, 'https://media.takealot.com/covers_tsins/58090916/6934177701399  - Mi Drone 3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (31, 'https://media.takealot.com/covers/28216528/3552-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (32, 'https://media.takealot.com/covers_tsins/30553349/tamron lens-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (33, 'https://media.takealot.com/covers_tsins/56237045/3070900085589-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (33, 'https://media.takealot.com/covers_tsins/56237045/3070900085589-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (34, 'https://media.takealot.com/covers_tsins/59154345/4545350052676 - 1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (34, 'https://media.takealot.com/covers_tsins/59154345/4545350052676 - 2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (34, 'https://media.takealot.com/covers_tsins/59154345/4545350052676 - 3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (34, 'https://media.takealot.com/covers_tsins/59154345/4545350052676 - 4-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (34, 'https://media.takealot.com/covers_tsins/59154345/4545350052676 - 5-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (34, 'https://media.takealot.com/covers_tsins/59154345/4545350052676 - 6-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (34, 'https://media.takealot.com/covers_tsins/59154345/4545350052676 - 7-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (35, 'https://media.takealot.com/covers_tsins/46874553/46874553-{size}.JPG');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (36, 'https://media.takealot.com/covers/28216530/3554-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (37, 'https://media.takealot.com/covers_tsins/54903483/54903480_10-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (38, 'https://media.takealot.com/covers_tsins/54910245/5010993515851-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (38, 'https://media.takealot.com/covers_tsins/54910245/5010993515851-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (38, 'https://media.takealot.com/covers_tsins/54910245/5010993515851-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (38, 'https://media.takealot.com/covers_tsins/54910245/5010993515851-4-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (38, 'https://media.takealot.com/covers_tsins/54910245/5010993515851-5-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (39, 'https://media.takealot.com/covers_tsins/44918465/44918465-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (39, 'https://media.takealot.com/covers_tsins/44918465/3070900016880-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (40, 'https://media.takealot.com/covers_tsins/54903477/54903477_10-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (41, 'https://media.takealot.com/covers_tsins/49533712/4960371006284-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (41, 'https://media.takealot.com/covers_tsins/49533712/4960371006284-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (41, 'https://media.takealot.com/covers_tsins/49533712/4960371006284-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (41, 'https://media.takealot.com/covers_tsins/49533712/4960371006284-4-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (41, 'https://media.takealot.com/covers_tsins/49533712/4960371006284-5-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (41, 'https://media.takealot.com/covers_tsins/49533712/4960371006284-6-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (42, 'https://media.takealot.com/covers_tsins/54724703/54724703-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (43, 'https://media.takealot.com/covers_tsins/54903462/6001106224745-1-{size}.png');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (44, 'https://media.takealot.com/covers_tsins/47588016/47588016-1-{size}.JPG');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (45, 'https://media.takealot.com/covers_tsins/59154155/6001186372060-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (46, 'https://media.takealot.com/covers_tsins/54903472/6001106128074-1-{size}.jpeg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (47, 'https://media.takealot.com/covers_tsins/53028313/8715946643960-1a-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (47, 'https://media.takealot.com/covers_tsins/53028313/8715946643960-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (49, 'https://media.takealot.com/covers_tsins/54903461/6001106224806-1-{size}.png');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (48, 'https://media.takealot.com/covers_tsins/60809892/6001186372152-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (50, 'https://media.takealot.com/covers_tsins/47588017/47588017-2-{size}.JPG');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (51, 'https://media.takealot.com/covers_tsins/54903463/6001106128050-1-{size}.png');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (53, 'https://media.takealot.com/covers_tsins/56592249/7896089088342-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (52, 'https://media.takealot.com/covers_tsins/49715292/5055856416203-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (54, 'https://media.takealot.com/covers_tsins/55925854/3307216063278-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (53, 'https://media.takealot.com/covers_tsins/56592249/7896089088342-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (53, 'https://media.takealot.com/covers_tsins/56592249/7896089088342-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (53, 'https://media.takealot.com/covers_tsins/56592249/7896089088342-4-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (53, 'https://media.takealot.com/covers_tsins/56592249/7896089088342-5-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (55, 'https://media.takealot.com/covers_tsins/52578947/52578947-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (56, 'https://media.takealot.com/covers_tsins/59154153/6001186372053-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (57, 'https://media.takealot.com/covers_tsins/46499695/190198056955-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (57, 'https://media.takealot.com/covers_tsins/46499695/190198056955-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (57, 'https://media.takealot.com/covers_tsins/46499695/46499695-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (58, 'https://media.takealot.com/covers_tsins/47915899/8715946540856-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (58, 'https://media.takealot.com/covers_tsins/47915899/8715946540856-4-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (59, 'https://media.takealot.com/covers_tsins/55487503/CHARGE3BLACK-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (58, 'https://media.takealot.com/covers_tsins/47915899/epson l120_2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (59, 'https://media.takealot.com/covers_tsins/55487503/CHARGE3BLACK-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (58, 'https://media.takealot.com/covers_tsins/47915899/l120_1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (59, 'https://media.takealot.com/covers_tsins/55487503/CHARGE3BLACK-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (60, 'https://media.takealot.com/covers_tsins/49966910/889842208368-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (60, 'https://media.takealot.com/covers_tsins/49966910/889842208368-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (61, 'https://media.takealot.com/covers_tsins/49715296/5055856416876-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (61, 'https://media.takealot.com/covers_tsins/49715296/5055856416876-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (62, 'https://media.takealot.com/covers_tsins/56592247/8711000362617-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (62, 'https://media.takealot.com/covers_tsins/56592247/8711000362617-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (62, 'https://media.takealot.com/covers_tsins/56592247/8711000362617-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (62, 'https://media.takealot.com/covers_tsins/56592247/8711000362617-4-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (62, 'https://media.takealot.com/covers_tsins/56592247/8711000362617-5-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (63, 'https://media.takealot.com/covers_tsins/58479713/image002-{size}.png');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (64, 'https://media.takealot.com/covers_tsins/45781167/6007139-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (65, 'https://media.takealot.com/covers_tsins/59233494/889842308129-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (66, 'https://media.takealot.com/covers_tsins/55927675/3499550370515-1-{size}.png');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (66, 'https://media.takealot.com/covers_tsins/55927675/maxresdefault-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (66, 'https://media.takealot.com/covers_tsins/55927675/ss02-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (67, 'https://media.takealot.com/covers_tsins/56592245/8710002015486-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (67, 'https://media.takealot.com/covers_tsins/56592245/8710002015486-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (67, 'https://media.takealot.com/covers_tsins/56592245/8710002015486-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (67, 'https://media.takealot.com/covers_tsins/56592245/8710002015486-4-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (67, 'https://media.takealot.com/covers_tsins/56592245/8710002015486-5-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (68, 'https://media.takealot.com/covers_tsins/55483178/3307216062912-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (69, 'https://media.takealot.com/covers_tsins/55225533/3307216036050-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (69, 'https://media.takealot.com/covers_tsins/55225533/3307216036050-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (70, 'https://media.takealot.com/covers_tsins/55161566/3499550366464-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (70, 'https://media.takealot.com/covers_tsins/55161566/3499550366464-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (71, 'https://media.takealot.com/covers_tsins/50085307/6009706411312-1-{size}.JPG');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (72, 'https://media.takealot.com/covers_tsins/40887232/6001878002008-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (73, 'https://media.takealot.com/covers_tsins/47606079/47606079-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (74, 'https://media.takealot.com/covers_tsins/56592242/8711000352486-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (74, 'https://media.takealot.com/covers_tsins/56592242/8711000352486-2-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (74, 'https://media.takealot.com/covers_tsins/56592242/8711000352486-3-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (74, 'https://media.takealot.com/covers_tsins/56592242/8711000352486-4-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (74, 'https://media.takealot.com/covers_tsins/56592242/8711000352486-5-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (75, 'https://media.takealot.com/covers_tsins/57585938/8714574657530-1-{size}.jpg');
INSERT INTO trak.product_image (product_id, url_format)
VALUES (76, 'https://media.takealot.com/covers_tsins/54788020/54788020-1-{size}.jpg');


INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598059, 30);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54542371, 30);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51858001, 30);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496776, 7);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44948410, 21);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496777, 7);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53331013, 21);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469865, 41);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44051487, 15);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52353838, 12);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44046816, 39);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52854621, 47);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496023, 41);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (20574361, 12);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57048405, 4);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28038139, 12);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496025, 41);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57048403, 4);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496024, 41);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41529704, 12);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54494868, 41);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (36959679, 12);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49162118, 44);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (27953177, 44);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (27953175, 44);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56055846, 44);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46668281, 44);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55023245, 44);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54708998, 44);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28058627, 44);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46668282, 44);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (29395211, 50);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51790529, 50);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (29395215, 50);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53256148, 50);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51985144, 50);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51978681, 56);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42116785, 50);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51978675, 56);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51978670, 56);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51978661, 56);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56055693, 20);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51978660, 56);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45065640, 14);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44748341, 60);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47081896, 20);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51978659, 56);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44748342, 60);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (50099325, 14);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57688485, 20);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46847300, 60);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56055691, 20);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (43680999, 32);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598066, 53);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52950260, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56055693, 35);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (17259451, 31);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49652726, 49);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46847308, 60);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52542657, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598064, 53);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55390655, 20);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56055691, 35);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42975277, 32);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52951555, 49);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52539302, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38161268, 31);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46847306, 60);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52542658, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52226679, 49);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290292, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56132872, 20);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47193080, 31);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598062, 53);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44766362, 60);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44766853, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51858001, 49);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598059, 53);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54542371, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290291, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54493221, 31);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46847302, 60);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41466849, 49);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52092707, 58);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598058, 53);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44766852, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41295794, 49);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290290, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53900643, 31);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52092708, 58);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41263660, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44771788, 63);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290289, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51978211, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53900654, 31);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41295793, 49);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44771790, 63);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290288, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46919955, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41381966, 33);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51978213, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40687668, 49);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46988888, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290287, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41381967, 33);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51978212, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53535112, 9);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38437510, 49);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46885086, 16);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38321471, 33);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392807, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41263659, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290286, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54497256, 9);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51858002, 49);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290285, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46919956, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54857344, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41381963, 33);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28112393, 9);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290284, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46919952, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44766854, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51985282, 9);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290283, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (29418529, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54527764, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066638, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44312139, 9);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290282, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066637, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48642790, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47235516, 59);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55235667, 40);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54527762, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46883362, 54);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290281, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066640, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44058301, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44771788, 59);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52620652, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55067415, 40);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290276, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (43826804, 54);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543550, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55067414, 40);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41466849, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54542370, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47235517, 59);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290275, 48);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47081887, 54);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49984607, 59);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54527766, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55067411, 40);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41295794, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55393861, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49984605, 59);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52853984, 54);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066641, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066738, 40);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41295793, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54527761, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49590070, 59);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066737, 40);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40687668, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52950674, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52853983, 54);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49426760, 46);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44934047, 59);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52195931, 54);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47222687, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066736, 40);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38437510, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44771790, 59);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (17228171, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49325429, 66);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066734, 40);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28035829, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267184, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46991170, 54);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42120384, 59);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55956935, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (50154951, 13);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44748341, 66);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28062263, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41466850, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267150, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55548081, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47235512, 59);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51858001, 13);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42986284, 54);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28062257, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49443048, 66);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41465233, 61);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49300048, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41402173, 54);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543553, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44748342, 66);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (17228197, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49300045, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41295507, 54);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543552, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49653979, 66);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49300032, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (17228201, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41456386, 54);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543551, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46847300, 66);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267189, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28062255, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52092305, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46847308, 66);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267178, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32844281, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34167227, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52227089, 66);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267175, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41490868, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54548201, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267174, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52094189, 66);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41306471, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496344, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267156, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47121807, 66);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430975, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52587130, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267155, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52587129, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53116578, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46847306, 66);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52587134, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53116553, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267154, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44766362, 66);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53116552, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52587133, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34181060, 66);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267151, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53116551, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52587123, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267148, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53116550, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267146, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41306470, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53116544, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267142, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52587132, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53116543, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267135, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28061415, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53116534, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267133, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41306469, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53116434, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267131, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54969417, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49300047, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52950675, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52587119, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267193, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28061413, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52949391, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54385224, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52856156, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267190, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32708463, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52856095, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267163, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52587128, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267149, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52753265, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52486495, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267147, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41306472, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52428381, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47267138, 38);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52428370, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (33054488, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52428368, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (17227779, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52112579, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (4765, 23);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52856242, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52112569, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32708267, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47488126, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (17228191, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47222711, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (17227795, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47222681, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57793373, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46922762, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52587131, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46860909, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52587127, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45267058, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (17227805, 6);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45267057, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44155721, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42318473, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41531238, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41531164, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40725786, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496345, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (50155012, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52950676, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32845441, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52856148, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (17259801, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (17259791, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52031818, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32703721, 43);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46907114, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32845445, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47081896, 45);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32845442, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55390655, 45);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48591911, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46915699, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52691702, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52691701, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52750362, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49433077, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34187172, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49433076, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52587113, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32845444, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48643149, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32845446, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646895, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56132713, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646878, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54858554, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646856, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54587223, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646893, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55399376, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48757663, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646892, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53747196, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646890, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (39154195, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646889, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46907440, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646885, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56132712, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646880, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56137365, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646869, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54520267, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44786418, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646868, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46643397, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49443048, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646854, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56132711, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646894, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54536625, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56131733, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646888, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53713296, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46915696, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53596444, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646883, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56137363, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646876, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53536403, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47471908, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646875, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53536334, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32564623, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41680395, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41515613, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53536333, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646873, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48757662, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41712115, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646872, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53536332, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51942452, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52227090, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32564621, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646855, 18);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42990981, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173891, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44156884, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52094037, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41543533, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969638, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40733865, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55541627, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52094036, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969673, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52861554, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52031911, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (43773386, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969661, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52090729, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49443049, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42990794, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42983165, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173876, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49443047, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42990793, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969677, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40733866, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42120384, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969657, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42120394, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51983315, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54551547, 11);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54587135, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38330475, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54551546, 11);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (50155025, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378134, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (50155021, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54536624, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32610581, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982338, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52750212, 11);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (50155017, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53596443, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52750210, 11);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378155, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38330474, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44970027, 17);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52227091, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53863124, 11);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52854638, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969636, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53118875, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49001563, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42118707, 42);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47471729, 11);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378150, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38258741, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (36958910, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378136, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32826979, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969664, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32610579, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52353016, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982302, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52855501, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52855499, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982285, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52854642, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378165, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52854641, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378163, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378161, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52854636, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52800482, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378160, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52800473, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173878, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52089696, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969665, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52031048, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969680, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52031047, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969671, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49590070, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982303, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49590069, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378149, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49521494, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969660, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49521490, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53983654, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49521485, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598287, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49521479, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52090176, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49001561, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47440651, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47268606, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598292, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47235511, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53331633, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47235504, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53331632, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47235503, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982283, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47235502, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378157, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47235501, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969672, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46992886, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969634, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46992885, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969658, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42983166, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (43535676, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41466316, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53118294, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38678850, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598281, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32801455, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598279, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32801453, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51983322, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32732437, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378143, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47235509, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378135, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46864702, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173882, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (43535678, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42120395, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42118707, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598280, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53597922, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28005593, 55);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52353007, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982284, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378147, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173879, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598291, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598273, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52859695, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52859691, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52347119, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378151, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969662, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598289, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53597923, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52859693, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982339, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982329, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969649, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969637, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54752474, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598277, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598267, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598145, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598144, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53597926, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53597925, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982337, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982321, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982312, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982311, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982310, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982309, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982288, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490326, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378164, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58355112, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47440650, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58851354, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969641, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57465087, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969635, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57907097, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598290, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57464786, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598143, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58752389, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598142, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56937468, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52347120, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56577030, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982293, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56577025, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982286, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56355306, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51982282, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58850212, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378153, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58850211, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378152, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58850204, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173896, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58751829, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969646, 1);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58751398, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58570136, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58570012, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58570011, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58570010, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58371476, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58243890, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58243057, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58242623, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58242619, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58072351, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58072270, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58072263, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58071855, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58751832, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57907598, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57906722, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57793201, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57793200, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57793194, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57793192, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57793189, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57793186, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57793185, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57793184, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57793183, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57791908, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57465213, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57464725, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57464724, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57222537, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57054896, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57054895, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57054894, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57047473, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57047376, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58072669, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56577150, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56577149, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56577028, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56577027, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56577026, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56577024, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56577022, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56577021, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56576651, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57464810, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56494370, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56491034, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490592, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490591, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490589, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490588, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490364, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490362, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490333, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490332, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490331, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490330, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490329, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490328, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490325, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490324, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490323, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490322, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490321, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490320, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490319, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490318, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490317, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490107, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56486828, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56482487, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56481597, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56476590, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56473917, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56356203, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56356019, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56356018, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56356017, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56355990, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56355989, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56355988, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56355803, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57047472, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57047472, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56577029, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56577023, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56576845, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56491035, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490363, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490360, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56490336, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56355801, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56355646, 28);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46860897, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49031186, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46852868, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46922746, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53770939, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54518821, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42173656, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56131940, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46914906, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46868878, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45267049, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45170893, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42172370, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32843688, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53707380, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52947347, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52751411, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52034409, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49589553, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173164, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47000041, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47000040, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46836677, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41071125, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40660522, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32799919, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52751433, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52748998, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51985130, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49589597, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46914911, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46868880, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46643221, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42125293, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32837701, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53707378, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646704, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52855950, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52094385, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030432, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030418, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030412, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51967493, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (50154864, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48218100, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46642867, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40359909, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38379925, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32705015, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55064356, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547809, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54512030, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54512029, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52947492, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52856284, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52801836, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52801835, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52801821, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52749072, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52749070, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52749069, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52749066, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52749065, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52354433, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030419, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030416, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51967492, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49589603, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49263446, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49263389, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49263380, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49263334, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47439734, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47172588, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47127108, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46991025, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46991023, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46860882, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46835909, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45217057, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42173690, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40359905, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34154814, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53646708, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53253744, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53187656, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52855816, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52751414, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52751412, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52751401, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52749156, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52749153, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52749147, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52346908, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52034402, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030427, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030421, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49263356, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49218523, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46836001, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46643222, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45217055, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44312434, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45067560, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54587341, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45067555, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54515631, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40359903, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55068708, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32732031, 8);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54515626, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54587343, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53811573, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53189419, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44312431, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55537655, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51856146, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54515623, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53713441, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46906682, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44312435, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56265968, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56265967, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56265966, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56265965, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56261874, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56132463, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56132462, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56060260, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56059296, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56059295, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56059294, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56059292, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56059291, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56059290, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56059288, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56059286, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47901567, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56059285, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46639321, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56056104, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46989298, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961471, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55073830, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961470, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47901566, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961469, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46639320, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961468, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (43034423, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961467, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57464996, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961466, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (29393853, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52580643, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961465, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53639092, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961065, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56058162, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56057681, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961064, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56058159, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44948410, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (39155268, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56059297, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52854479, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56059289, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55395160, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55957179, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56059282, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56058160, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48590497, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55696509, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56058161, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53595784, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38159979, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55687775, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48299411, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44310014, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55687772, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53331013, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543780, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38160027, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51728049, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543771, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54545540, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48590498, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32791655, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543768, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53429801, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173159, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543767, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51728050, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543766, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173158, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431117, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (37995496, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543761, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (43501751, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44969991, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543760, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52616042, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543734, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38160043, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496776, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55538062, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53187320, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56131814, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547200, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55537828, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496777, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52143361, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55537740, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48590496, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54515629, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55537738, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55067354, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55537467, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41407553, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41626904, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55537431, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32846173, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53022504, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54753576, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53811571, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52034508, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55537297, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51856145, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48946091, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55395903, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (20571667, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (43827343, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55395901, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52347194, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54841966, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55068712, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (50099386, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54862997, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52806203, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55068707, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56051917, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53116314, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55060415, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53506376, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46645003, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55060406, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53821930, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55060394, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (29429991, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54487859, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54752621, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (50002398, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54711833, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54752617, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46861426, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54514560, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54752616, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54490961, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53331861, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54752613, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (17259525, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52947252, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55027515, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54752610, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53333187, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54752606, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52859904, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41353274, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54752605, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55073782, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54965834, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54752472, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49162074, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46623597, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706490, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54854751, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56048754, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32727781, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706489, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53506841, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706487, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32584893, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52227400, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706486, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34148006, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48942397, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706485, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54537967, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55244171, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54535568, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706484, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55067913, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706482, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56264257, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55083209, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706477, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53505374, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53022505, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706470, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51973068, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42979232, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706469, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42522906, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54643954, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706467, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55243858, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54505550, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53862854, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706466, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52619128, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706465, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51973070, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52426441, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706464, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51980708, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40367832, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706463, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547126, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56051790, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706462, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54553925, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34159471, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706461, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54531982, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55069752, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706460, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56475672, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430145, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706459, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52752050, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38257466, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706458, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54859073, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53763278, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706457, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47486830, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55073769, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706456, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42456843, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55064857, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706454, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40775678, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55053595, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706453, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58752311, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55073794, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706452, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55954845, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40900419, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706451, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (36963099, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54541626, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706450, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54529854, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28053655, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706449, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54517927, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54543795, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706448, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54384701, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54543688, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706447, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52947255, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54526245, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706446, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53865718, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52752046, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706442, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53821920, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47486835, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706440, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53535088, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51935189, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706439, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42041387, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44833878, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706437, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56051839, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54711834, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706436, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56006026, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54532114, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706435, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58857191, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47798282, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706434, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52855515, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41430991, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706433, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52587334, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38659855, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706432, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52093114, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34178605, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706429, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49520701, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706428, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56057080, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49127132, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706427, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53536107, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48108018, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706426, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52948433, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46993477, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706424, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (26711841, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56137589, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55244016, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706423, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57792853, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52421895, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706422, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53022506, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41663395, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706419, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52856546, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (36957721, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706417, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (50002963, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706416, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55237998, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (30765977, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706413, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57047113, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55954844, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54495030, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54752619, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56489928, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51729139, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54639188, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55063071, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (50118391, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54639185, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44766852, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54633073, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173942, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44391639, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45283923, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54633072, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56052135, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56048764, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54633071, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58751399, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55063970, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54968929, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54633070, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55074985, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57465009, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53980020, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54633069, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56137313, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54632401, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53505401, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54533128, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55398453, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54632400, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54514559, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48608841, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55063971, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54632399, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47486827, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46854662, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55394981, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706488, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55942600, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41544707, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55052278, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706478, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55393785, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40775658, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706438, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55242222, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40661505, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53980019, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58851693, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706431, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53705092, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56475699, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57906690, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52947257, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706425, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54495029, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58851690, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706411, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53984014, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52587332, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56936607, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53536387, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54494940, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968723, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55242022, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51973071, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (30765981, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53867083, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55048556, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55083467, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51856002, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53713469, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55242016, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53713455, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47440048, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54965835, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55063968, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32848921, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55963004, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469052, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53332503, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469048, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54541635, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56056030, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55058840, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54854752, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469042, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54524100, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54994267, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54516874, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54756976, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469011, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54493280, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54498565, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469010, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54756749, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54964896, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53117317, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52951597, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55548326, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54857873, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52752053, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52951596, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55548085, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55053388, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54513137, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44935270, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52926678, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55076285, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53862859, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34158161, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54858029, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52926664, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53862856, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (27300781, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56137375, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52803899, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (5088643, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53536388, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56137314, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52421369, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52492345, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58971128, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52421366, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55056659, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49127930, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58971127, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53767776, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52421364, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58971004, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41405121, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52347126, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55056660, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38258621, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54551053, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42160445, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345674, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54508495, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55399199, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56058316, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345666, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54503341, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58970737, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345660, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55073302, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54495581, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53863474, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345652, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55396388, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53597949, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54490416, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54497066, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345649, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53702932, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52585000, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345648, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42976093, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52492343, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53255166, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345646, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55242218, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52430201, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52492342, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55048553, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345633, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42184269, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49030968, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (43392965, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345622, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47266974, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41241668, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345564, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55076201, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40723582, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58969735, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52034464, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55052275, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58944235, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (20568225, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40687740, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51983273, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58853961, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58857482, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066618, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51983272, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55068713, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58852930, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51983269, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53703150, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58852512, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58851788, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44400052, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51983268, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58851780, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58851429, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51983267, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42345351, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58851664, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55056669, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51983265, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58850212, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58850806, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40724403, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51983263, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58570225, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58850803, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (35338132, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51983262, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58243013, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58850801, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51983261, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58849842, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55048552, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58850800, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54859211, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51983260, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58071803, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58850477, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51971204, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55052286, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55051389, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49835727, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57793372, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58850074, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44899149, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49606208, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58850073, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57465294, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55056657, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49606205, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58849868, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48591670, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41710584, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57464785, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58849866, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48591669, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58857195, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57047578, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54640355, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48294068, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58857193, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47799442, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57047572, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49398428, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58243039, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57047452, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47799428, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55053615, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44833243, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47151455, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57047128, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57907222, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55398465, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47151424, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57047108, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57907217, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54546268, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57047107, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47151403, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52806374, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58243479, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57047101, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47151401, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41710830, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56719276, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54965836, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46995900, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55053390, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46644619, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543174, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57793123, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56937300, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45171009, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54855391, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56937296, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54536414, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45065975, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56937284, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55398462, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54514088, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44312437, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56720486, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066907, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53022665, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53979711, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57907368, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53862860, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345681, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42521208, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53116376, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53767845, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52691266, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52950123, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (50091679, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52952111, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34223976, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52426454, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46906683, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52492351, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55396934, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52356541, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44312441, 10);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48299144, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57465013, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52492347, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47268697, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52492344, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54969037, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51855999, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41713147, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54537568, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47083446, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54859305, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066620, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42119562, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56489942, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066616, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41544709, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56489941, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55073335, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41543868, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56265867, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56144116, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41430985, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52292907, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56489927, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32832337, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55056334, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28059487, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56489926, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56139133, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55053647, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54859304, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56139095, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56138087, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56494143, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55049123, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57047129, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52222313, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56138086, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543779, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57047102, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55049124, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44751826, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56133919, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56264258, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56133918, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42255812, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46645340, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56256643, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56261067, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56139096, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56133895, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56138038, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55056653, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56133894, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52094165, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56137619, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56133893, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55393411, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58072195, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56131862, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56133891, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53120744, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54709866, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53861741, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56133890, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55242229, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345711, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56133342, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58851697, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56133889, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543777, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56049009, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54994243, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55547092, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56133734, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56261069, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55076295, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54713564, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345636, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56051588, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55398485, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55963045, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55069491, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55548095, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55052281, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56138088, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345710, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54968888, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54540644, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961528, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345709, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54534456, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53332315, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54595629, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53905767, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54539250, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345663, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42521200, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53862853, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (35136235, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54490897, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48293847, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53598078, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48293846, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53597182, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55056674, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53256505, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543763, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55056661, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53189951, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53025619, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53429945, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55052280, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53022507, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345707, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52802620, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56133922, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44670503, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52752039, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52582969, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56142335, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267894, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52488746, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54640343, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52492353, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58072196, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51927454, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52492352, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42976008, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58072194, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51978032, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48471868, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58072193, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41405300, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49649064, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47486824, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (35471065, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49524143, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58072192, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46665124, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45217661, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58072191, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55056648, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49330265, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45214080, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49162398, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55049120, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54969028, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38149487, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46847079, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54968893, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345718, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55064407, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45133461, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54968892, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (43998581, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54859306, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345684, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54751610, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41437908, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55242134, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54754333, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52094163, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41406639, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53565807, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41399384, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52094161, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54754332, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49263209, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54755061, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52093013, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40724423, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48581860, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54533101, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45212693, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035035, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38530812, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54532867, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32718017, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035030, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42380110, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54524511, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035028, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41710902, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54512958, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28059747, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49653538, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41710574, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52752044, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55394198, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40647193, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45238446, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52750714, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55392516, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392627, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34707422, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52750348, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55392515, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55960820, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392618, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968724, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55073305, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392589, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55392510, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49379278, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55076288, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56261072, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55051599, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49115330, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55083427, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56261071, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55051598, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54968886, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49115299, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56261068, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47902326, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56261064, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54502129, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55048773, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47308804, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41688870, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56261066, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55051478, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47308539, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706480, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41394422, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54857466, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41710789, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54755045, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961471, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40639741, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40687814, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54856605, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961470, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38244042, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32799763, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54546969, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961469, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54551695, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54541385, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34254712, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961468, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54541632, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54534471, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54968883, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961467, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58851691, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54506470, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54534434, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961466, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54534362, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547251, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54495582, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55961465, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54530419, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55687775, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54489406, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53597183, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54529159, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55687772, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53506783, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54528789, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42380117, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55687765, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52947253, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543780, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55960822, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54514087, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52752051, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543778, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066613, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52750084, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53983530, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543774, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46642848, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066612, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543773, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40714678, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53979708, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52429693, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56576969, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543772, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40648779, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55056658, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53862864, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52428571, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543771, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46910521, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53862863, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543770, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58851687, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52350439, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496409, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53862862, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543768, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54594997, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42173655, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47266980, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53767843, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543767, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34170593, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52952077, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41515858, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55398491, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543766, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (29393873, 27);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41524481, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57465014, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52853650, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543765, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345638, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46914936, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543764, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54854040, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52227286, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53332244, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543762, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47232744, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49653276, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (29898107, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543761, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49162163, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46622799, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430531, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543760, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48673720, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44833233, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430521, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543759, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (43495354, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47761149, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543757, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430506, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42975965, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47074637, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32848059, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543756, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42521206, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34731493, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46991170, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44011829, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543754, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46922468, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54497403, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (27002473, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543752, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44834323, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44011839, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54856194, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543751, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42986726, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496421, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54855416, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55397640, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42986725, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55397639, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430557, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54855398, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42184467, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55397638, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41695294, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57465010, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41683622, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55397636, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40725649, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (30686581, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54968887, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55397634, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32718025, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46835904, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56139424, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55397633, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44011766, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56261911, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (29944845, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55397632, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53707359, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (29751159, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55397625, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56139418, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55397624, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52356300, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (27831743, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56051593, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53705766, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48452913, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (6421, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56139422, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52926483, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (58851696, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (6377, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54638013, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345680, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56059060, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54513139, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47127120, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54643425, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345664, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54513138, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44011830, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53984168, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52032353, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54512615, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345643, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53982481, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54489157, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52356320, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345637, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48592720, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53863257, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46762739, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52093012, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49127915, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53824120, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46642036, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42318454, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53120424, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49653548, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52032360, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48643322, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52752043, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (43780389, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42681291, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44313520, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45238442, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345635, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345595, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52356319, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44670506, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42138198, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51978033, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47127119, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41785149, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44670505, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45277011, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41710575, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46642850, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267898, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45133466, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41696075, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392609, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38530315, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (43668529, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543775, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42041502, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34192492, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38706686, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41546026, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55242252, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55543755, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49127927, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41437905, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55242105, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55397626, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34167799, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42157289, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55242058, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55069494, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32846182, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38154726, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55242021, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55049122, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48452932, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55960821, 26);
# this plID needed for tests
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32846180, 30);
#
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46882319, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55960831, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55049121, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46882315, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55960825, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54708920, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57053090, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496422, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54708919, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48452954, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066615, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54708917, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55075455, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706490, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56139423, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55051421, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706489, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55067121, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53900737, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706487, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55056663, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53900733, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706486, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54861400, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51985109, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54861399, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706485, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48452948, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706484, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54855401, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54968884, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45067896, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706482, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55393413, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706477, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44011832, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54968885, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706470, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44011814, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54855400, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706469, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38258604, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52689273, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38154725, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706467, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706466, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547142, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54640774, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547138, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52689275, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706465, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430552, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54643423, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706464, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430492, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54630387, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706463, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52749093, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706462, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53984352, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52618004, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53982632, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706461, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49589493, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706460, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53982631, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49127923, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706459, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53643739, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48452981, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706458, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52853992, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42965972, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48562559, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706457, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547126, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48383800, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706456, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430495, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48376763, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706455, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52356336, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47018804, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51935221, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706454, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46838251, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430555, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706453, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46771377, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51935207, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706452, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46640741, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (29336529, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46640520, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706451, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55075457, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45196795, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430522, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706450, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44517166, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706449, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52428371, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44113103, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706448, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51985179, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51985149, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42988317, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706447, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51935233, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42980625, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706446, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42319199, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706442, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49589506, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42200854, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706440, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48452969, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40647189, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706439, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48452953, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38662798, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706437, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38575588, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47488152, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706436, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45267066, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706435, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38169033, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42057850, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706434, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (35829857, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38154724, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706433, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (35590639, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547173, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706432, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496428, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (35508837, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706429, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706428, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (35409200, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52356342, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706427, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (35301938, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52179382, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706426, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (35243222, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52034976, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706424, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49589503, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34847456, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706423, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34651202, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47127121, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706422, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34538559, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706419, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41679470, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32794049, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706417, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38258614, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706416, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (30292755, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547164, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706413, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547136, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (15279921, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706488, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430535, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (14648689, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706478, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52032357, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53705285, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706476, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52032356, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52853993, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706472, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52032299, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49418521, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46860897, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706438, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49328817, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44848777, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706431, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47829341, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706425, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42184532, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46924799, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54632484, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706415, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46640067, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54754419, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706412, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42307943, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55075456, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54706411, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38666435, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55075454, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (38662748, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53705770, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55075453, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53705769, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (35414117, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53705767, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547137, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (35325786, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53429971, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496419, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52162544, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34764384, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53429965, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52032355, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53429962, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34749947, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51935220, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53429959, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34342023, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53429958, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49127917, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (30710251, 26);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53333481, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48453043, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53331798, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48453033, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46658214, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53331134, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34178585, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53331128, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547119, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53331127, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54497349, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52951599, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496424, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52951598, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430556, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52951597, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430554, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52951596, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52749102, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52951595, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49127928, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52951594, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46922213, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52951592, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45170894, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52951591, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34178605, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52926678, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32703483, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52926664, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496423, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52926638, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54383468, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52347126, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53816178, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345719, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430504, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345683, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430497, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345682, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52356301, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345677, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51935231, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345676, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51935223, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345675, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49606409, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345674, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49531965, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345673, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49427139, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345668, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49378362, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345666, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49127919, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345660, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49127191, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345656, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48452939, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345655, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46882321, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345654, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46882320, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345652, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44313527, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345651, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44313523, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345649, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41692074, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345648, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40367789, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345647, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28062513, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345646, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54638012, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345642, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54554179, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345638, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547140, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345634, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54497030, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345633, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496427, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345631, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54496425, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345630, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430559, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52094164, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52428411, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52094162, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52162549, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52094160, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49589477, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52093011, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49127926, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49127920, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52093010, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48452991, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52093009, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47127122, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52093008, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41482386, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035043, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40367795, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035042, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34192496, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035038, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55957266, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035036, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55075448, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035033, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55542571, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035032, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547152, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035027, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53900736, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035026, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430482, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035023, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53116580, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035020, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52618012, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035012, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52162548, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51985207, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52032361, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51985192, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51985164, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49653571, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51985151, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49653539, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49606416, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49653533, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34178543, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49653532, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55075450, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48293919, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54862841, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48293878, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54542234, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48293856, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54497351, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48293855, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53900728, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48293854, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53816179, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48293852, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430524, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48293851, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49606412, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48293850, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49606410, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48293849, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49589501, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48293848, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49127925, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173331, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47222702, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173330, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32837891, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173328, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28062517, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173327, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55957284, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173325, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55957265, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47173324, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55541792, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45238456, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54542241, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45238455, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430551, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45238445, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430523, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45238441, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52585455, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44670516, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52428336, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44670515, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52162545, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44670513, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52162536, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44670511, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51985150, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267934, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51939619, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267923, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46882334, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267918, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45170896, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267916, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44101611, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267915, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41455847, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267913, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55957279, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267911, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55957275, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267908, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55957264, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267905, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54755136, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267904, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54754432, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267902, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54549447, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267901, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54532076, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267900, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53983638, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267899, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53816187, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267897, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430563, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267895, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430558, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392624, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430540, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392620, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53332416, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392619, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53255689, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392606, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52749097, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392605, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52356332, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392602, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52162546, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392594, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52032306, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392590, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51985165, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392587, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51935192, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392586, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49531959, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28720607, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49531947, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28720605, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49127930, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28720603, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47488110, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28720599, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47222712, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28720595, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46990658, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28720593, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46643209, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28720591, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45267050, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28720589, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45267049, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53705765, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45207500, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53429944, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45170893, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53333485, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44848791, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345717, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42184482, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345687, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41482389, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345681, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32831799, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345678, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28062511, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345671, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55049795, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345665, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55073935, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345640, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547814, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345635, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430494, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345632, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52947327, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52345628, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52800435, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52094159, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52162550, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52094158, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51967588, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035050, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51967583, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035041, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51935222, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035034, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46990659, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035024, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46860834, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035018, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46642855, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52035007, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45170803, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51985188, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41524482, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48293920, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32849929, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48293917, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28062509, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46645329, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54755135, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45238444, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54754426, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45238438, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54754425, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44670514, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066677, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267910, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54862855, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267909, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54862849, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267903, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54497355, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (42267896, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53900731, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392625, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53820497, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41392595, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53816185, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32720087, 2);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53816170, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53707364, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53332429, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53332417, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52749110, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52162555, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52034412, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52034386, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49606415, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49127921, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47826606, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47260385, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46991072, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45267042, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44315507, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54755137, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54754431, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54754427, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55957274, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55957269, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547821, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547124, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54506152, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54506150, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54497353, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54497350, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54488543, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54384721, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53816180, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430596, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52749099, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52428338, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52356315, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52179390, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52162537, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52034385, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51935195, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49589545, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47260383, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46897717, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46882308, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46835920, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46643208, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46643207, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45216734, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44315512, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44315509, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44315508, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44266848, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41482396, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41459232, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (41459230, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (34178577, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (32850236, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55075452, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54754422, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54549443, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54549442, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54270095, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53900729, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53332397, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52800436, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52749114, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52749113, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52691152, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52691151, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52691149, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52162547, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51967596, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49589476, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47832006, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47826605, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47439734, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47260384, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47260381, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46917182, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46914916, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46860817, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46846597, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45216639, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44266907, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54547817, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54506151, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54488544, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53116581, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52800434, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52800384, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52690409, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49589479, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47831999, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47826607, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (47260382, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46906617, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46860818, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (45216735, 22);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52619497, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53468347, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53331875, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968105, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56484341, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54854101, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55690087, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54590674, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53468341, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53253937, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968068, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525104, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49443447, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072905, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072904, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072903, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072902, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072901, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072900, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072899, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072898, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072897, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072896, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072895, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072894, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072893, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072892, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072891, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072890, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072889, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072888, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072887, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072886, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072885, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072884, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072883, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072882, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072881, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072880, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072879, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072878, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072877, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072876, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072875, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072874, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072873, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072872, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072871, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072870, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072869, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072868, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072867, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072866, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072865, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072864, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072863, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072862, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072861, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072860, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072859, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072858, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072857, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072856, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072855, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072854, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072853, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072852, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072851, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072850, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072849, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072848, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072847, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072846, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072845, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072844, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072843, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072842, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072841, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072840, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072839, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072838, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072837, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072836, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072835, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072834, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072833, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072832, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072831, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072830, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072829, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072828, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072827, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072826, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072825, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072824, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072823, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072822, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072821, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55072819, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55066568, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54859358, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54859357, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54859356, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54859355, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54854103, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54854102, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54854100, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852802, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852801, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852800, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852799, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852798, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852797, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852796, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852795, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852794, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852793, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852792, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852791, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852790, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852789, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852788, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852787, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852786, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852785, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852784, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852783, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852782, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852781, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852780, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852779, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852778, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852777, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54852776, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54755146, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54755145, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54590675, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54590673, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54590672, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54590671, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54524614, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (54524612, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53470619, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53470618, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53470617, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53470613, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53470612, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53470611, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53470610, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53470423, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53470306, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53470305, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469292, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469291, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469290, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469289, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469288, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469287, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469286, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469285, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469284, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469211, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469209, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469208, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469103, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469102, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469099, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53469098, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53468357, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53468356, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53468355, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53468354, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53468352, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53468349, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53468342, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53468340, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53468337, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53468335, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431234, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431233, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431231, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431230, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431229, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431228, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431227, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431226, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431225, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431224, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431223, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431222, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431221, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431220, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431219, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431218, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431217, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53431216, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430950, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430949, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430948, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430947, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430946, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53430945, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395924, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395923, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395922, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395921, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395920, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395919, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395918, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395917, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395916, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395915, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395914, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395913, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395912, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395911, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395910, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395909, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395908, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395907, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395906, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395905, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395904, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395699, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395698, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395697, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395696, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395695, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395694, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395692, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395691, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53334001, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53331874, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53253936, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53253932, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53253930, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53253929, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53253928, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52751143, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52751142, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52751140, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52751138, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52751118, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52619903, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52617998, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52421085, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52348983, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52293089, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290360, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290359, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290358, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290355, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290354, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290353, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290352, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290347, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290346, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290345, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290344, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290343, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290342, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290340, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52290334, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52227606, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52227605, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52227604, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030889, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030887, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030885, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030884, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030883, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030879, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030878, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030877, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030876, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030875, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030874, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030873, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030872, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030871, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030869, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030867, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030860, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030852, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030851, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030849, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030848, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030847, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030846, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030844, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030843, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030841, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030840, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030838, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030837, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030836, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030835, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030834, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030833, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030832, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030827, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030825, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030824, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030823, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030822, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030820, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030819, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030817, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030816, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030815, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030814, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030813, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030812, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030811, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030810, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030807, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030806, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030804, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030803, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030802, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030801, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030800, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030799, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52030797, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51986921, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51986612, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51971254, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51970934, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968117, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968113, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968100, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968090, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968089, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968086, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968084, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968083, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968080, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968078, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968077, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968076, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968075, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968074, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968070, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51968067, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51967862, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51967861, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51925691, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51925685, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51925681, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51925669, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51925665, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51925664, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51925661, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51925658, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51925657, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49531151, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49531104, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49531098, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49531094, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49531085, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49531082, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49531049, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49531022, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49531015, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49530995, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49530985, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49530979, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49530967, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49530949, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49530943, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49530937, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49530932, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49530915, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49530894, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49530882, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525198, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525194, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525191, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525183, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525168, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525159, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525153, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525152, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525144, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525140, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525139, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525127, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525125, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525124, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525122, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53983256, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525119, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46914585, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525118, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44046815, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525112, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (40367867, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525106, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (53395286, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525100, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (48452913, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525098, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (28107677, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525096, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (57055132, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525095, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (56131910, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49525078, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55548070, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49443489, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (51856110, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49443488, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52748984, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49443487, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52750171, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49443486, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52750170, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49443481, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49652730, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49443479, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55541833, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49443477, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49589498, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49325493, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46877516, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (49325477, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55548063, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55548061, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44312381, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44312094, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (52691137, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44312085, 5);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (46643234, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (55396187, 29);
INSERT INTO trak.product_promotion_link (product_pl_id, promotion_id)
VALUES (44312074, 5);


INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58780, '', 'GetUp November', '2019-11-18 06:00:00',
        '2019-11-20 23:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58778, '', 'Luggage Promo 3', '2019-11-18 00:00:00',
        '2019-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58777, '', 'HP 9023 promo', '2019-11-15 14:10:00',
        '2019-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58776, '', 'RIch A50 SS Price Support',
        '2019-11-15 13:30:00', '2019-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58774, '', 'Cycling Flash Sale', '2019-11-18 06:30:00',
        '2019-12-03 23:59:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58771, '', 'November Nappy Madness', '2019-11-15 00:00:00',
        '2019-11-28 23:59:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58770, '', 'Rich Buy Box - November 2019',
        '2019-11-14 10:20:00', '2019-11-30 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58769, '', 'Last of Daily Deals', '2019-11-13 06:30:00',
        '2020-01-03 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58764, '', 'dress up your garden', '2019-11-18 00:00:00',
        '2019-11-21 23:59:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58760, '', 'Luggage promo 2', '2019-11-11 00:00:00',
        '2019-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58759, '', 'Samsung monitors Nov Cores',
        '2019-11-11 13:20:00', '2019-11-30 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58758, '', 'Philips Summer Campaign', '2019-11-11 10:00:00',
        '2019-11-24 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58757, '', 'CapcomWarner Sale', '2019-11-11 00:00:00',
        '2020-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58744, '', 'Epson Buy box NOV', '2019-11-06 10:00:00',
        '2019-11-30 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58740, '', 'HP 6960 Price Support', '2019-11-05 13:00:00',
        '2019-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58735, '', 'Nutribullet 600W promo', '2019-11-06 00:00:00',
        '2019-12-01 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58734, '', 'Vacuum Cleaner RP', '2019-11-18 00:00:00',
        '2019-11-25 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58733, '', 'Moleskine 2020', '2019-11-04 00:00:00',
        '2020-02-29 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58708, '', 'DelonghiKenwood Subsidy', '2019-11-02 00:00:00',
        '2019-11-22 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58672, '', 'XboxSale', '2019-11-01 00:00:00',
        '2019-11-25 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58597, '', 'Buy Box DS - November 2019',
        '2019-10-30 13:30:00', '2019-11-30 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58566, '', 'Big Brands Toys ', '2019-10-25 11:00:00',
        '2019-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58506, '', 'Office Crox', '2019-10-18 00:00:00',
        '2020-10-18 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58479, '', 'Makers & Auchentochan', '2019-10-14 00:00:00',
        '2019-12-31 23:59:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58470, '', 'Asus Laptops October Offers',
        '2019-10-11 00:00:00', '2019-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58460, '', 'Book Club Sale', '2019-11-18 06:30:00',
        '2019-11-25 05:59:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58458, '', 'Tech Madness Sale', '2019-11-18 06:25:00',
        '2019-11-25 05:59:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58451, '', 'Launch Specials ', '2019-11-11 08:15:00',
        '2019-11-18 23:59:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58447, '', 'Kids'' Corner Sale', '2019-11-15 06:10:00',
        '2019-11-19 05:59:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58419, '', 'Daily Deals', '2019-11-18 05:45:00',
        '2019-11-18 23:59:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58418, '', 'App Only Deals', '2019-11-18 05:45:00',
        '2019-11-18 23:59:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58372, '', 'Apple PP INV16891', '2019-10-01 15:45:00',
        '2019-12-16 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58314, '', 'EA SCAN', '2019-09-27 00:00:00',
        '2020-01-07 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58313, '', 'PSN & LIVE Card Sale', '2019-09-19 00:00:00',
        '2020-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58298, '', 'Festive Xbox One Promo', '2019-10-11 00:00:00',
        '2019-12-03 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58268, '', 'Clearance', '2019-10-23 08:45:00',
        '2019-11-22 08:10:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58242, '', 'R and R Promotions', '2019-09-09 13:00:00',
        '2020-03-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58230, '', 'Powerup savings', '2019-09-06 14:00:00',
        '2019-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58145, '', 'Nintendo switch', '2019-08-23 00:00:00',
        '2020-01-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 58134, '', 'X-Gamer Launch', '2019-08-16 00:00:00',
        '2019-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 57945, '', 'Samsung A7 R&R Support', '2019-08-02 12:00:00',
        '2020-01-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 57804, '', 'MegaMarkDowns', '2019-07-16 00:00:00',
        '2021-02-28 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 57803, '', 'Toys Deals', '2019-07-16 11:00:00',
        '2020-12-18 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 57800, '', 'Product', '2019-07-16 00:00:00',
        '2020-06-30 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 57794, '', 'Xbox One X', '2019-07-15 00:00:00',
        '2019-11-28 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 57683, '', 'Products', '2019-06-20 00:00:00',
        '2021-03-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 57667, '', 'Apple X billings', '2019-06-19 12:00:00',
        '2019-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 57571, '', 'Starlink Markdown', '2019-06-03 00:00:00',
        '2020-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 57518, '', 'Gamefinity MD 2019', '2019-05-23 00:00:00',
        '2019-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 57418, '', 'Nikki Bush Birthday Campaign',
        '2019-05-10 11:00:00', '2019-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 57285, '', 'Croxley ', '2019-02-28 00:00:00',
        '2019-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 57024, '', 'Stationery', '2019-02-27 00:00:00',
        '2020-07-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 56996, '', 'L''Or Capsules EDLP', '2019-02-21 14:30:00',
        '2020-01-01 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 56873, '', 'School Readiness Niki Bush',
        '2019-02-04 00:00:00', '2019-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 56832, '', 'MEG MARKDOWN 25012019', '2019-01-25 00:00:00',
        '2020-01-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 56732, '', 'RB EDLP', '2019-02-25 10:00:00',
        '2019-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 56726, '', 'Playstation Classic Console ',
        '2019-01-19 00:00:00', '2020-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 56319, '', 'Fallout 76', '2019-06-13 00:00:00',
        '2020-05-04 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 55725, '', 'MEG MARKDOWN 2018', '2018-09-07 00:00:00',
        '2020-01-01 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 54915, '', 'Ster Games Markdown', '2018-05-09 00:00:00',
        '2019-11-30 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 54795, '', 'BigBrandsPromo', '2018-04-23 00:00:00',
        '2020-01-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 54732, '', 'Dreamwave Speakers', '2018-04-13 00:00:00',
        '2020-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 54571, '', 'Destiny 2 Price drop', '2018-03-20 00:00:00',
        '2020-01-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 54560, '', 'Sims 4 Markdown', '2018-03-19 00:00:00',
        '2020-03-07 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 54489, '', 'Nescafe Classic', '2019-07-03 11:30:00',
        '2022-12-31 00:00:00');
INSERT INTO trak.promotion (created_at, updated_at, deleted_at, promotion_id, name, display_name, start, end)
VALUES ('2019-11-18 22:17:46', '2019-11-18 22:17:46', NULL, 54368, '', 'Clearance Price - SMarkdowns',
        '2018-02-27 00:00:00', '2020-12-31 00:00:00');


INSERT INTO trak.scheduled_task (created_at, updated_at, deleted_at, name, last_run, next_run)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 'PromotionsScheduledTask', '2019-11-18 22:17:45',
        '2019-11-19 12:00:00');
INSERT INTO trak.scheduled_task (created_at, updated_at, deleted_at, name, last_run, next_run)
VALUES ('2019-11-18 22:17:45', '2019-11-18 22:17:45', NULL, 'PriceUpdateScheduledTask', '2019-11-18 22:17:45',
        '2019-11-19 12:00:00');