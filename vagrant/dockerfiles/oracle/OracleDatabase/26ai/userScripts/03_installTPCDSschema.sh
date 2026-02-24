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
    GRANT DB_DEVELOPER_ROLE,
        UNLIMITED TABLESPACE
        TO tpcds;
    CREATE OR REPLACE DIRECTORY tpcds_dir AS '/home/oracle/tpcds';
    GRANT READ, WRITE ON DIRECTORY tpcds_dir TO tpcds;
EOF

echo "*** Create tables schema"
sqlplus tpcds/tpcds@localhost:1521/$ORACLE_PDB << EOF
create table dbgen_version (
   dv_version      varchar2(16  char),
   dv_create_date  date,
   dv_create_time  varchar2(20 char),
   dv_cmdline_args varchar2(200 char)
);

create table customer_address (
   ca_address_sk    integer not null,
   ca_address_id    varchar2(16 char) not null,
   ca_street_number varchar2(10 char),
   ca_street_name   varchar2(60 char),
   ca_street_type   varchar2(15 char),
   ca_suite_number  varchar2(10 char),
   ca_city          varchar2(60 char),
   ca_county        varchar2(30 char),
   ca_state         varchar2(2 char),
   ca_zip           varchar2(10 char),
   ca_country       varchar2(20 char),
   ca_gmt_offset    number(5,2),
   ca_location_type varchar2(20 char)
);

create table customer_demographics (
   cd_demo_sk            integer not null,
   cd_gender             varchar2(1 char),
   cd_marital_status     varchar2(1 char),
   cd_education_status   varchar2(20 char),
   cd_purchase_estimate  integer,
   cd_credit_rating      varchar2(10 char),
   cd_dep_count          integer,
   cd_dep_employed_count integer,
   cd_dep_college_count  integer
);

create table date_dim (
   d_date_sk           integer not null,
   d_date_id           varchar2(16 char) not null,
   d_date              date not null,
   d_month_seq         integer,
   d_week_seq          integer,
   d_quarter_seq       integer,
   d_year              integer,
   d_dow               integer,
   d_moy               integer,
   d_dom               integer,
   d_qoy               integer,
   d_fy_year           integer,
   d_fy_quarter_seq    integer,
   d_fy_week_seq       integer,
   d_day_name          varchar2(9 char),
   d_quarter_name      varchar2(6 char),
   d_holiday           varchar2(1 char),
   d_weekend           varchar2(1 char),
   d_following_holiday varchar2(1 char),
   d_first_dom         integer,
   d_last_dom          integer,
   d_same_day_ly       integer,
   d_same_day_lq       integer,
   d_current_day       varchar2(1 char),
   d_current_week      varchar2(1 char),
   d_current_month     varchar2(1 char),
   d_current_quarter   varchar2(1 char),
   d_current_year      varchar2(1 char)
);

create table warehouse (
   w_warehouse_sk    integer not null,
   w_warehouse_id    varchar2(16 char) not null,
   w_warehouse_name  varchar2(20 char),
   w_warehouse_sq_ft integer,
   w_street_number   varchar2(10 char),
   w_street_name     varchar2(60 char),
   w_street_type     varchar2(15 char),
   w_suite_number    varchar2(10 char),
   w_city            varchar2(60 char),
   w_county          varchar2(30 char),
   w_state           varchar2(2 char),
   w_zip             varchar2(10 char),
   w_country         varchar2(20 char),
   w_gmt_offset      number(5,2)
);

create table ship_mode (
   sm_ship_mode_sk integer not null,
   sm_ship_mode_id varchar2(16 char) not null,
   sm_type         varchar2(30 char),
   sm_code         varchar2(20 char),
   sm_carrier      varchar2(20 char),
   sm_contract     varchar2(20 char)
);

create table time_dim (
   t_time_sk   integer not null,
   t_time_id   varchar2(16 char) not null,
   t_time      integer not null,
   t_hour      integer,
   t_minute    integer,
   t_second    integer,
   t_am_pm     varchar2(2 char),
   t_shift     varchar2(20 char),
   t_sub_shift varchar2(20 char),
   t_meal_time varchar2(20 char)
);

create table reason (
   r_reason_sk   integer not null,
   r_reason_id   varchar2(16 char) not null,
   r_reason_desc varchar2(100 char)
);

create table income_band (
   ib_income_band_sk integer not null,
   ib_lower_bound    integer,
   ib_upper_bound    integer
);

