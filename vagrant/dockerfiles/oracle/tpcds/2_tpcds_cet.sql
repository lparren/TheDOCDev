-- Create external tables 
-- Make sure data files are in folder /u01/volumes/<db_folder>

drop table call_center_ext;

drop table catalog_page_ext;

drop table catalog_returns_ext;

drop table catalog_sales_ext;

drop table customer_ext;

drop table customer_address_ext;

drop table customer_demographics_ext;

drop table date_dim_ext;

drop table dbgen_version_ext;

drop table household_demographics_ext;

drop table income_band_ext;

drop table inventory_ext;

drop table item_ext;

drop table promotion_ext;

drop table reason_ext;

drop table ship_mode_ext;

drop table store_ext;

drop table store_returns_ext;

drop table store_sales_ext;

drop table time_dim_ext;

drop table warehouse_ext;

drop table web_page_ext;

drop table web_returns_ext;

drop table web_sales_ext;

drop table web_site_ext;


create table dbgen_version_ext (
   dv_version      varchar2(16),
   dv_create_date  date,
   dv_create_time  varchar2(50),
   dv_cmdline_args varchar2(200)
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         dv_version char,
         dv_create_date date "YYYY-MM-DD",
         dv_create_time char,
         dv_cmdline_args char
      )
   ) location ( 'dbgen_version.dat' )
);

create table customer_address_ext (
   ca_address_sk    integer not null,
   ca_address_id    varchar2(16) not null,
   ca_street_number varchar2(10),
   ca_street_name   varchar2(60),
   ca_street_type   varchar2(15),
   ca_suite_number  varchar2(10),
   ca_city          varchar2(60),
   ca_county        varchar2(30),
   ca_state         varchar2(2),
   ca_zip           varchar2(10),
   ca_country       varchar2(20),
   ca_gmt_offset    number(5,2),
   ca_location_type varchar2(20)
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         ca_address_sk char,
         ca_address_id char,
         ca_street_number char,
         ca_street_name char,
         ca_street_type char,
         ca_suite_number char,
         ca_city char,
         ca_county char,
         ca_state char,
         ca_zip char,
         ca_country char,
         ca_gmt_offset char,
         ca_location_type char
      )
   ) location ( 'customer_address.dat' )
);


create table customer_demographics_ext (
   cd_demo_sk            integer not null,
   cd_gender             varchar2(1),
   cd_marital_status     varchar2(1),
   cd_education_status   varchar2(20),
   cd_purchase_estimate  integer,
   cd_credit_rating      varchar2(10),
   cd_dep_count          integer,
   cd_dep_employed_count integer,
   cd_dep_college_count  integer
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         cd_demo_sk char,
         cd_gender char,
         cd_marital_status char,
         cd_education_status char,
         cd_purchase_estimate char,
         cd_credit_rating char,
         cd_dep_count char,
         cd_dep_employed_count char,
         cd_dep_college_count char
      )
   ) location ( 'customer_demographics.dat' )
);


create table date_dim_ext (
   d_date_sk           integer not null,
   d_date_id           varchar2(16) not null,
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
   d_day_name          varchar2(9),
   d_quarter_name      varchar2(6),
   d_holiday           varchar2(1),
   d_weekend           varchar2(1),
   d_following_holiday varchar2(1),
   d_first_dom         integer,
   d_last_dom          integer,
   d_same_day_ly       integer,
   d_same_day_lq       integer,
   d_current_day       varchar2(1),
   d_current_week      varchar2(1),
   d_current_month     varchar2(1),
   d_current_quarter   varchar2(1),
   d_current_year      varchar2(1)
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         d_date_sk char,
         d_date_id char,
         d_date date "YYYY-MM-DD",
         d_month_seq char,
         d_week_seq char,
         d_quarter_seq char,
         d_year char,
         d_dow char,
         d_moy char,
         d_dom char,
         d_qoy char,
         d_fy_year char,
         d_fy_quarter_seq char,
         d_fy_week_seq char,
         d_day_name char,
         d_quarter_name char,
         d_holiday char,
         d_weekend char,
         d_following_holiday char,
         d_first_dom char,
         d_last_dom char,
         d_same_day_ly char,
         d_same_day_lq char,
         d_current_day char,
         d_current_week char,
         d_current_month char,
         d_current_quarter char,
         d_current_year char
      )
   ) location ( 'date_dim.dat' )
);


