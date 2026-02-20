echo "*******************************************************"
echo "*** Installing TPCDS sample schema                  ***"
echo "*******************************************************"
cd /tmp
unzip tpcds-data.zip
ls -l *.dat
mkdir /home/oracle/tpcds
mv *.dat /home/oracle/tpcds
rm *.dat
echo "*** Create TPCDS schema"
sqlplus system/$ORACLE_PWD@localhost:1521/$ORACLE_PDB << EOF
    drop user tpcds cascade;
    CREATE USER tpcds IDENTIFIED BY tpcds;
    GRANT CREATE SESSION,
        RESOURCE,
        UNLIMITED TABLESPACE
        TO tpcds;
    CREATE OR REPLACE DIRECTORY tpcds_dir AS '/home/oracle/tpcds';
    GRANT READ ON DIRECTORY tpcds_dir TO tpcds;
CREATE TABLE tpcds.dbgen_version (
    dv_version      VARCHAR2(16 CHAR),
    dv_create_date  DATE,
    dv_create_time  VARCHAR2(10 CHAR),
    dv_cmdline_args VARCHAR2(200 CHAR)
);

CREATE TABLE tpcds.customer_address (
    ca_address_sk    INTEGER NOT NULL,
    ca_address_id    VARCHAR2(16 CHAR) NOT NULL,
    ca_street_number VARCHAR2(10 CHAR),
    ca_street_name   VARCHAR2(60 CHAR),
    ca_street_type   VARCHAR2(15 CHAR),
    ca_suite_number  VARCHAR2(10 CHAR),
    ca_city          VARCHAR2(60 CHAR),
    ca_county        VARCHAR2(30 CHAR),
    ca_state         VARCHAR2(2 CHAR),
    ca_zip           VARCHAR2(10 CHAR),
    ca_country       VARCHAR2(20 CHAR),
    ca_gmt_offset    NUMBER(5, 2),
    ca_location_type VARCHAR2(20 CHAR),
    PRIMARY KEY ( ca_address_sk )
);

CREATE TABLE tpcds.customer_demographics (
    cd_demo_sk            INTEGER NOT NULL,
    cd_gender             VARCHAR2(1 CHAR),
    cd_marital_status     VARCHAR2(1 CHAR),
    cd_education_status   VARCHAR2(20 CHAR),
    cd_purchase_estimate  INTEGER,
    cd_credit_rating      VARCHAR2(10 CHAR),
    cd_dep_count          INTEGER,
    cd_dep_employed_count INTEGER,
    cd_dep_college_count  INTEGER,
    PRIMARY KEY ( cd_demo_sk )
);

CREATE TABLE tpcds.date_dim (
    d_date_sk           INTEGER NOT NULL,
    d_date_id           VARCHAR2(16 CHAR) NOT NULL,
    d_date              DATE,
    d_month_seq         INTEGER,
    d_week_seq          INTEGER,
    d_quarter_seq       INTEGER,
    d_year              INTEGER,
    d_dow               INTEGER,
    d_moy               INTEGER,
    d_dom               INTEGER,
    d_qoy               INTEGER,
    d_fy_year           INTEGER,
    d_fy_quarter_seq    INTEGER,
    d_fy_week_seq       INTEGER,
    d_day_name          VARCHAR2(9 CHAR),
    d_quarter_name      VARCHAR2(6 CHAR),
    d_holiday           VARCHAR2(1 CHAR),
    d_weekend           VARCHAR2(1 CHAR),
    d_following_holiday VARCHAR2(1 CHAR),
    d_first_dom         INTEGER,
    d_last_dom          INTEGER,
    d_same_day_ly       INTEGER,
    d_same_day_lq       INTEGER,
    d_current_day       VARCHAR2(1 CHAR),
    d_current_week      VARCHAR2(1 CHAR),
    d_current_month     VARCHAR2(1 CHAR),
    d_current_quarter   VARCHAR2(1 CHAR),
    d_current_year      VARCHAR2(1 CHAR),
    PRIMARY KEY ( d_date_sk )
);

CREATE TABLE tpcds.warehouse (
    w_warehouse_sk    INTEGER NOT NULL,
    w_warehouse_id    VARCHAR2(16 CHAR) NOT NULL,
    w_warehouse_name  VARCHAR2(20 CHAR),
    w_warehouse_sq_ft INTEGER,
    w_street_number   VARCHAR2(10 CHAR),
    w_street_name     VARCHAR2(60 CHAR),
    w_street_type     VARCHAR2(15 CHAR),
    w_suite_number    VARCHAR2(10 CHAR),
    w_city            VARCHAR2(60 CHAR),
    w_county          VARCHAR2(30 CHAR),
    w_state           VARCHAR2(2 CHAR),
    w_zip             VARCHAR2(10 CHAR),
    w_country         VARCHAR2(20 CHAR),
    w_gmt_offset      NUMBER(5, 2),
    PRIMARY KEY ( w_warehouse_sk )
);

CREATE TABLE tpcds.ship_mode (
    sm_ship_mode_sk INTEGER NOT NULL,
    sm_ship_mode_id VARCHAR2(16 CHAR) NOT NULL,
    sm_type         VARCHAR2(30 CHAR),
    sm_code         VARCHAR2(10 CHAR),
    sm_carrier      VARCHAR2(20 CHAR),
    sm_contract     VARCHAR2(20 CHAR),
    PRIMARY KEY ( sm_ship_mode_sk )
);

CREATE TABLE tpcds.time_dim (
    t_time_sk   INTEGER NOT NULL,
    t_time_id   VARCHAR2(16 CHAR) NOT NULL,
    t_time      INTEGER,
    t_hour      INTEGER,
    t_minute    INTEGER,
    t_second    INTEGER,
    t_am_pm     VARCHAR2(2 CHAR),
    t_shift     VARCHAR2(20 CHAR),
    t_sub_shift VARCHAR2(20 CHAR),
    t_meal_time VARCHAR2(20 CHAR),
    PRIMARY KEY ( t_time_sk )
);

CREATE TABLE tpcds.reason (
    r_reason_sk   INTEGER NOT NULL,
    r_reason_id   VARCHAR2(16 CHAR) NOT NULL,
    r_reason_desc VARCHAR2(100 CHAR),
    PRIMARY KEY ( r_reason_sk )
);

CREATE TABLE tpcds.income_band (
    ib_income_band_sk INTEGER NOT NULL,
    ib_lower_bound    INTEGER,
    ib_upper_bound    INTEGER,
    PRIMARY KEY ( ib_income_band_sk )
);