create table item (
   i_item_sk        integer not null,
   i_item_id        varchar2(16 char) not null,
   i_rec_start_date date,
   i_rec_end_date   date,
   i_item_desc      varchar2(200 char),
   i_current_price  number(7,2),
   i_wholesale_cost number(7,2),
   i_brand_id       integer,
   i_brand          varchar2(50 char),
   i_class_id       integer,
   i_class          varchar2(50 char),
   i_category_id    integer,
   i_category       varchar2(50 char),
   i_manufact_id    integer,
   i_manufact       varchar2(50 char),
   i_size           varchar2(20 char),
   i_formulation    varchar2(20 char),
   i_color          varchar2(20 char),
   i_units          varchar2(10 char),
   i_container      varchar2(10 char),
   i_manager_id     integer,
   i_product_name   varchar2(50 char)
);

create table store (
   s_store_sk         integer not null,
   s_store_id         varchar2(16 char) not null,
   s_rec_start_date   date,
   s_rec_end_date     date,
   s_closed_date_sk   integer,
   s_store_name       varchar2(50 char),
   s_number_employees integer,
   s_floor_space      integer,
   s_hours            varchar2(20 char),
   s_manager          varchar2(40 char),
   s_market_id        integer,
   s_geography_class  varchar2(100 char),
   s_market_desc      varchar2(100 char),
   s_market_manager   varchar2(40 char),
   s_division_id      integer,
   s_division_name    varchar2(50 char),
   s_company_id       integer,
   s_company_name     varchar2(50 char),
   s_street_number    varchar2(10 char),
   s_street_name      varchar2(60 char),
   s_street_type      varchar2(15 char),
   s_suite_number     varchar2(10 char),
   s_city             varchar2(60 char),
   s_county           varchar2(30 char),
   s_state            varchar2(2 char),
   s_zip              varchar2(10 char),
   s_country          varchar2(20 char),
   s_gmt_offset       number(5,2),
   s_tax_precentage   number(5,2)
);

create table call_center (
   cc_call_center_sk integer not null,
   cc_call_center_id varchar2(16 char) not null,
   cc_rec_start_date date,
   cc_rec_end_date   date,
   cc_closed_date_sk integer,
   cc_open_date_sk   integer,
   cc_name           varchar2(50 char),
   cc_class          varchar2(50 char),
   cc_employees      integer,
   cc_sq_ft          integer,
   cc_hours          varchar2(20 char),
   cc_manager        varchar2(40 char),
   cc_mkt_id         integer,
   cc_mkt_class      varchar2(50 char),
   cc_mkt_desc       varchar2(100 char),
   cc_market_manager varchar2(40 char),
   cc_division       integer,
   cc_division_name  varchar2(50 char),
   cc_company        integer,
   cc_company_name   varchar2(50 char),
   cc_street_number  varchar2(10 char),
   cc_street_name    varchar2(60 char),
   cc_street_type    varchar2(15 char),
   cc_suite_number   varchar2(10 char),
   cc_city           varchar2(60 char),
   cc_county         varchar2(30 char),
   cc_state          varchar2(2 char),
   cc_zip            varchar2(10 char),
   cc_country        varchar2(20 char),
   cc_gmt_offset     number(5,2),
   cc_tax_percentage number(5,2)
);

create table customer (
   c_customer_sk          integer not null,
   c_customer_id          varchar2(16 char) not null,
   c_current_cdemo_sk     integer,
   c_current_hdemo_sk     integer,
   c_current_addr_sk      integer,
   c_first_shipto_date_sk integer,
   c_first_sales_date_sk  integer,
   c_salutation           varchar2(10 char),
   c_first_name           varchar2(20 char),
   c_last_name            varchar2(30 char),
   c_preferred_cust_flag  varchar2(1 char),
   c_birth_day            integer,
   c_birth_month          integer,
   c_birth_year           integer,
   c_birth_country        varchar2(20 char),
   c_login                varchar2(13 char),
   c_email_address        varchar2(50 char),
   c_last_review_date_sk  varchar2(10 char)
);

create table web_site (
   web_site_sk        integer not null,
   web_site_id        varchar2(16 char) not null,
   web_rec_start_date date,
   web_rec_end_date   date,
   web_name           varchar2(50 char),
   web_open_date_sk   integer,
   web_close_date_sk  integer,
   web_class          varchar2(50 char),
   web_manager        varchar2(40 char),
   web_mkt_id         integer,
   web_mkt_class      varchar2(50 char),
   web_mkt_desc       varchar2(100 char),
   web_market_manager varchar2(40 char),
   web_company_id     integer,
   web_company_name   varchar2(50 char),
   web_street_number  varchar2(10 char),
   web_street_name    varchar2(60 char),
   web_street_type    varchar2(15 char),
   web_suite_number   varchar2(10 char),
   web_city           varchar2(60 char),
   web_county         varchar2(30 char),
   web_state          varchar2(2 char),
   web_zip            varchar2(10 char),
   web_country        varchar2(20 char),
   web_gmt_offset     number(5,2),
   web_tax_percentage number(5,2)
);

