-- rollback;



insert into  CATALOG_PAGE select * from CATALOG_PAGE_ext;
insert into  CATALOG_RETURNS select * from CATALOG_RETURNS_ext;
insert into  CATALOG_SALES select * from CATALOG_SALES_ext;
insert into  CUSTOMER select * from CUSTOMER_ext;
insert into  CUSTOMER_ADDRESS select * from CUSTOMER_ADDRESS_ext;
insert into  CUSTOMER_DEMOGRAPHICS select * from CUSTOMER_DEMOGRAPHICS_ext;
insert into  DATE_DIM select * from DATE_DIM_ext;
insert into  DBGEN_VERSION select * from DBGEN_VERSION_ext;
insert into  HOUSEHOLD_DEMOGRAPHICS select * from HOUSEHOLD_DEMOGRAPHICS_ext;
insert into  INCOME_BAND select * from INCOME_BAND_ext;
insert into  INVENTORY select * from INVENTORY_ext;
insert into  ITEM select * from ITEM_ext;
insert into  PROMOTION select * from PROMOTION_ext;
insert into  REASON select * from REASON_ext;
insert into  SHIP_MODE select * from SHIP_MODE_ext;
insert into  STORE select * from STORE_ext;
insert into  STORE_RETURNS select * from STORE_RETURNS_ext;
insert into  STORE_SALES select * from STORE_SALES_ext;
insert into  TIME_DIM select * from TIME_DIM_ext;
insert into  WAREHOUSE select * from WAREHOUSE_ext;
insert into  WEB_PAGE select * from WEB_PAGE_ext;
insert into  WEB_RETURNS select * from WEB_RETURNS_ext;
insert into  WEB_SALES select * from WEB_SALES_ext;
insert into  WEB_SITE select * from WEB_SITE_ext;

commit;