CREATE TABLE tpcds.item (
    i_item_sk        INTEGER NOT NULL,
    i_item_id        VARCHAR2(16 CHAR) NOT NULL,
    i_rec_start_date DATE,
    i_rec_end_date   DATE,
    i_item_desc      VARCHAR2(200 CHAR),
    i_current_price  NUMBER(7, 2),
    i_wholesale_cost NUMBER(7, 2),
    i_brand_id       INTEGER,
    i_brand          VARCHAR2(50 CHAR),
    i_class_id       INTEGER,
    i_class          VARCHAR2(50 CHAR),
    i_category_id    INTEGER,
    i_category       VARCHAR2(50 CHAR),
    i_manufact_id    INTEGER,
    i_manufact       VARCHAR2(50 CHAR),
    i_size           VARCHAR2(20 CHAR),
    i_formulation    VARCHAR2(20 CHAR),
    i_color          VARCHAR2(20 CHAR),
    i_units          VARCHAR2(10 CHAR),
    i_container      VARCHAR2(10 CHAR),
    i_manager_id     INTEGER,
    i_product_name   VARCHAR2(50 CHAR),
    PRIMARY KEY ( i_item_sk )
);

CREATE TABLE tpcds.store (
    s_store_sk         INTEGER NOT NULL,
    s_store_id         VARCHAR2(16 CHAR) NOT NULL,
    s_rec_start_date   DATE,
    s_rec_end_date     DATE,
    s_closed_date_sk   INTEGER,
    s_store_name       VARCHAR2(50 CHAR),
    s_number_employees INTEGER,
    s_floor_space      INTEGER,
    s_hours            VARCHAR2(20 CHAR),
    s_manager          VARCHAR2(40 CHAR),
    s_market_id        INTEGER,
    s_geography_class  VARCHAR2(100 CHAR),
    s_market_desc      VARCHAR2(100 CHAR),
    s_market_manager   VARCHAR2(40 CHAR),
    s_division_id      INTEGER,
    s_division_name    VARCHAR2(50 CHAR),
    s_company_id       INTEGER,
    s_company_name     VARCHAR2(50 CHAR),
    s_street_number    VARCHAR2(10 CHAR),
    s_street_name      VARCHAR2(60 CHAR),
    s_street_type      VARCHAR2(15 CHAR),
    s_suite_number     VARCHAR2(10 CHAR),
    s_city             VARCHAR2(60 CHAR),
    s_county           VARCHAR2(30 CHAR),
    s_state            VARCHAR2(2 CHAR),
    s_zip              VARCHAR2(10 CHAR),
    s_country          VARCHAR2(20 CHAR),
    s_gmt_offset       NUMBER(5, 2),
    s_tax_precentage   NUMBER(5, 2),
    PRIMARY KEY ( s_store_sk )
);

CREATE TABLE tpcds.call_center (
    cc_call_center_sk INTEGER NOT NULL,
    cc_call_center_id VARCHAR2(16 CHAR) NOT NULL,
    cc_rec_start_date DATE,
    cc_rec_end_date   DATE,
    cc_closed_date_sk INTEGER,
    cc_open_date_sk   INTEGER,
    cc_name           VARCHAR2(50 CHAR),
    cc_class          VARCHAR2(50 CHAR),
    cc_employees      INTEGER,
    cc_sq_ft          INTEGER,
    cc_hours          VARCHAR2(20 CHAR),
    cc_manager        VARCHAR2(40 CHAR),
    cc_mkt_id         INTEGER,
    cc_mkt_class      VARCHAR2(50 CHAR),
    cc_mkt_desc       VARCHAR2(100 CHAR),
    cc_market_manager VARCHAR2(40 CHAR),
    cc_division       INTEGER,
    cc_division_name  VARCHAR2(50 CHAR),
    cc_company        INTEGER,
    cc_company_name   VARCHAR2(50 CHAR),
    cc_street_number  VARCHAR2(10 CHAR),
    cc_street_name    VARCHAR2(60 CHAR),
    cc_street_type    VARCHAR2(15 CHAR),
    cc_suite_number   VARCHAR2(10 CHAR),
    cc_city           VARCHAR2(60 CHAR),
    cc_county         VARCHAR2(30 CHAR),
    cc_state          VARCHAR2(2 CHAR),
    cc_zip            VARCHAR2(10 CHAR),
    cc_country        VARCHAR2(20 CHAR),
    cc_gmt_offset     NUMBER(5, 2),
    cc_tax_percentage NUMBER(5, 2),
    PRIMARY KEY ( cc_call_center_sk )
);

CREATE TABLE tpcds.customer (
    c_customer_sk          INTEGER NOT NULL,
    c_customer_id          VARCHAR2(16 CHAR) NOT NULL,
    c_current_cdemo_sk     INTEGER,
    c_current_hdemo_sk     INTEGER,
    c_current_addr_sk      INTEGER,
    c_first_shipto_date_sk INTEGER,
    c_first_sales_date_sk  INTEGER,
    c_salutation           VARCHAR2(10 CHAR),
    c_first_name           VARCHAR2(20 CHAR),
    c_last_name            VARCHAR2(30 CHAR),
    c_preferred_cust_flag  VARCHAR2(1 CHAR),
    c_birth_day            INTEGER,
    c_birth_month          INTEGER,
    c_birth_year           INTEGER,
    c_birth_country        VARCHAR2(20 CHAR),
    c_login                VARCHAR2(13 CHAR),
    c_email_address        VARCHAR2(50 CHAR),
    c_last_review_date     VARCHAR2(10 CHAR),
    PRIMARY KEY ( c_customer_sk )
);

CREATE TABLE tpcds.web_site (
    web_site_sk        INTEGER NOT NULL,
    web_site_id        VARCHAR2(16 CHAR) NOT NULL,
    web_rec_start_date DATE,
    web_rec_end_date   DATE,
    web_name           VARCHAR2(50 CHAR),
    web_open_date_sk   INTEGER,
    web_close_date_sk  INTEGER,
    web_class          VARCHAR2(50 CHAR),
    web_manager        VARCHAR2(40 CHAR),
    web_mkt_id         INTEGER,
    web_mkt_class      VARCHAR2(50 CHAR),
    web_mkt_desc       VARCHAR2(100 CHAR),
    web_market_manager VARCHAR2(40 CHAR),
    web_company_id     INTEGER,
    web_company_name   VARCHAR2(50 CHAR),
    web_street_number  VARCHAR2(10 CHAR),
    web_street_name    VARCHAR2(60 CHAR),
    web_street_type    VARCHAR2(15 CHAR),
    web_suite_number   VARCHAR2(10 CHAR),
    web_city           VARCHAR2(60 CHAR),
    web_county         VARCHAR2(30 CHAR),
    web_state          VARCHAR2(2 CHAR),
    web_zip            VARCHAR2(10 CHAR),
    web_country        VARCHAR2(20 CHAR),
    web_gmt_offset     NUMBER(5, 2),
    web_tax_percentage NUMBER(5, 2),
    PRIMARY KEY ( web_site_sk )
);