create table store_returns (
   sr_returned_date_sk   integer,
   sr_return_time_sk     integer,
   sr_item_sk            integer not null,
   sr_customer_sk        integer,
   sr_cdemo_sk           integer,
   sr_hdemo_sk           integer,
   sr_addr_sk            integer,
   sr_store_sk           integer,
   sr_reason_sk          integer,
   sr_ticket_number      integer not null,
   sr_return_quantity    integer,
   sr_return_amt         number(7,2),
   sr_return_tax         number(7,2),
   sr_return_amt_inc_tax number(7,2),
   sr_fee                number(7,2),
   sr_return_ship_cost   number(7,2),
   sr_refunded_cash      number(7,2),
   sr_reversed_charge    number(7,2),
   sr_store_credit       number(7,2),
   sr_net_loss           number(7,2)
);

create table household_demographics (
   hd_demo_sk        integer not null,
   hd_income_band_sk integer,
   hd_buy_potential  varchar2(15 char),
   hd_dep_count      integer,
   hd_vehicle_count  integer
);

create table web_page (
   wp_web_page_sk      integer not null,
   wp_web_page_id      varchar2(16 char) not null,
   wp_rec_start_date   date,
   wp_rec_end_date     date,
   wp_creation_date_sk integer,
   wp_access_date_sk   integer,
   wp_autogen_flag     varchar2(1 char),
   wp_customer_sk      integer,
   wp_url              varchar2(100 char),
   wp_type             varchar2(50 char),
   wp_char_count       integer,
   wp_link_count       integer,
   wp_image_count      integer,
   wp_max_ad_count     integer
);

create table promotion (
   p_promo_sk        integer not null,
   p_promo_id        varchar2(16 char) not null,
   p_start_date_sk   integer,
   p_end_date_sk     integer,
   p_item_sk         integer,
   p_cost            number(15,2),
   p_response_target integer,
   p_promo_name      varchar2(50 char),
   p_channel_dmail   varchar2(1 char),
   p_channel_email   varchar2(1 char),
   p_channel_catalog varchar2(1 char),
   p_channel_tv      varchar2(1 char),
   p_channel_radio   varchar2(1 char),
   p_channel_press   varchar2(1 char),
   p_channel_event   varchar2(1 char),
   p_channel_demo    varchar2(1 char),
   p_channel_details varchar2(100 char),
   p_purpose         varchar2(15 char),
   p_discount_active varchar2(1 char)
);

create table catalog_page (
   cp_catalog_page_sk     integer not null,
   cp_catalog_page_id     varchar2(16 char) not null,
   cp_start_date_sk       integer,
   cp_end_date_sk         integer,
   cp_department          varchar2(50 char),
   cp_catalog_number      integer,
   cp_catalog_page_number integer,
   cp_description         varchar2(100 char),
   cp_type                varchar2(100 char)
);

create table inventory (
   inv_date_sk          integer not null,
   inv_item_sk          integer not null,
   inv_warehouse_sk     integer not null,
   inv_quantity_on_hand integer
);

create table catalog_returns (
   cr_returned_date_sk      integer,
   cr_returned_time_sk      integer,
   cr_item_sk               integer not null,
   cr_refunded_customer_sk  integer,
   cr_refunded_cdemo_sk     integer,
   cr_refunded_hdemo_sk     integer,
   cr_refunded_addr_sk      integer,
   cr_returning_customer_sk integer,
   cr_returning_cdemo_sk    integer,
   cr_returning_hdemo_sk    integer,
   cr_returning_addr_sk     integer,
   cr_call_center_sk        integer,
   cr_catalog_page_sk       integer,
   cr_ship_mode_sk          integer,
   cr_warehouse_sk          integer,
   cr_reason_sk             integer,
   cr_order_number          integer not null,
   cr_return_quantity       integer,
   cr_return_amount         number(7,2),
   cr_return_tax            number(7,2),
   cr_return_amt_inc_tax    number(7,2),
   cr_fee                   number(7,2),
   cr_return_ship_cost      number(7,2),
   cr_refunded_cash         number(7,2),
   cr_reversed_charge       number(7,2),
   cr_store_credit          number(7,2),
   cr_net_loss              number(7,2)
);