create table warehouse_ext (
   w_warehouse_sk    integer not null,
   w_warehouse_id    varchar2(16) not null,
   w_warehouse_name  varchar2(20),
   w_warehouse_sq_ft integer,
   w_street_number   varchar2(10),
   w_street_name     varchar2(60),
   w_street_type     varchar2(15),
   w_suite_number    varchar2(10),
   w_city            varchar2(60),
   w_county          varchar2(30),
   w_state           varchar2(2),
   w_zip             varchar2(10),
   w_country         varchar2(20),
   w_gmt_offset      number(5,2)
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         w_warehouse_sk char,
         w_warehouse_id char,
         w_warehouse_name char,
         w_warehouse_sq_ft char,
         w_street_number char,
         w_street_name char,
         w_street_type char,
         w_suite_number char,
         w_city char,
         w_county char,
         w_state char,
         w_zip char,
         w_country char,
         w_gmt_offset char
      )
   ) location ( 'warehouse.dat' )
);


create table ship_mode_ext (
   sm_ship_mode_sk integer not null,
   sm_ship_mode_id varchar2(16) not null,
   sm_type         varchar2(30),
   sm_code         varchar2(20),
   sm_carrier      varchar2(20),
   sm_contract     varchar2(20)
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         sm_ship_mode_sk char,
         sm_ship_mode_sk char,
         sm_ship_mode_id char,
         sm_type char,
         sm_code char,
         sm_carrier char,
         sm_contract char
      )
   ) location ( 'ship_mode.dat' )
);


create table time_dim_ext (
   t_time_sk   integer not null,
   t_time_id   varchar2(16) not null,
   t_time      integer not null,
   t_hour      integer,
   t_minute    integer,
   t_second    integer,
   t_am_pm     varchar2(2),
   t_shift     varchar2(20),
   t_sub_shift varchar2(20),
   t_meal_time varchar2(20)
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         t_time_sk char,
         t_time_id char,
         t_time char,
         t_hour char,
         t_minute char,
         t_second char,
         t_am_pm char,
         t_shift char,
         t_sub_shift char,
         t_meal_time char
      )
   ) location ( 'time_dim.dat' )
);


create table reason_ext (
   r_reason_sk   integer not null,
   r_reason_id   varchar2(16) not null,
   r_reason_desc varchar2(100)
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         r_reason_sk char,
         r_reason_id char,
         r_reason_desc char
      )
   ) location ( 'reason.dat' )
);


create table income_band_ext (
   ib_income_band_sk integer not null,
   ib_lower_bound    integer,
   ib_upper_bound    integer
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         ib_income_band_sk char,
         ib_lower_bound char,
         ib_upper_bound char
      )
   ) location ( 'income_band.dat' )
);


create table item_ext (
   i_item_sk        integer not null,
   i_item_id        varchar2(16) not null,
   i_rec_start_date date,
   i_rec_end_date   date,
   i_item_desc      varchar2(200),
   i_current_price  number(7,2),
   i_wholesale_cost number(7,2),
   i_brand_id       integer,
   i_brand          varchar2(50),
   i_class_id       integer,
   i_class          varchar2(50),
   i_category_id    integer,
   i_category       varchar2(50),
   i_manufact_id    integer,
   i_manufact       varchar2(50),
   i_size           varchar2(20),
   i_formulation    varchar2(20),
   i_color          varchar2(20),
   i_units          varchar2(10),
   i_container      varchar2(10),
   i_manager_id     integer,
   i_product_name   varchar2(50)
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         i_item_sk char,
         i_item_id char,
         i_rec_start_date  date "YYYY-MM-DD",
         i_rec_end_date  date "YYYY-MM-DD",
         i_item_desc char,
         i_current_price char,
         i_wholesale_cost char,
         i_brand_id char,
         i_brand char,
         i_class_id char,
         i_class char,
         i_category_id char,
         i_category char,
         i_manufact_id char,
         i_manufact char,
         i_size char,
         i_formulation char,
         i_color char,
         i_units char,
         i_container char,
         i_manager_id char,
         i_product_name char
      )
   ) location ( 'item.dat' )
);