CREATE TABLE tpcds.store_returns (
    sr_returned_date_sk   INTEGER,
    sr_return_time_sk     INTEGER,
    sr_item_sk            INTEGER NOT NULL,
    sr_customer_sk        INTEGER,
    sr_cdemo_sk           INTEGER,
    sr_hdemo_sk           INTEGER,
    sr_addr_sk            INTEGER,
    sr_store_sk           INTEGER,
    sr_reason_sk          INTEGER,
    sr_ticket_number      INTEGER NOT NULL,
    sr_return_quantity    INTEGER,
    sr_return_amt         NUMBER(7, 2),
    sr_return_tax         NUMBER(7, 2),
    sr_return_amt_inc_tax NUMBER(7, 2),
    sr_fee                NUMBER(7, 2),
    sr_return_ship_cost   NUMBER(7, 2),
    sr_refunded_cash      NUMBER(7, 2),
    sr_reversed_charge    NUMBER(7, 2),
    sr_store_credit       NUMBER(7, 2),
    sr_net_loss           NUMBER(7, 2),
    PRIMARY KEY ( sr_item_sk,
                  sr_ticket_number )
);

CREATE TABLE tpcds.household_demographics (
    hd_demo_sk        INTEGER NOT NULL,
    hd_income_band_sk INTEGER,
    hd_buy_potential  VARCHAR2(15 CHAR),
    hd_dep_count      INTEGER,
    hd_vehicle_count  INTEGER,
    PRIMARY KEY ( hd_demo_sk )
);

CREATE TABLE tpcds.web_page (
    wp_web_page_sk      INTEGER NOT NULL,
    wp_web_page_id      VARCHAR2(16 CHAR) NOT NULL,
    wp_rec_start_date   DATE,
    wp_rec_end_date     DATE,
    wp_creation_date_sk INTEGER,
    wp_access_date_sk   INTEGER,
    wp_autogen_flag     VARCHAR2(1 CHAR),
    wp_customer_sk      INTEGER,
    wp_url              VARCHAR2(100 CHAR),
    wp_type             VARCHAR2(50 CHAR),
    wp_char_count       INTEGER,
    wp_link_count       INTEGER,
    wp_image_count      INTEGER,
    wp_max_ad_count     INTEGER,
    PRIMARY KEY ( wp_web_page_sk )
);

CREATE TABLE tpcds.promotion (
    p_promo_sk        INTEGER NOT NULL,
    p_promo_id        VARCHAR2(16 CHAR) NOT NULL,
    p_start_date_sk   INTEGER,
    p_end_date_sk     INTEGER,
    p_item_sk         INTEGER,
    p_cost            NUMBER(15, 2),
    p_response_target INTEGER,
    p_promo_name      VARCHAR2(50 CHAR),
    p_channel_dmail   VARCHAR2(1 CHAR),
    p_channel_email   VARCHAR2(1 CHAR),
    p_channel_catalog VARCHAR2(1 CHAR),
    p_channel_tv      VARCHAR2(1 CHAR),
    p_channel_radio   VARCHAR2(1 CHAR),
    p_channel_press   VARCHAR2(1 CHAR),
    p_channel_event   VARCHAR2(1 CHAR),
    p_channel_demo    VARCHAR2(1 CHAR),
    p_channel_details VARCHAR2(100 CHAR),
    p_purpose         VARCHAR2(15 CHAR),
    p_discount_active VARCHAR2(1 CHAR),
    PRIMARY KEY ( p_promo_sk )
);

CREATE TABLE tpcds.catalog_page (
    cp_catalog_page_sk     INTEGER NOT NULL,
    cp_catalog_page_id     VARCHAR2(16 CHAR) NOT NULL,
    cp_start_date_sk       INTEGER,
    cp_end_date_sk         INTEGER,
    cp_department          VARCHAR2(50 CHAR),
    cp_catalog_number      INTEGER,
    cp_catalog_page_number INTEGER,
    cp_description         VARCHAR2(100 CHAR),
    cp_type                VARCHAR2(100 CHAR),
    PRIMARY KEY ( cp_catalog_page_sk )
);

CREATE TABLE tpcds.inventory (
    inv_date_sk          INTEGER NOT NULL,
    inv_item_sk          INTEGER NOT NULL,
    inv_warehouse_sk     INTEGER NOT NULL,
    inv_quantity_on_hand INTEGER,
    PRIMARY KEY ( inv_date_sk,
                  inv_item_sk,
                  inv_warehouse_sk )
);

CREATE TABLE tpcds.catalog_returns (
    cr_returned_date_sk      INTEGER,
    cr_returned_time_sk      INTEGER,
    cr_item_sk               INTEGER NOT NULL,
    cr_refunded_customer_sk  INTEGER,
    cr_refunded_cdemo_sk     INTEGER,
    cr_refunded_hdemo_sk     INTEGER,
    cr_refunded_addr_sk      INTEGER,
    cr_returning_customer_sk INTEGER,
    cr_returning_cdemo_sk    INTEGER,
    cr_returning_hdemo_sk    INTEGER,
    cr_returning_addr_sk     INTEGER,
    cr_call_center_sk        INTEGER,
    cr_catalog_page_sk       INTEGER,
    cr_ship_mode_sk          INTEGER,
    cr_warehouse_sk          INTEGER,
    cr_reason_sk             INTEGER,
    cr_order_number          INTEGER NOT NULL,
    cr_return_quantity       INTEGER,
    cr_return_amount         NUMBER(7, 2),
    cr_return_tax            NUMBER(7, 2),
    cr_return_amt_inc_tax    NUMBER(7, 2),
    cr_fee                   NUMBER(7, 2),
    cr_return_ship_cost      NUMBER(7, 2),
    cr_refunded_cash         NUMBER(7, 2),
    cr_reversed_charge       NUMBER(7, 2),
    cr_store_credit          NUMBER(7, 2),
    cr_net_loss              NUMBER(7, 2),
    PRIMARY KEY ( cr_item_sk,
                  cr_order_number )
);

CREATE TABLE tpcds.web_returns (
    wr_returned_date_sk      INTEGER,
    wr_returned_time_sk      INTEGER,
    wr_item_sk               INTEGER NOT NULL,
    wr_refunded_customer_sk  INTEGER,
    wr_refunded_cdemo_sk     INTEGER,
    wr_refunded_hdemo_sk     INTEGER,
    wr_refunded_addr_sk      INTEGER,
    wr_returning_customer_sk INTEGER,
    wr_returning_cdemo_sk    INTEGER,
    wr_returning_hdemo_sk    INTEGER,
    wr_returning_addr_sk     INTEGER,
    wr_web_page_sk           INTEGER,
    wr_reason_sk             INTEGER,
    wr_order_number          INTEGER NOT NULL,
    wr_return_quantity       INTEGER,
    wr_return_amt            NUMBER(7, 2),
    wr_return_tax            NUMBER(7, 2),
    wr_return_amt_inc_tax    NUMBER(7, 2),
    wr_fee                   NUMBER(7, 2),
    wr_return_ship_cost      NUMBER(7, 2),
    wr_refunded_cash         NUMBER(7, 2),
    wr_reversed_charge       NUMBER(7, 2),
    wr_account_credit        NUMBER(7, 2),
    wr_net_loss              NUMBER(7, 2),
    PRIMARY KEY ( wr_item_sk,
                  wr_order_number )
);