create table web_returns (
   wr_returned_date_sk      integer,
   wr_returned_time_sk      integer,
   wr_item_sk               integer not null,
   wr_refunded_customer_sk  integer,
   wr_refunded_cdemo_sk     integer,
   wr_refunded_hdemo_sk     integer,
   wr_refunded_addr_sk      integer,
   wr_returning_customer_sk integer,
   wr_returning_cdemo_sk    integer,
   wr_returning_hdemo_sk    integer,
   wr_returning_addr_sk     integer,
   wr_web_page_sk           integer,
   wr_reason_sk             integer,
   wr_order_number          integer not null,
   wr_return_quantity       integer,
   wr_return_amt            number(7,2),
   wr_return_tax            number(7,2),
   wr_return_amt_inc_tax    number(7,2),
   wr_fee                   number(7,2),
   wr_return_ship_cost      number(7,2),
   wr_refunded_cash         number(7,2),
   wr_reversed_charge       number(7,2),
   wr_account_credit        number(7,2),
   wr_net_loss              number(7,2)
);

create table web_sales (
   ws_sold_date_sk          integer,
   ws_sold_time_sk          integer,
   ws_ship_date_sk          integer,
   ws_item_sk               integer not null,
   ws_bill_customer_sk      integer,
   ws_bill_cdemo_sk         integer,
   ws_bill_hdemo_sk         integer,
   ws_bill_addr_sk          integer,
   ws_ship_customer_sk      integer,
   ws_ship_cdemo_sk         integer,
   ws_ship_hdemo_sk         integer,
   ws_ship_addr_sk          integer,
   ws_web_page_sk           integer,
   ws_web_site_sk           integer,
   ws_ship_mode_sk          integer,
   ws_warehouse_sk          integer,
   ws_promo_sk              integer,
   ws_order_number          integer not null,
   ws_quantity              integer,
   ws_wholesale_cost        number(7,2),
   ws_list_price            number(7,2),
   ws_sales_price           number(7,2),
   ws_ext_discount_amt      number(7,2),
   ws_ext_sales_price       number(7,2),
   ws_ext_wholesale_cost    number(7,2),
   ws_ext_list_price        number(7,2),
   ws_ext_tax               number(7,2),
   ws_coupon_amt            number(7,2),
   ws_ext_ship_cost         number(7,2),
   ws_net_paid              number(7,2),
   ws_net_paid_inc_tax      number(7,2),
   ws_net_paid_inc_ship     number(7,2),
   ws_net_paid_inc_ship_tax number(7,2),
   ws_net_profit            number(7,2)
);

create table catalog_sales (
   cs_sold_date_sk          integer,
   cs_sold_time_sk          integer,
   cs_ship_date_sk          integer,
   cs_bill_customer_sk      integer,
   cs_bill_cdemo_sk         integer,
   cs_bill_hdemo_sk         integer,
   cs_bill_addr_sk          integer,
   cs_ship_customer_sk      integer,
   cs_ship_cdemo_sk         integer,
   cs_ship_hdemo_sk         integer,
   cs_ship_addr_sk          integer,
   cs_call_center_sk        integer,
   cs_catalog_page_sk       integer,
   cs_ship_mode_sk          integer,
   cs_warehouse_sk          integer,
   cs_item_sk               integer not null,
   cs_promo_sk              integer,
   cs_order_number          integer not null,
   cs_quantity              integer,
   cs_wholesale_cost        number(7,2),
   cs_list_price            number(7,2),
   cs_sales_price           number(7,2),
   cs_ext_discount_amt      number(7,2),
   cs_ext_sales_price       number(7,2),
   cs_ext_wholesale_cost    number(7,2),
   cs_ext_list_price        number(7,2),
   cs_ext_tax               number(7,2),
   cs_coupon_amt            number(7,2),
   cs_ext_ship_cost         number(7,2),
   cs_net_paid              number(7,2),
   cs_net_paid_inc_tax      number(7,2),
   cs_net_paid_inc_ship     number(7,2),
   cs_net_paid_inc_ship_tax number(7,2),
   cs_net_profit            number(7,2)
);