create table store_ext (
   s_store_sk         integer not null,
   s_store_id         varchar2(16) not null,
   s_rec_start_date   date,
   s_rec_end_date     date,
   s_closed_date_sk   integer,
   s_store_name       varchar2(50),
   s_number_employees integer,
   s_floor_space      integer,
   s_hours            varchar2(20),
   s_manager          varchar2(40),
   s_market_id        integer,
   s_geography_class  varchar2(100),
   s_market_desc      varchar2(100),
   s_market_manager   varchar2(40),
   s_division_id      integer,
   s_division_name    varchar2(50),
   s_company_id       integer,
   s_company_name     varchar2(50),
   s_street_number    varchar2(10),
   s_street_name      varchar2(60),
   s_street_type      varchar2(15),
   s_suite_number     varchar2(10),
   s_city             varchar2(60),
   s_county           varchar2(30),
   s_state            varchar2(2),
   s_zip              varchar2(10),
   s_country          varchar2(20),
   s_gmt_offset       number(5,2),
   s_tax_precentage   number(5,2)
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         s_store_sk char,
         s_store_id char,
         s_rec_start_date  date "YYYY-MM-DD",
         s_rec_end_date  date "YYYY-MM-DD",
         s_closed_date_sk char,
         s_store_name char,
         s_number_employees char,
         s_floor_space char,
         s_hours char,
         s_manager char,
         s_market_id char,
         s_geography_class char,
         s_market_desc char,
         s_market_manager char,
         s_division_id char,
         s_division_name char,
         s_company_id char,
         s_company_name char,
         s_street_number char,
         s_street_name char,
         s_street_type char,
         s_suite_number char,
         s_city char,
         s_county char,
         s_state char,
         s_zip char,
         s_country char,
         s_gmt_offset char,
         s_tax_precentage char
      )
   ) location ( 'store.dat' )
);


create table call_center_ext (
   cc_call_center_sk integer not null,
   cc_call_center_id varchar2(16) not null,
   cc_rec_start_date date,
   cc_rec_end_date   date,
   cc_closed_date_sk integer,
   cc_open_date_sk   integer,
   cc_name           varchar2(50),
   cc_class          varchar2(50),
   cc_employees      integer,
   cc_sq_ft          integer,
   cc_hours          varchar2(20),
   cc_manager        varchar2(40),
   cc_mkt_id         integer,
   cc_mkt_class      varchar2(50),
   cc_mkt_desc       varchar2(100),
   cc_market_manager varchar2(40),
   cc_division       integer,
   cc_division_name  varchar2(50),
   cc_company        integer,
   cc_company_name   varchar2(50),
   cc_street_number  varchar2(10),
   cc_street_name    varchar2(60),
   cc_street_type    varchar2(15),
   cc_suite_number   varchar2(10),
   cc_city           varchar2(60),
   cc_county         varchar2(30),
   cc_state          varchar2(2),
   cc_zip            varchar2(10),
   cc_country        varchar2(20),
   cc_gmt_offset     number(5,2),
   cc_tax_percentage number(5,2)
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         cc_call_center_sk char,
         cc_call_center_id char,
         cc_rec_start_date  date "YYYY-MM-DD",
         cc_rec_end_date  date "YYYY-MM-DD",
         cc_closed_date_sk char,
         cc_open_date_sk char,
         cc_name char,
         cc_class char,
         cc_employees char,
         cc_sq_ft char,
         cc_hours char,
         cc_manager char,
         cc_mkt_id char,
         cc_mkt_class char,
         cc_mkt_desc char,
         cc_market_manager char,
         cc_division char,
         cc_division_name char,
         cc_company char,
         cc_company_name char,
         cc_street_number char,
         cc_street_name char,
         cc_street_type char,
         cc_suite_number char,
         cc_city char,
         cc_county char,
         cc_state char,
         cc_zip char,
         cc_country char,
         cc_gmt_offset char,
         cc_tax_percentage char
      )
   ) location ( 'call_center.dat' )
);