CREATE TABLE tpcds.web_sales (
    ws_sold_date_sk          INTEGER,
    ws_sold_time_sk          INTEGER,
    ws_ship_date_sk          INTEGER,
    ws_item_sk               INTEGER NOT NULL,
    ws_bill_customer_sk      INTEGER,
    ws_bill_cdemo_sk         INTEGER,
    ws_bill_hdemo_sk         INTEGER,
    ws_bill_addr_sk          INTEGER,
    ws_ship_customer_sk      INTEGER,
    ws_ship_cdemo_sk         INTEGER,
    ws_ship_hdemo_sk         INTEGER,
    ws_ship_addr_sk          INTEGER,
    ws_web_page_sk           INTEGER,
    ws_web_site_sk           INTEGER,
    ws_ship_mode_sk          INTEGER,
    ws_warehouse_sk          INTEGER,
    ws_promo_sk              INTEGER,
    ws_order_number          INTEGER NOT NULL,
    ws_quantity              INTEGER,
    ws_wholesale_cost        NUMBER(7, 2),
    ws_list_price            NUMBER(7, 2),
    ws_sales_price           NUMBER(7, 2),
    ws_ext_discount_amt      NUMBER(7, 2),
    ws_ext_sales_price       NUMBER(7, 2),
    ws_ext_wholesale_cost    NUMBER(7, 2),
    ws_ext_list_price        NUMBER(7, 2),
    ws_ext_tax               NUMBER(7, 2),
    ws_coupon_amt            NUMBER(7, 2),
    ws_ext_ship_cost         NUMBER(7, 2),
    ws_net_paid              NUMBER(7, 2),
    ws_net_paid_inc_tax      NUMBER(7, 2),
    ws_net_paid_inc_ship     NUMBER(7, 2),
    ws_net_paid_inc_ship_tax NUMBER(7, 2),
    ws_net_profit            NUMBER(7, 2),
    PRIMARY KEY ( ws_item_sk,
                  ws_order_number )
);

CREATE TABLE tpcds.catalog_sales (
    cs_sold_date_sk          INTEGER,
    cs_sold_time_sk          INTEGER,
    cs_ship_date_sk          INTEGER,
    cs_bill_customer_sk      INTEGER,
    cs_bill_cdemo_sk         INTEGER,
    cs_bill_hdemo_sk         INTEGER,
    cs_bill_addr_sk          INTEGER,
    cs_ship_customer_sk      INTEGER,
    cs_ship_cdemo_sk         INTEGER,
    cs_ship_hdemo_sk         INTEGER,
    cs_ship_addr_sk          INTEGER,
    cs_call_center_sk        INTEGER,
    cs_catalog_page_sk       INTEGER,
    cs_ship_mode_sk          INTEGER,
    cs_warehouse_sk          INTEGER,
    cs_item_sk               INTEGER NOT NULL,
    cs_promo_sk              INTEGER,
    cs_order_number          INTEGER NOT NULL,
    cs_quantity              INTEGER,
    cs_wholesale_cost        NUMBER(7, 2),
    cs_list_price            NUMBER(7, 2),
    cs_sales_price           NUMBER(7, 2),
    cs_ext_discount_amt      NUMBER(7, 2),
    cs_ext_sales_price       NUMBER(7, 2),
    cs_ext_wholesale_cost    NUMBER(7, 2),
    cs_ext_list_price        NUMBER(7, 2),
    cs_ext_tax               NUMBER(7, 2),
    cs_coupon_amt            NUMBER(7, 2),
    cs_ext_ship_cost         NUMBER(7, 2),
    cs_net_paid              NUMBER(7, 2),
    cs_net_paid_inc_tax      NUMBER(7, 2),
    cs_net_paid_inc_ship     NUMBER(7, 2),
    cs_net_paid_inc_ship_tax NUMBER(7, 2),
    cs_net_profit            NUMBER(7, 2),
    PRIMARY KEY ( cs_item_sk,
                  cs_order_number )
);

CREATE TABLE tpcds.store_sales (
    ss_sold_date_sk       INTEGER,
    ss_sold_time_sk       INTEGER,
    ss_item_sk            INTEGER NOT NULL,
    ss_customer_sk        INTEGER,
    ss_cdemo_sk           INTEGER,
    ss_hdemo_sk           INTEGER,
    ss_addr_sk            INTEGER,
    ss_store_sk           INTEGER,
    ss_promo_sk           INTEGER,
    ss_ticket_number      INTEGER NOT NULL,
    ss_quantity           INTEGER,
    ss_wholesale_cost     NUMBER(7, 2),
    ss_list_price         NUMBER(7, 2),
    ss_sales_price        NUMBER(7, 2),
    ss_ext_discount_amt   NUMBER(7, 2),
    ss_ext_sales_price    NUMBER(7, 2),
    ss_ext_wholesale_cost NUMBER(7, 2),
    ss_ext_list_price     NUMBER(7, 2),
    ss_ext_tax            NUMBER(7, 2),
    ss_coupon_amt         NUMBER(7, 2),
    ss_net_paid           NUMBER(7, 2),
    ss_net_paid_inc_tax   NUMBER(7, 2),
    ss_net_profit         NUMBER(7, 2),
    PRIMARY KEY ( ss_item_sk,
                  ss_ticket_number )
);

CREATE TABLE tpcds.ext_dbgen_version (
    dv_version      VARCHAR2(16 CHAR),
    dv_create_date  VARCHAR2(10 CHAR),
    dv_create_time  VARCHAR2(10 CHAR),
    dv_cmdline_args VARCHAR2(200 CHAR)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('dbgen_version.dat'));

CREATE TABLE tpcds.ext_customer_address (
    ca_address_sk    INTEGER NOT NULL,
    ca_address_id    VARCHAR2(16 CHAR) NOT NULL,
    ca_street_number VARCHAR2(10 CHAR),
    ca_street_name   VARCHAR2(60 CHAR),
    ca_street_type   VARCHAR2(15 CHAR),
    ca_suite_number  VARCHAR2(10 CHAR),
    ca_city          VARCHAR2(60 CHAR),
    ca_county        VARCHAR2(30 CHAR),
    ca_state         VARCHAR2(2 CHAR),
    ca_zip           VARCHAR2(10 CHAR),
    ca_country       VARCHAR2(20 CHAR),
    ca_gmt_offset    NUMBER(5, 2),
    ca_location_type VARCHAR2(20 CHAR)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('customer_address.dat'));

CREATE TABLE tpcds.ext_customer_demographics (
    cd_demo_sk            INTEGER NOT NULL,
    cd_gender             VARCHAR2(1 CHAR),
    cd_marital_status     VARCHAR2(1 CHAR),
    cd_education_status   VARCHAR2(20 CHAR),
    cd_purchase_estimate  INTEGER,
    cd_credit_rating      VARCHAR2(10 CHAR),
    cd_dep_count          INTEGER,
    cd_dep_employed_count INTEGER,
    cd_dep_college_count  INTEGER
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('customer_demographics.dat'));