create table store_sales (
   ss_sold_date_sk       integer,
   ss_sold_time_sk       integer,
   ss_item_sk            integer not null,
   ss_customer_sk        integer,
   ss_cdemo_sk           integer,
   ss_hdemo_sk           integer,
   ss_addr_sk            integer,
   ss_store_sk           integer,
   ss_promo_sk           integer,
   ss_ticket_number      integer not null,
   ss_quantity           integer,
   ss_wholesale_cost     number(7,2),
   ss_list_price         number(7,2),
   ss_sales_price        number(7,2),
   ss_ext_discount_amt   number(7,2),
   ss_ext_sales_price    number(7,2),
   ss_ext_wholesale_cost number(7,2),
   ss_ext_list_price     number(7,2),
   ss_ext_tax            number(7,2),
   ss_coupon_amt         number(7,2),
   ss_net_paid           number(7,2),
   ss_net_paid_inc_tax   number(7,2),
   ss_net_profit         number(7,2)
);
EOF
echo "*** Create external tables for data loading"
sqlplus tpcds/tpcds@localhost:1521/$ORACLE_PDB << EOF
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
sqlplus tpcds/tpcds@localhost:1521/$ORACLE_PDB << EOF
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
echo "*** add constraints"
sqlplus tpcds/tpcds@localhost:1521/$ORACLE_PDB << EOF
--
-- Add constraints
alter table customer_address add constraint customer_address_pk primary key ( ca_address_sk );
alter table customer_demographics add constraint customer_demographics_pk primary key ( cd_demo_sk );
alter table date_dim add constraint date_dim_pk primary key ( d_date_sk );
alter table warehouse add constraint warehouse_pk primary key ( w_warehouse_sk );
alter table ship_mode add constraint ship_mode_pk primary key ( sm_ship_mode_sk );
alter table time_dim add constraint time_dim_pk primary key ( t_time_sk );
alter table reason add constraint reason_pk primary key ( r_reason_sk );
alter table income_band add constraint income_band_pk primary key ( ib_income_band_sk );
alter table item add constraint item_pk primary key ( i_item_sk );
alter table store add constraint store_pk primary key ( s_store_sk );
alter table call_center add constraint call_center_pk primary key ( cc_call_center_sk );
alter table customer add constraint customer_pk primary key ( c_customer_sk );
alter table web_site add constraint web_site_pk primary key ( web_site_sk );
alter table store_returns add constraint store_returns_pk primary key ( sr_item_sk,
                                                                        sr_ticket_number );
alter table household_demographics add constraint household_demographics_pk primary key ( hd_demo_sk );
alter table web_page add constraint web_page_pk primary key ( wp_web_page_sk );
alter table promotion add constraint promotion_pk primary key ( p_promo_sk );
alter table catalog_page add constraint catalog_page_pk primary key ( cp_catalog_page_sk );
alter table inventory
   add constraint inventory_pk primary key ( inv_date_sk,
                                             inv_item_sk,
                                             inv_warehouse_sk );
alter table catalog_returns add constraint catalog_returns_pk primary key ( cr_item_sk,
                                                                            cr_order_number );
alter table web_returns add constraint web_returns_pk primary key ( wr_item_sk,
                                                                    wr_order_number );
alter table web_sales add constraint web_sales_pk primary key ( ws_item_sk,
                                                                ws_order_number );
alter table catalog_sales add constraint catalog_sales_pk primary key ( cs_item_sk,
                                                                        cs_order_number );
alter table store_sales add constraint store_sales_pk primary key ( ss_item_sk,
                                                                    ss_ticket_number );

                                                                    
-- alter table call_center
--    add constraint cc_d1 foreign key ( cc_closed_date_sk )
--       references date_dim ( d_date_sk );
-- alter table call_center
--    add constraint cc_d2 foreign key ( cc_open_date_sk )
--       references date_dim ( d_date_sk );
-- alter table catalog_page
--    add constraint cp_d1 foreign key ( cp_end_date_sk )
--       references date_dim ( d_date_sk );
-- alter table catalog_page
--    add constraint cp_p foreign key ( cp_promo_id )
--       references promotion ( p_promo_sk );
-- alter table catalog_page
--    add constraint cp_d2 foreign key ( cp_start_date_sk )
--       references date_dim ( d_date_sk );

-- Catalog returns
alter table catalog_returns
   add constraint cr_cc foreign key ( cr_call_center_sk )
      references call_center ( cc_call_center_sk );
alter table catalog_returns
   add constraint cr_cp foreign key ( cr_catalog_page_sk )
      references catalog_page ( cp_catalog_page_sk );
alter table catalog_returns
   add constraint cr_i foreign key ( cr_item_sk )
      references item ( i_item_sk );
alter table catalog_returns
   add constraint cr_r foreign key ( cr_reason_sk )
      references reason ( r_reason_sk );
alter table catalog_returns
   add constraint cr_a1 foreign key ( cr_refunded_addr_sk )
      references customer_address ( ca_address_sk );
alter table catalog_returns
   add constraint cr_cd1 foreign key ( cr_refunded_cdemo_sk )
      references customer_demographics ( cd_demo_sk );