create table customer_ext (
   c_customer_sk          integer not null,
   c_customer_id          varchar2(16) not null,
   c_current_cdemo_sk     integer,
   c_current_hdemo_sk     integer,
   c_current_addr_sk      integer,
   c_first_shipto_date_sk integer,
   c_first_sales_date_sk  integer,
   c_salutation           varchar2(10),
   c_first_name           varchar2(20),
   c_last_name            varchar2(30),
   c_preferred_cust_flag  varchar2(1),
   c_birth_day            integer,
   c_birth_month          integer,
   c_birth_year           integer,
   c_birth_country        varchar2(20),
   c_login                varchar2(13),
   c_email_address        varchar2(50),
   c_last_review_date     varchar2(10)
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         c_customer_sk char,
         c_customer_id char,
         c_current_cdemo_sk char,
         c_current_hdemo_sk char,
         c_current_addr_sk char,
         c_first_shipto_date_sk char,
         c_first_sales_date_sk char,
         c_salutation char,
         c_first_name char,
         c_last_name char,
         c_preferred_cust_flag char,
         c_birth_day char,
         c_birth_month char,
         c_birth_year char,
         c_birth_country char,
         c_login char,
         c_email_address char,
         c_last_review_date char
      )
   ) location ( 'customer.dat' )
);


create table web_site_ext (
   web_site_sk        integer not null,
   web_site_id        varchar2(16) not null,
   web_rec_start_date date,
   web_rec_end_date   date,
   web_name           varchar2(50),
   web_open_date_sk   integer,
   web_close_date_sk  integer,
   web_class          varchar2(50),
   web_manager        varchar2(40),
   web_mkt_id         integer,
   web_mkt_class      varchar2(50),
   web_mkt_desc       varchar2(100),
   web_market_manager varchar2(40),
   web_company_id     integer,
   web_company_name   varchar2(50),
   web_street_number  varchar2(10),
   web_street_name    varchar2(60),
   web_street_type    varchar2(15),
   web_suite_number   varchar2(10),
   web_city           varchar2(60),
   web_county         varchar2(30),
   web_state          varchar2(2),
   web_zip            varchar2(10),
   web_country        varchar2(20),
   web_gmt_offset     number(5,2),
   web_tax_percentage number(5,2)
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         web_site_sk char,
         web_site_id char,
         web_rec_start_date  date "YYYY-MM-DD",
         web_rec_end_date  date "YYYY-MM-DD",
         web_name char,
         web_open_date_sk char,
         web_close_date_sk char,
         web_class char,
         web_manager char,
         web_mkt_id char,
         web_mkt_class char,
         web_mkt_desc char,
         web_market_manager char,
         web_company_id char,
         web_company_name char,
         web_street_number char,
         web_street_name char,
         web_street_type char,
         web_suite_number char,
         web_city char,
         web_county char,
         web_state char,
         web_zip char,
         web_country char,
         web_gmt_offset char,
         web_tax_percentage char
      )
   ) location ( 'web_site.dat' )
);


create table store_returns_ext (
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
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         sr_returned_date_sk char,
         sr_return_time_sk char,
         sr_item_sk char,
         sr_customer_sk char,
         sr_cdemo_sk char,
         sr_hdemo_sk char,
         sr_addr_sk char,
         sr_store_sk char,
         sr_reason_sk char,
         sr_ticket_number char,
         sr_return_quantity char,
         sr_return_amt char,
         sr_return_tax char,
         sr_return_amt_inc_tax char,
         sr_fee char,
         sr_return_ship_cost char,
         sr_refunded_cash char,
         sr_reversed_charge char,
         sr_store_credit char,
         sr_net_loss char
      )
   ) location ( 'store_returns.dat' )
);


create table household_demographics_ext (
   hd_demo_sk        integer not null,
   hd_income_band_sk integer,
   hd_buy_potential  varchar2(15),
   hd_dep_count      integer,
   hd_vehicle_count  integer
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         hd_demo_sk char,
         hd_income_band_sk char,
         hd_buy_potential char,
         hd_dep_count char,
         hd_vehicle_count char
      )
   ) location ( 'household_demographics.dat' )
);


create table web_page_ext (
   wp_web_page_sk      integer not null,
   wp_web_page_id      varchar2(16) not null,
   wp_rec_start_date   date,
   wp_rec_end_date     date,
   wp_creation_date_sk integer,
   wp_access_date_sk   integer,
   wp_autogen_flag     varchar2(1),
   wp_customer_sk      integer,
   wp_url              varchar2(100),
   wp_type             varchar2(50),
   wp_varchar2_count   integer,
   wp_link_count       integer,
   wp_image_count      integer,
   wp_max_ad_count     integer
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         wp_web_page_sk char,
         wp_web_page_id char,
         wp_rec_start_date  date "YYYY-MM-DD",
         wp_rec_end_date  date "YYYY-MM-DD",
         wp_creation_date_sk char,
         wp_access_date_sk char,
         wp_autogen_flag char,
         wp_customer_sk char,
         wp_url char,
         wp_type char,
         wp_varchar2_count char,
         wp_link_count char,
         wp_image_count char,
         wp_max_ad_count char
      )
   ) location ( 'web_page.dat' )
);