CREATE TABLE tpcds.ext_date_dim (
    d_date_sk           INTEGER NOT NULL,
    d_date_id           VARCHAR2(16 CHAR) NOT NULL,
    d_date              VARCHAR2(10 CHAR),
    d_month_seq         INTEGER,
    d_week_seq          INTEGER,
    d_quarter_seq       INTEGER,
    d_year              INTEGER,
    d_dow               INTEGER,
    d_moy               INTEGER,
    d_dom               INTEGER,
    d_qoy               INTEGER,
    d_fy_year           INTEGER,
    d_fy_quarter_seq    INTEGER,
    d_fy_week_seq       INTEGER,
    d_day_name          VARCHAR2(9 CHAR),
    d_quarter_name      VARCHAR2(6 CHAR),
    d_holiday           VARCHAR2(1 CHAR),
    d_weekend           VARCHAR2(1 CHAR),
    d_following_holiday VARCHAR2(1 CHAR),
    d_first_dom         INTEGER,
    d_last_dom          INTEGER,
    d_same_day_ly       INTEGER,
    d_same_day_lq       INTEGER,
    d_current_day       VARCHAR2(1 CHAR),
    d_current_week      VARCHAR2(1 CHAR),
    d_current_month     VARCHAR2(1 CHAR),
    d_current_quarter   VARCHAR2(1 CHAR),
    d_current_year      VARCHAR2(1 CHAR)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('date_dim.dat'));

CREATE TABLE tpcds.ext_warehouse (
    w_warehouse_sk    INTEGER NOT NULL,
    w_warehouse_id    VARCHAR2(16 CHAR) NOT NULL,
    w_warehouse_name  VARCHAR2(20 CHAR),
    w_warehouse_sq_ft INTEGER,
    w_street_number   VARCHAR2(10 CHAR),
    w_street_name     VARCHAR2(60 CHAR),
    w_street_type     VARCHAR2(15 CHAR),
    w_suite_number    VARCHAR2(10 CHAR),
    w_city            VARCHAR2(60 CHAR),
    w_county          VARCHAR2(30 CHAR),
    w_state           VARCHAR2(2 CHAR),
    w_zip             VARCHAR2(10 CHAR),
    w_country         VARCHAR2(20 CHAR),
    w_gmt_offset      NUMBER(5, 2)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('warehouse.dat'));

CREATE TABLE tpcds.ext_ship_mode (
    sm_ship_mode_sk INTEGER NOT NULL,
    sm_ship_mode_id VARCHAR2(16 CHAR) NOT NULL,
    sm_type         VARCHAR2(30 CHAR),
    sm_code         VARCHAR2(10 CHAR),
    sm_carrier      VARCHAR2(20 CHAR),
    sm_contract     VARCHAR2(20 CHAR)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('ship_mode.dat'));

CREATE TABLE tpcds.ext_time_dim (
    t_time_sk   INTEGER NOT NULL,
    t_time_id   VARCHAR2(16 CHAR) NOT NULL,
    t_time      INTEGER,
    t_hour      INTEGER,
    t_minute    INTEGER,
    t_second    INTEGER,
    t_am_pm     VARCHAR2(2 CHAR),
    t_shift     VARCHAR2(20 CHAR),
    t_sub_shift VARCHAR2(20 CHAR),
    t_meal_time VARCHAR2(20 CHAR)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('time_dim.dat'));

CREATE TABLE tpcds.ext_reason (
    r_reason_sk   INTEGER NOT NULL,
    r_reason_id   VARCHAR2(16 CHAR) NOT NULL,
    r_reason_desc VARCHAR2(100 CHAR)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('reason.dat'));

CREATE TABLE tpcds.ext_income_band (
    ib_income_band_sk INTEGER NOT NULL,
    ib_lower_bound    INTEGER,
    ib_upper_bound    INTEGER
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('income_band.dat'));

CREATE TABLE tpcds.ext_item (
    i_item_sk        INTEGER NOT NULL,
    i_item_id        VARCHAR2(16 CHAR) NOT NULL,
    i_rec_start_date VARCHAR2(10 CHAR),
    i_rec_end_date   VARCHAR2(10 CHAR),
    i_item_desc      VARCHAR2(200 CHAR),
    i_current_price  NUMBER(7, 2),
    i_wholesale_cost NUMBER(7, 2),
    i_brand_id       INTEGER,
    i_brand          VARCHAR2(50 CHAR),
    i_class_id       INTEGER,
    i_class          VARCHAR2(50 CHAR),
    i_category_id    INTEGER,
    i_category       VARCHAR2(50 CHAR),
    i_manufact_id    INTEGER,
    i_manufact       VARCHAR2(50 CHAR),
    i_size           VARCHAR2(20 CHAR),
    i_formulation    VARCHAR2(20 CHAR),
    i_color          VARCHAR2(20 CHAR),
    i_units          VARCHAR2(10 CHAR),
    i_container      VARCHAR2(10 CHAR),
    i_manager_id     INTEGER,
    i_product_name   VARCHAR2(50 CHAR)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('item.dat'));

CREATE TABLE tpcds.ext_store (
    s_store_sk         INTEGER NOT NULL,
    s_store_id         VARCHAR2(16 CHAR) NOT NULL,
    s_rec_start_date   VARCHAR2(10 CHAR),
    s_rec_end_date     VARCHAR2(10 CHAR),
    s_closed_date_sk   INTEGER,
    s_store_name       VARCHAR2(50 CHAR),
    s_number_employees INTEGER,
    s_floor_space      INTEGER,
    s_hours            VARCHAR2(20 CHAR),
    s_manager          VARCHAR2(40 CHAR),
    s_market_id        INTEGER,
    s_geography_class  VARCHAR2(100 CHAR),
    s_market_desc      VARCHAR2(100 CHAR),
    s_market_manager   VARCHAR2(40 CHAR),
    s_division_id      INTEGER,
    s_division_name    VARCHAR2(50 CHAR),
    s_company_id       INTEGER,
    s_company_name     VARCHAR2(50 CHAR),
    s_street_number    VARCHAR2(10 CHAR),
    s_street_name      VARCHAR2(60 CHAR),
    s_street_type      VARCHAR2(15 CHAR),
    s_suite_number     VARCHAR2(10 CHAR),
    s_city             VARCHAR2(60 CHAR),
    s_county           VARCHAR2(30 CHAR),
    s_state            VARCHAR2(2 CHAR),
    s_zip              VARCHAR2(10 CHAR),
    s_country          VARCHAR2(20 CHAR),
    s_gmt_offset       NUMBER(5, 2),
    s_tax_precentage   NUMBER(5, 2)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('store.dat'));