alter table catalog_returns
   add constraint cr_c1 foreign key ( cr_refunded_customer_sk )
      references customer ( c_customer_sk );
alter table catalog_returns
   add constraint cr_hd1 foreign key ( cr_refunded_hdemo_sk )
      references household_demographics ( hd_demo_sk );
alter table catalog_returns
   add constraint cr_d1 foreign key ( cr_returned_date_sk )
      references date_dim ( d_date_sk );
alter table catalog_returns
   add constraint cr_i2 foreign key ( cr_returned_time_sk )
      references time_dim ( t_time_sk );
alter table catalog_returns
   add constraint cr_a2 foreign key ( cr_returning_addr_sk )
      references customer_address ( ca_address_sk );
alter table catalog_returns
   add constraint cr_cd2 foreign key ( cr_returning_cdemo_sk )
      references customer_demographics ( cd_demo_sk );
alter table catalog_returns
   add constraint cr_c2 foreign key ( cr_returning_customer_sk )
      references customer ( c_customer_sk );
alter table catalog_returns
   add constraint cr_hd2 foreign key ( cr_returning_hdemo_sk )
      references household_demographics ( hd_demo_sk );
-- alter table catalog_returns
--    add constraint cr_d2 foreign key ( cr_ship_date_sk )
--       references date_dim ( d_date_sk );
alter table catalog_returns
   add constraint cr_sm foreign key ( cr_ship_mode_sk )
      references ship_mode ( sm_ship_mode_sk );
alter table catalog_returns
   add constraint cr_w2 foreign key ( cr_warehouse_sk )
      references warehouse ( w_warehouse_sk );

-- Catalog Sales
alter table catalog_sales
   add constraint cs_b_a foreign key ( cs_bill_addr_sk )
      references customer_address ( ca_address_sk );
alter table catalog_sales
   add constraint cs_b_cd foreign key ( cs_bill_cdemo_sk )
      references customer_demographics ( cd_demo_sk );
alter table catalog_sales
   add constraint cs_b_c foreign key ( cs_bill_customer_sk )
      references customer ( c_customer_sk );
alter table catalog_sales
   add constraint cs_b_hd foreign key ( cs_bill_hdemo_sk )
      references household_demographics ( hd_demo_sk );
alter table catalog_sales
   add constraint cs_cc foreign key ( cs_call_center_sk )
      references call_center ( cc_call_center_sk );
alter table catalog_sales
   add constraint cs_cp foreign key ( cs_catalog_page_sk )
      references catalog_page ( cp_catalog_page_sk );
alter table catalog_sales
   add constraint cs_i foreign key ( cs_item_sk )
      references item ( i_item_sk );
alter table catalog_sales
   add constraint cs_p foreign key ( cs_promo_sk )
      references promotion ( p_promo_sk );
alter table catalog_sales
   add constraint cs_s_a foreign key ( cs_ship_addr_sk )
      references customer_address ( ca_address_sk );
alter table catalog_sales
   add constraint cs_s_cd foreign key ( cs_ship_cdemo_sk )
      references customer_demographics ( cd_demo_sk );
alter table catalog_sales
   add constraint cs_s_c foreign key ( cs_ship_customer_sk )
      references customer ( c_customer_sk );
alter table catalog_sales
   add constraint cs_d1 foreign key ( cs_ship_date_sk )
      references date_dim ( d_date_sk );
alter table catalog_sales
   add constraint cs_s_hd foreign key ( cs_ship_hdemo_sk )
      references household_demographics ( hd_demo_sk );
alter table catalog_sales
   add constraint cs_sm foreign key ( cs_ship_mode_sk )
      references ship_mode ( sm_ship_mode_sk );
alter table catalog_sales
   add constraint cs_d2 foreign key ( cs_sold_date_sk )
      references date_dim ( d_date_sk );
alter table catalog_sales
   add constraint cs_t foreign key ( cs_sold_time_sk )
      references time_dim ( t_time_sk );
alter table catalog_sales
   add constraint cs_w foreign key ( cs_warehouse_sk )
      references warehouse ( w_warehouse_sk );


