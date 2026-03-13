-- Create tables

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