CREATE TABLE tpcds.ext_call_center (
    cc_call_center_sk INTEGER NOT NULL,
    cc_call_center_id VARCHAR2(16 CHAR) NOT NULL,
    cc_rec_start_date VARCHAR2(10 CHAR),
    cc_rec_end_date   VARCHAR2(10 CHAR),
    cc_closed_date_sk INTEGER,
    cc_open_date_sk   INTEGER,
    cc_name           VARCHAR2(50 CHAR),
    cc_class          VARCHAR2(50 CHAR),
    cc_employees      INTEGER,
    cc_sq_ft          INTEGER,
    cc_hours          VARCHAR2(20 CHAR),
    cc_manager        VARCHAR2(40 CHAR),
    cc_mkt_id         INTEGER,
    cc_mkt_class      VARCHAR2(50 CHAR),
    cc_mkt_desc       VARCHAR2(100 CHAR),
    cc_market_manager VARCHAR2(40 CHAR),
    cc_division       INTEGER,
    cc_division_name  VARCHAR2(50 CHAR),
    cc_company        INTEGER,
    cc_company_name   VARCHAR2(50 CHAR),
    cc_street_number  VARCHAR2(10 CHAR),
    cc_street_name    VARCHAR2(60 CHAR),
    cc_street_type    VARCHAR2(15 CHAR),
    cc_suite_number   VARCHAR2(10 CHAR),
    cc_city           VARCHAR2(60 CHAR),
    cc_county         VARCHAR2(30 CHAR),
    cc_state          VARCHAR2(2 CHAR),
    cc_zip            VARCHAR2(10 CHAR),
    cc_country        VARCHAR2(20 CHAR),
    cc_gmt_offset     NUMBER(5, 2),
    cc_tax_percentage NUMBER(5, 2)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('call_center.dat'));

CREATE TABLE tpcds.ext_customer (
    c_customer_sk          INTEGER NOT NULL,
    c_customer_id          VARCHAR2(16 CHAR) NOT NULL,
    c_current_cdemo_sk     INTEGER,
    c_current_hdemo_sk     INTEGER,
    c_current_addr_sk      INTEGER,
    c_first_shipto_date_sk INTEGER,
    c_first_sales_date_sk  INTEGER,
    c_salutation           VARCHAR2(10 CHAR),
    c_first_name           VARCHAR2(20 CHAR),
    c_last_name            VARCHAR2(30 CHAR),
    c_preferred_cust_flag  VARCHAR2(1 CHAR),
    c_birth_day            INTEGER,
    c_birth_month          INTEGER,
    c_birth_year           INTEGER,
    c_birth_country        VARCHAR2(20 CHAR),
    c_login                VARCHAR2(13 CHAR),
    c_email_address        VARCHAR2(50 CHAR),
    c_last_review_date     VARCHAR2(10 CHAR)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('customer.dat'));

CREATE TABLE tpcds.ext_web_site (
    web_site_sk        INTEGER NOT NULL,
    web_site_id        VARCHAR2(16 CHAR) NOT NULL,
    web_rec_start_date VARCHAR2(10 CHAR),
    web_rec_end_date   VARCHAR2(10 CHAR),
    web_name           VARCHAR2(50 CHAR),
    web_open_date_sk   INTEGER,
    web_close_date_sk  INTEGER,
    web_class          VARCHAR2(50 CHAR),
    web_manager        VARCHAR2(40 CHAR),
    web_mkt_id         INTEGER,
    web_mkt_class      VARCHAR2(50 CHAR),
    web_mkt_desc       VARCHAR2(100 CHAR),
    web_market_manager VARCHAR2(40 CHAR),
    web_company_id     INTEGER,
    web_company_name   VARCHAR2(50 CHAR),
    web_street_number  VARCHAR2(10 CHAR),
    web_street_name    VARCHAR2(60 CHAR),
    web_street_type    VARCHAR2(15 CHAR),
    web_suite_number   VARCHAR2(10 CHAR),
    web_city           VARCHAR2(60 CHAR),
    web_county         VARCHAR2(30 CHAR),
    web_state          VARCHAR2(2 CHAR),
    web_zip            VARCHAR2(10 CHAR),
    web_country        VARCHAR2(20 CHAR),
    web_gmt_offset     NUMBER(5, 2),
    web_tax_percentage NUMBER(5, 2)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('web_site.dat'));

CREATE TABLE tpcds.ext_store_returns (
    sr_returned_date_sk   INTEGER,
    sr_return_time_sk     INTEGER,
    sr_item_sk            INTEGER NOT NULL,
    sr_customer_sk        INTEGER,
    sr_cdemo_sk           INTEGER,
    sr_hdemo_sk           INTEGER,
    sr_addr_sk            INTEGER,
    sr_store_sk           INTEGER,
    sr_reason_sk          INTEGER,
    sr_ticket_number      INTEGER NOT NULL,
    sr_return_quantity    INTEGER,
    sr_return_amt         NUMBER(7, 2),
    sr_return_tax         NUMBER(7, 2),
    sr_return_amt_inc_tax NUMBER(7, 2),
    sr_fee                NUMBER(7, 2),
    sr_return_ship_cost   NUMBER(7, 2),
    sr_refunded_cash      NUMBER(7, 2),
    sr_reversed_charge    NUMBER(7, 2),
    sr_store_credit       NUMBER(7, 2),
    sr_net_loss           NUMBER(7, 2)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('store_returns.dat'));

CREATE TABLE tpcds.ext_household_demographics (
    hd_demo_sk        INTEGER NOT NULL,
    hd_income_band_sk INTEGER,
    hd_buy_potential  VARCHAR2(15 CHAR),
    hd_dep_count      INTEGER,
    hd_vehicle_count  INTEGER
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('household_demographics.dat'));

CREATE TABLE tpcds.ext_web_page (
    wp_web_page_sk      INTEGER NOT NULL,
    wp_web_page_id      VARCHAR2(16 CHAR) NOT NULL,
    wp_rec_start_date   VARCHAR2(10 CHAR),
    wp_rec_end_date     VARCHAR2(10 CHAR),
    wp_creation_date_sk INTEGER,
    wp_access_date_sk   INTEGER,
    wp_autogen_flag     VARCHAR2(1 CHAR),
    wp_customer_sk      INTEGER,
    wp_url              VARCHAR2(100 CHAR),
    wp_type             VARCHAR2(50 CHAR),
    wp_char_count       INTEGER,
    wp_link_count       INTEGER,
    wp_image_count      INTEGER,
    wp_max_ad_count     INTEGER
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('web_page.dat'));