-- alter table customer
--    add constraint c_a foreign key ( c_current_addr_sk )
--       references customer_address ( ca_address_sk );
-- alter table customer
--    add constraint c_cd foreign key ( c_current_cdemo_sk )
--       references customer_demographics ( cd_demo_sk );
-- alter table customer
--    add constraint c_hd foreign key ( c_current_hdemo_sk )
--       references household_demographics ( hd_demo_sk );
-- alter table customer
--    add constraint c_fsd foreign key ( c_first_sales_date_sk )
--       references date_dim ( d_date_sk );
-- alter table customer
--    add constraint c_fsd2 foreign key ( c_first_shipto_date_sk )
--       references date_dim ( d_date_sk );
-- alter table household_demographics
--    add constraint hd_ib foreign key ( hd_income_band_sk )
--       references income_band ( ib_income_band_sk );
-- alter table inventory
--    add constraint inv_d foreign key ( inv_date_sk )
--       references date_dim ( d_date_sk );
-- alter table inventory
--    add constraint inv_i foreign key ( inv_item_sk )
--       references item ( i_item_sk );
-- alter table inventory
--    add constraint inv_w foreign key ( inv_warehouse_sk )
--       references warehouse ( w_warehouse_sk );
-- alter table promotion
--    add constraint p_end_date foreign key ( p_end_date_sk )
--       references date_dim ( d_date_sk );
-- alter table promotion
--    add constraint p_i foreign key ( p_item_sk )
--       references item ( i_item_sk );
-- alter table promotion
--    add constraint p_start_date foreign key ( p_start_date_sk )
--       references date_dim ( d_date_sk );
-- alter table store
--    add constraint s_close_date foreign key ( s_closed_date_sk )
--       references date_dim ( d_date_sk );

-- Store returns
alter table store_returns
   add constraint sr_a foreign key ( sr_addr_sk )
      references customer_address ( ca_address_sk );
alter table store_returns
   add constraint sr_cd foreign key ( sr_cdemo_sk )
      references customer_demographics ( cd_demo_sk );
alter table store_returns
   add constraint sr_c foreign key ( sr_customer_sk )
      references customer ( c_customer_sk );
alter table store_returns
   add constraint sr_hd foreign key ( sr_hdemo_sk )
      references household_demographics ( hd_demo_sk );
alter table store_returns
   add constraint sr_i foreign key ( sr_item_sk )
      references item ( i_item_sk );
alter table store_returns
   add constraint sr_r foreign key ( sr_reason_sk )
      references reason ( r_reason_sk );
alter table store_returns
   add constraint sr_ret_d foreign key ( sr_returned_date_sk )
      references date_dim ( d_date_sk );
alter table store_returns
   add constraint sr_t foreign key ( sr_return_time_sk )
      references time_dim ( t_time_sk );
alter table store_returns
   add constraint sr_s foreign key ( sr_store_sk )
      references store ( s_store_sk );

-- Store sales
alter table store_sales
   add constraint ss_a foreign key ( ss_addr_sk )
      references customer_address ( ca_address_sk );
alter table store_sales
   add constraint ss_cd foreign key ( ss_cdemo_sk )
      references customer_demographics ( cd_demo_sk );
alter table store_sales
   add constraint ss_c foreign key ( ss_customer_sk )
      references customer ( c_customer_sk );
alter table store_sales
   add constraint ss_hd foreign key ( ss_hdemo_sk )
      references household_demographics ( hd_demo_sk );
alter table store_sales
   add constraint ss_i foreign key ( ss_item_sk )
      references item ( i_item_sk );
alter table store_sales
   add constraint ss_p foreign key ( ss_promo_sk )
      references promotion ( p_promo_sk );
alter table store_sales
   add constraint ss_d foreign key ( ss_sold_date_sk )
      references date_dim ( d_date_sk );
alter table store_sales
   add constraint ss_t foreign key ( ss_sold_time_sk )
      references time_dim ( t_time_sk );
alter table store_sales
   add constraint ss_s foreign key ( ss_store_sk )
      references store ( s_store_sk );

-- alter table web_page
--    add constraint wp_ad foreign key ( wp_access_date_sk )
--       references date_dim ( d_date_sk );
-- alter table web_page
--    add constraint wp_cd foreign key ( wp_creation_date_sk )
--       references date_dim ( d_date_sk );

-- web retruns
alter table web_returns
   add constraint wr_i foreign key ( wr_item_sk )
      references item ( i_item_sk );
alter table web_returns
   add constraint wr_r foreign key ( wr_reason_sk )
      references reason ( r_reason_sk );
alter table web_returns
   add constraint wr_ref_a foreign key ( wr_refunded_addr_sk )
      references customer_address ( ca_address_sk );
alter table web_returns
   add constraint wr_ref_cd foreign key ( wr_refunded_cdemo_sk )
      references customer_demographics ( cd_demo_sk );
alter table web_returns
   add constraint wr_ref_c foreign key ( wr_refunded_customer_sk )
      references customer ( c_customer_sk );
alter table web_returns
   add constraint wr_ref_hd foreign key ( wr_refunded_hdemo_sk )
      references household_demographics ( hd_demo_sk );