create table promotion_ext (
   p_promo_sk        integer not null,
   p_promo_id        varchar2(16) not null,
   p_start_date_sk   integer,
   p_end_date_sk     integer,
   p_item_sk         integer,
   p_cost            number(15,2),
   p_response_target integer,
   p_promo_name      varchar2(50),
   p_channel_dmail   varchar2(1),
   p_channel_email   varchar2(1),
   p_channel_catalog varchar2(1),
   p_channel_tv      varchar2(1),
   p_channel_radio   varchar2(1),
   p_channel_press   varchar2(1),
   p_channel_event   varchar2(1),
   p_channel_demo    varchar2(1),
   p_channel_details varchar2(100),
   p_purpose         varchar2(15),
   p_discount_active varchar2(1)
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         p_promo_sk char,
         p_promo_id char,
         p_start_date_sk  date "YYYY-MM-DD",
         p_end_date_sk  date "YYYY-MM-DD",
         p_item_sk char,
         p_cost char,
         p_response_target char,
         p_promo_name char,
         p_channel_dmail char,
         p_channel_email char,
         p_channel_catalog char,
         p_channel_tv char,
         p_channel_radio char,
         p_channel_press char,
         p_channel_event char,
         p_channel_demo char,
         p_channel_details char,
         p_purpose char,
         p_discount_active char
      )
   ) location ( 'promotion.dat' )
);


create table catalog_page_ext (
   cp_catalog_page_sk     integer not null,
   cp_catalog_page_id     varchar2(16) not null,
   cp_start_date_sk       integer,
   cp_end_date_sk         integer,
   cp_department          varchar2(50),
   cp_catalog_number      integer,
   cp_catalog_page_number integer,
   cp_description         varchar2(100),
   cp_type                varchar2(100)
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         cp_catalog_page_sk char,
         cp_catalog_page_id char,
         cp_start_date_sk  date "YYYY-MM-DD",
         cp_end_date_sk  date "YYYY-MM-DD",
         cp_department char,
         cp_catalog_number char,
         cp_catalog_page_number char,
         cp_description char,
         cp_type char
      )
   ) location ( 'catalog_page.dat' )
);


create table inventory_ext (
   inv_date_sk          integer not null,
   inv_item_sk          integer not null,
   inv_warehouse_sk     integer not null,
   inv_quantity_on_hand integer
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         inv_date_sk char,
         inv_item_sk char,
         inv_warehouse_sk char,
         inv_quantity_on_hand char
      )
   ) location ( 'inventory.dat' )
);


create table catalog_returns_ext (
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
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         cr_returned_date_sk char,
         cr_returned_time_sk char,
         cr_item_sk char,
         cr_refunded_customer_sk char,
         cr_refunded_cdemo_sk char,
         cr_refunded_hdemo_sk char,
         cr_refunded_addr_sk char,
         cr_returning_customer_sk char,
         cr_returning_cdemo_sk char,
         cr_returning_hdemo_sk char,
         cr_returning_addr_sk char,
         cr_call_center_sk char,
         cr_catalog_page_sk char,
         cr_ship_mode_sk char,
         cr_warehouse_sk char,
         cr_reason_sk char,
         cr_order_number char,
         cr_return_quantity char,
         cr_return_amount char,
         cr_return_tax char,
         cr_return_amt_inc_tax char,
         cr_fee char,
         cr_return_ship_cost char,
         cr_refunded_cash char,
         cr_reversed_charge char,
         cr_store_credit char,
         cr_net_loss char
      )
   ) location ( 'catalog_returns.dat' )
);