CREATE TABLE tpcds.ext_promotion (
    p_promo_sk        INTEGER NOT NULL,
    p_promo_id        VARCHAR2(16 CHAR) NOT NULL,
    p_start_date_sk   INTEGER,
    p_end_date_sk     INTEGER,
    p_item_sk         INTEGER,
    p_cost            NUMBER(15, 2),
    p_response_target INTEGER,
    p_promo_name      VARCHAR2(50 CHAR),
    p_channel_dmail   VARCHAR2(1 CHAR),
    p_channel_email   VARCHAR2(1 CHAR),
    p_channel_catalog VARCHAR2(1 CHAR),
    p_channel_tv      VARCHAR2(1 CHAR),
    p_channel_radio   VARCHAR2(1 CHAR),
    p_channel_press   VARCHAR2(1 CHAR),
    p_channel_event   VARCHAR2(1 CHAR),
    p_channel_demo    VARCHAR2(1 CHAR),
    p_channel_details VARCHAR2(100 CHAR),
    p_purpose         VARCHAR2(15 CHAR),
    p_discount_active VARCHAR2(1 CHAR)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('promotion.dat'));

CREATE TABLE tpcds.ext_catalog_page (
    cp_catalog_page_sk     INTEGER NOT NULL,
    cp_catalog_page_id     VARCHAR2(16 CHAR) NOT NULL,
    cp_start_date_sk       INTEGER,
    cp_end_date_sk         INTEGER,
    cp_department          VARCHAR2(50 CHAR),
    cp_catalog_number      INTEGER,
    cp_catalog_page_number INTEGER,
    cp_description         VARCHAR2(100 CHAR),
    cp_type                VARCHAR2(100 CHAR)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('catalog_page.dat'));

CREATE TABLE tpcds.ext_inventory (
    inv_date_sk          INTEGER NOT NULL,
    inv_item_sk          INTEGER NOT NULL,
    inv_warehouse_sk     INTEGER NOT NULL,
    inv_quantity_on_hand INTEGER
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('inventory.dat'));

CREATE TABLE tpcds.ext_catalog_returns (
    cr_returned_date_sk      INTEGER,
    cr_returned_time_sk      INTEGER,
    cr_item_sk               INTEGER NOT NULL,
    cr_refunded_customer_sk  INTEGER,
    cr_refunded_cdemo_sk     INTEGER,
    cr_refunded_hdemo_sk     INTEGER,
    cr_refunded_addr_sk      INTEGER,
    cr_returning_customer_sk INTEGER,
    cr_returning_cdemo_sk    INTEGER,
    cr_returning_hdemo_sk    INTEGER,
    cr_returning_addr_sk     INTEGER,
    cr_call_center_sk        INTEGER,
    cr_catalog_page_sk       INTEGER,
    cr_ship_mode_sk          INTEGER,
    cr_warehouse_sk          INTEGER,
    cr_reason_sk             INTEGER,
    cr_order_number          INTEGER NOT NULL,
    cr_return_quantity       INTEGER,
    cr_return_amount         NUMBER(7, 2),
    cr_return_tax            NUMBER(7, 2),
    cr_return_amt_inc_tax    NUMBER(7, 2),
    cr_fee                   NUMBER(7, 2),
    cr_return_ship_cost      NUMBER(7, 2),
    cr_refunded_cash         NUMBER(7, 2),
    cr_reversed_charge       NUMBER(7, 2),
    cr_store_credit          NUMBER(7, 2),
    cr_net_loss              NUMBER(7, 2)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('catalog_returns.dat'));

CREATE TABLE tpcds.ext_web_returns (
    wr_returned_date_sk      INTEGER,
    wr_returned_time_sk      INTEGER,
    wr_item_sk               INTEGER NOT NULL,
    wr_refunded_customer_sk  INTEGER,
    wr_refunded_cdemo_sk     INTEGER,
    wr_refunded_hdemo_sk     INTEGER,
    wr_refunded_addr_sk      INTEGER,
    wr_returning_customer_sk INTEGER,
    wr_returning_cdemo_sk    INTEGER,
    wr_returning_hdemo_sk    INTEGER,
    wr_returning_addr_sk     INTEGER,
    wr_web_page_sk           INTEGER,
    wr_reason_sk             INTEGER,
    wr_order_number          INTEGER NOT NULL,
    wr_return_quantity       INTEGER,
    wr_return_amt            NUMBER(7, 2),
    wr_return_tax            NUMBER(7, 2),
    wr_return_amt_inc_tax    NUMBER(7, 2),
    wr_fee                   NUMBER(7, 2),
    wr_return_ship_cost      NUMBER(7, 2),
    wr_refunded_cash         NUMBER(7, 2),
    wr_reversed_charge       NUMBER(7, 2),
    wr_account_credit        NUMBER(7, 2),
    wr_net_loss              NUMBER(7, 2)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('web_returns.dat'));

CREATE TABLE tpcds.ext_web_sales (
    ws_sold_date_sk          INTEGER,
    ws_sold_time_sk          INTEGER,
    ws_ship_date_sk          INTEGER,
    ws_item_sk               INTEGER NOT NULL,
    ws_bill_customer_sk      INTEGER,
    ws_bill_cdemo_sk         INTEGER,
    ws_bill_hdemo_sk         INTEGER,
    ws_bill_addr_sk          INTEGER,
    ws_ship_customer_sk      INTEGER,
    ws_ship_cdemo_sk         INTEGER,
    ws_ship_hdemo_sk         INTEGER,
    ws_ship_addr_sk          INTEGER,
    ws_web_page_sk           INTEGER,
    ws_web_site_sk           INTEGER,
    ws_ship_mode_sk          INTEGER,
    ws_warehouse_sk          INTEGER,
    ws_promo_sk              INTEGER,
    ws_order_number          INTEGER NOT NULL,
    ws_quantity              INTEGER,
    ws_wholesale_cost        NUMBER(7, 2),
    ws_list_price            NUMBER(7, 2),
    ws_sales_price           NUMBER(7, 2),
    ws_ext_discount_amt      NUMBER(7, 2),
    ws_ext_sales_price       NUMBER(7, 2),
    ws_ext_wholesale_cost    NUMBER(7, 2),
    ws_ext_list_price        NUMBER(7, 2),
    ws_ext_tax               NUMBER(7, 2),
    ws_coupon_amt            NUMBER(7, 2),
    ws_ext_ship_cost         NUMBER(7, 2),
    ws_net_paid              NUMBER(7, 2),
    ws_net_paid_inc_tax      NUMBER(7, 2),
    ws_net_paid_inc_ship     NUMBER(7, 2),
    ws_net_paid_inc_ship_tax NUMBER(7, 2),
    ws_net_profit            NUMBER(7, 2)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('web_sales.dat'));