alter table web_returns
   add constraint wr_ret_d foreign key ( wr_returned_date_sk )
      references date_dim ( d_date_sk );
alter table web_returns
   add constraint wr_ret_t foreign key ( wr_returned_time_sk )
      references time_dim ( t_time_sk );
alter table web_returns
   add constraint wr_ret_a foreign key ( wr_returning_addr_sk )
      references customer_address ( ca_address_sk );
alter table web_returns
   add constraint wr_ret_cd foreign key ( wr_returning_cdemo_sk )
      references customer_demographics ( cd_demo_sk );
alter table web_returns
   add constraint wr_ret_c foreign key ( wr_returning_customer_sk )
      references customer ( c_customer_sk );
alter table web_returns
   add constraint wr_ret_hd foreign key ( wr_returning_hdemo_sk )
      references household_demographics ( hd_demo_sk );
alter table web_returns
   add constraint wr_wp foreign key ( wr_web_page_sk )
      references web_page ( wp_web_page_sk );

-- Web sales      
alter table web_sales
   add constraint ws_b_a foreign key ( ws_bill_addr_sk )
      references customer_address ( ca_address_sk );
alter table web_sales
   add constraint ws_b_cd foreign key ( ws_bill_cdemo_sk )
      references customer_demographics ( cd_demo_sk );
alter table web_sales
   add constraint ws_b_c foreign key ( ws_bill_customer_sk )
      references customer ( c_customer_sk );
alter table web_sales
   add constraint ws_b_hd foreign key ( ws_bill_hdemo_sk )
      references household_demographics ( hd_demo_sk );
alter table web_sales
   add constraint ws_i foreign key ( ws_item_sk )
      references item ( i_item_sk );
alter table web_sales
   add constraint ws_p foreign key ( ws_promo_sk )
      references promotion ( p_promo_sk );
alter table web_sales
   add constraint ws_s_a foreign key ( ws_ship_addr_sk )
      references customer_address ( ca_address_sk );
alter table web_sales
   add constraint ws_s_cd foreign key ( ws_ship_cdemo_sk )
      references customer_demographics ( cd_demo_sk );
alter table web_sales
   add constraint ws_s_c foreign key ( ws_ship_customer_sk )
      references customer ( c_customer_sk );
alter table web_sales
   add constraint ws_s_d foreign key ( ws_ship_date_sk )
      references date_dim ( d_date_sk );
alter table web_sales
   add constraint ws_s_hd foreign key ( ws_ship_hdemo_sk )
      references household_demographics ( hd_demo_sk );
alter table web_sales
   add constraint ws_sm foreign key ( ws_ship_mode_sk )
      references ship_mode ( sm_ship_mode_sk );
alter table web_sales
   add constraint ws_d2 foreign key ( ws_sold_date_sk )
      references date_dim ( d_date_sk );
alter table web_sales
   add constraint ws_t foreign key ( ws_sold_time_sk )
      references time_dim ( t_time_sk );
alter table web_sales
   add constraint ws_w2 foreign key ( ws_warehouse_sk )
      references warehouse ( w_warehouse_sk );
alter table web_sales
   add constraint ws_wp foreign key ( ws_web_page_sk )
      references web_page ( wp_web_page_sk );
alter table web_sales
   add constraint ws_ws foreign key ( ws_web_site_sk )
      references web_site ( web_site_sk );

-- alter table web_site
--    add constraint web_d1 foreign key ( web_close_date_sk )
--       references date_dim ( d_date_sk );
-- alter table web_site
--    add constraint web_d2 foreign key ( web_open_date_sk )
--       references date_dim ( d_date_sk );
-- alter table customer
--    add constraint c_d foreign key ( c_last_review_date_sk )
--       references date_dim ( d_date_sk );


-- In between Fact relationships
-- 
-- alter table store_returns
--    add constraint sr_i_tn
--       foreign key ( sr_item_sk,
--                     sr_ticket_number )
--          references store_sales ( ss_item_sk,
--                                   ss_ticket_number );
-- alter table catalog_returns
--    add constraint cr_i_on
--       foreign key ( cr_item_sk,
--                     cr_order_number )
--          references catalog_sales ( cs_item_sk,
--                                     cs_order_number );
-- alter table web_returns
--    add constraint wr_i_on
--       foreign key ( wr_item_sk,
--                     wr_order_number )
--          references web_sales ( ws_item_sk,
--                                 ws_order_number );

-- alter table web_page
--    add constraint wp_c foreign key ( wp_customer_sk )
--       references customer ( c_customer_sk );
EOF