create table web_returns_ext (
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
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         wr_returned_date_sk char,
         wr_returned_time_sk char,
         wr_item_sk char,
         wr_refunded_customer_sk char,
         wr_refunded_cdemo_sk char,
         wr_refunded_hdemo_sk char,
         wr_refunded_addr_sk char,
         wr_returning_customer_sk char,
         wr_returning_cdemo_sk char,
         wr_returning_hdemo_sk char,
         wr_returning_addr_sk char,
         wr_web_page_sk char,
         wr_reason_sk char,
         wr_order_number char,
         wr_return_quantity char,
         wr_return_amt char,
         wr_return_tax char,
         wr_return_amt_inc_tax char,
         wr_fee char,
         wr_return_ship_cost char,
         wr_refunded_cash char,
         wr_reversed_charge char,
         wr_account_credit char,
         wr_net_loss char
      )
   ) location ( 'web_returns.dat' )
);


create table web_sales_ext (
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
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         ws_sold_date_sk char,
         ws_sold_time_sk char,
         ws_ship_date_sk char,
         ws_item_sk char,
         ws_bill_customer_sk char,
         ws_bill_cdemo_sk char,
         ws_bill_hdemo_sk char,
         ws_bill_addr_sk char,
         ws_ship_customer_sk char,
         ws_ship_cdemo_sk char,
         ws_ship_hdemo_sk char,
         ws_ship_addr_sk char,
         ws_web_page_sk char,
         ws_web_site_sk char,
         ws_ship_mode_sk char,
         ws_warehouse_sk char,
         ws_promo_sk char,
         ws_order_number char,
         ws_quantity char,
         ws_wholesale_cost char,
         ws_list_price char,
         ws_sales_price char,
         ws_ext_discount_amt char,
         ws_ext_sales_price char,
         ws_ext_wholesale_cost char,
         ws_ext_list_price char,
         ws_ext_tax char,
         ws_coupon_amt char,
         ws_ext_ship_cost char,
         ws_net_paid char,
         ws_net_paid_inc_tax char,
         ws_net_paid_inc_ship char,
         ws_net_paid_inc_ship_tax char,
         ws_net_profit char
      )
   ) location ( 'web_sales.dat' )
);


create table catalog_sales_ext (
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
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         cs_sold_date_sk char,
         cs_sold_time_sk char,
         cs_ship_date_sk char,
         cs_bill_customer_sk char,
         cs_bill_cdemo_sk char,
         cs_bill_hdemo_sk char,
         cs_bill_addr_sk char,
         cs_ship_customer_sk char,
         cs_ship_cdemo_sk char,
         cs_ship_hdemo_sk char,
         cs_ship_addr_sk char,
         cs_call_center_sk char,
         cs_catalog_page_sk char,
         cs_ship_mode_sk char,
         cs_warehouse_sk char,
         cs_item_sk char,
         cs_promo_sk char,
         cs_order_number char,
         cs_quantity char,
         cs_wholesale_cost char,
         cs_list_price char,
         cs_sales_price char,
         cs_ext_discount_amt char,
         cs_ext_sales_price char,
         cs_ext_wholesale_cost char,
         cs_ext_list_price char,
         cs_ext_tax char,
         cs_coupon_amt char,
         cs_ext_ship_cost char,
         cs_net_paid char,
         cs_net_paid_inc_tax char,
         cs_net_paid_inc_ship char,
         cs_net_paid_inc_ship_tax char,
         cs_net_profit char
      )
   ) location ( 'catalog_sales.dat' )
);


create table store_sales_ext (
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
)
organization external ( type oracle_loader
   default directory tpc_data access parameters (
      records delimited by newline
      fields terminated by '|' missing field values are null (
         ss_sold_date_sk char,
         ss_sold_time_sk char,
         ss_item_sk char,
         ss_customer_sk char,
         ss_cdemo_sk char,
         ss_hdemo_sk char,
         ss_addr_sk char,
         ss_store_sk char,
         ss_promo_sk char,
         ss_ticket_number char,
         ss_quantity char,
         ss_wholesale_cost char,
         ss_list_price char,
         ss_sales_price char,
         ss_ext_discount_amt char,
         ss_ext_sales_price char,
         ss_ext_wholesale_cost char,
         ss_ext_list_price char,
         ss_ext_tax char,
         ss_coupon_amt char,
         ss_net_paid char,
         ss_net_paid_inc_tax char,
         ss_net_profit char
      )
   ) location ( 'store_sales.dat' )
);