CREATE TABLE tpcds.ext_catalog_sales (
    cs_sold_date_sk          INTEGER,
    cs_sold_time_sk          INTEGER,
    cs_ship_date_sk          INTEGER,
    cs_bill_customer_sk      INTEGER,
    cs_bill_cdemo_sk         INTEGER,
    cs_bill_hdemo_sk         INTEGER,
    cs_bill_addr_sk          INTEGER,
    cs_ship_customer_sk      INTEGER,
    cs_ship_cdemo_sk         INTEGER,
    cs_ship_hdemo_sk         INTEGER,
    cs_ship_addr_sk          INTEGER,
    cs_call_center_sk        INTEGER,
    cs_catalog_page_sk       INTEGER,
    cs_ship_mode_sk          INTEGER,
    cs_warehouse_sk          INTEGER,
    cs_item_sk               INTEGER NOT NULL,
    cs_promo_sk              INTEGER,
    cs_order_number          INTEGER NOT NULL,
    cs_quantity              INTEGER,
    cs_wholesale_cost        NUMBER(7, 2),
    cs_list_price            NUMBER(7, 2),
    cs_sales_price           NUMBER(7, 2),
    cs_ext_discount_amt      NUMBER(7, 2),
    cs_ext_sales_price       NUMBER(7, 2),
    cs_ext_wholesale_cost    NUMBER(7, 2),
    cs_ext_list_price        NUMBER(7, 2),
    cs_ext_tax               NUMBER(7, 2),
    cs_coupon_amt            NUMBER(7, 2),
    cs_ext_ship_cost         NUMBER(7, 2),
    cs_net_paid              NUMBER(7, 2),
    cs_net_paid_inc_tax      NUMBER(7, 2),
    cs_net_paid_inc_ship     NUMBER(7, 2),
    cs_net_paid_inc_ship_tax NUMBER(7, 2),
    cs_net_profit            NUMBER(7, 2)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('catalog_sales.dat'));

CREATE TABLE tpcds.ext_store_sales (
    ss_sold_date_sk       INTEGER,
    ss_sold_time_sk       INTEGER,
    ss_item_sk            INTEGER NOT NULL,
    ss_customer_sk        INTEGER,
    ss_cdemo_sk           INTEGER,
    ss_hdemo_sk           INTEGER,
    ss_addr_sk            INTEGER,
    ss_store_sk           INTEGER,
    ss_promo_sk           INTEGER,
    ss_ticket_number      INTEGER NOT NULL,
    ss_quantity           INTEGER,
    ss_wholesale_cost     NUMBER(7, 2),
    ss_list_price         NUMBER(7, 2),
    ss_sales_price        NUMBER(7, 2),
    ss_ext_discount_amt   NUMBER(7, 2),
    ss_ext_sales_price    NUMBER(7, 2),
    ss_ext_wholesale_cost NUMBER(7, 2),
    ss_ext_list_price     NUMBER(7, 2),
    ss_ext_tax            NUMBER(7, 2),
    ss_coupon_amt         NUMBER(7, 2),
    ss_net_paid           NUMBER(7, 2),
    ss_net_paid_inc_tax   NUMBER(7, 2),
    ss_net_profit         NUMBER(7, 2)
)    ORGANIZATION EXTERNAL
        (TYPE oracle_loader
            DEFAULT DIRECTORY tpcds_dir
                ACCESS PARAMETERS (
                    FIELDS
                        TERMINATED BY '|'
                    MISSING FIELD VALUES ARE NULL
                )
            LOCATION('store_sales.dat'));
EOF
echo "*** populate tables"
sqlplus system/$ORACLE_PWD@localhost:1521/$ORACLE_PDB << EOF
    SET ECHO ON
    truncate table tpcds.dbgen_version;
    truncate table tpcds.customer_address;
    truncate table tpcds.customer_demographics;
    truncate table tpcds.date_dim;
    truncate table tpcds.warehouse;
    truncate table tpcds.ship_mode;
    truncate table tpcds.time_dim;
    truncate table tpcds.reason;
    truncate table tpcds.income_band;
    truncate table tpcds.item;
    truncate table tpcds.store;
    truncate table tpcds.call_center;
    truncate table tpcds.customer;
    truncate table tpcds.web_site;
    truncate table tpcds.store_returns;
    truncate table tpcds.household_demographics;
    truncate table tpcds.web_page;
    truncate table tpcds.promotion;
    truncate table tpcds.catalog_page;
    truncate table tpcds.inventory;
    truncate table tpcds.catalog_returns;
    truncate table tpcds.web_returns;
    truncate table tpcds.web_sales;
    truncate table tpcds.catalog_sales;
    truncate table tpcds.store_sales;

    ALTER SESSION SET nls_date_format='YYYY-MM-DD';

    INSERT /*+ APPEND */ INTO  tpcds.dbgen_version            select * from tpcds.ext_dbgen_version;
    INSERT /*+ APPEND */ INTO  tpcds.customer_address         select * from tpcds.ext_customer_address;
    INSERT /*+ APPEND */ INTO  tpcds.customer_demographics    select * from tpcds.ext_customer_demographics;
    INSERT /*+ APPEND */ INTO  tpcds.date_dim                 select * from tpcds.ext_date_dim;
    INSERT /*+ APPEND */ INTO  tpcds.warehouse                select * from tpcds.ext_warehouse;
    INSERT /*+ APPEND */ INTO  tpcds.ship_mode                select * from tpcds.ext_ship_mode;
    INSERT /*+ APPEND */ INTO  tpcds.time_dim                 select * from tpcds.ext_time_dim;
    INSERT /*+ APPEND */ INTO  tpcds.reason                   select * from tpcds.ext_reason;
    INSERT /*+ APPEND */ INTO  tpcds.income_band              select * from tpcds.ext_income_band;
    INSERT /*+ APPEND */ INTO  tpcds.item                     select * from tpcds.ext_item;
    INSERT /*+ APPEND */ INTO  tpcds.store                    select * from tpcds.ext_store;
    INSERT /*+ APPEND */ INTO  tpcds.call_center              select * from tpcds.ext_call_center;
    INSERT /*+ APPEND */ INTO  tpcds.customer                 select * from tpcds.ext_customer;
    INSERT /*+ APPEND */ INTO  tpcds.web_site                 select * from tpcds.ext_web_site;
    INSERT /*+ APPEND */ INTO  tpcds.store_returns            select * from tpcds.ext_store_returns;
    INSERT /*+ APPEND */ INTO  tpcds.household_demographics   select * from tpcds.ext_household_demographics;
    INSERT /*+ APPEND */ INTO  tpcds.web_page                 select * from tpcds.ext_web_page;
    INSERT /*+ APPEND */ INTO  tpcds.promotion                select * from tpcds.ext_promotion;
    INSERT /*+ APPEND */ INTO  tpcds.catalog_page             select * from tpcds.ext_catalog_page;
    INSERT /*+ APPEND */ INTO  tpcds.inventory                select * from tpcds.ext_inventory;
    INSERT /*+ APPEND */ INTO  tpcds.catalog_returns          select * from tpcds.ext_catalog_returns;
    INSERT /*+ APPEND */ INTO  tpcds.web_returns              select * from tpcds.ext_web_returns;
    INSERT /*+ APPEND */ INTO  tpcds.web_sales                select * from tpcds.ext_web_sales;
    INSERT /*+ APPEND */ INTO  tpcds.catalog_sales            select * from tpcds.ext_catalog_sales;
    INSERT /*+ APPEND */ INTO  tpcds.store_sales              select * from tpcds.ext_store_sales;
    exit;
EOF