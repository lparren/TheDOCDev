
drop table tpch.h_customer cascade constraints;
drop table customer_ext;
drop table tpch.h_lineitem cascade constraints;
drop table lineitem_ext;
drop table tpch.h_nation cascade constraints;
drop table nation_ext;
drop table tpch.h_order cascade constraints;
drop table order_ext;
drop table tpch.h_part cascade constraints;
drop table part_ext;
drop table tpch.h_partsupp cascade constraints;
drop table partsupp_ext;
drop table tpch.h_region cascade constraints;
drop table region_ext;
drop table tpch.h_supplier cascade constraints;
drop table supplier_ext;


BEGIN
   DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
    table_name =>'PART_EXT',
    credential_name =>'BIDEMO_CRED',
    file_uri_list =>'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/OAC_BACKUP/o/part.tbl',
    format => json_object('delimiter' value '|'),
    column_list => 'p_partkey number(10),
  p_name varchar2(55),
  p_mfgr varchar2(25),
  p_brand varchar2(10),
  p_type varchar2(25),
  p_size number(38),
  p_container varchar2(10),
  p_retailprice number,
  p_comment varchar2(23)' );

   DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
    table_name =>'CUSTOMER_EXT',
    credential_name =>'BIDEMO_CRED',
    file_uri_list =>'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/OAC_BACKUP/o/customer.tbl',
    format => json_object('delimiter' value '|'),
    column_list => 'c_custkey number(10),
  c_name varchar2(25),
  c_address varchar2(40),
  c_nationkey number(10),
  c_phone varchar2(15),
  c_acctbal number,
  c_mktsegment varchar2(10),
  c_comment varchar2(117)' );

   DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
    table_name =>'LINEITEM_EXT',
    credential_name =>'BIDEMO_CRED',
    file_uri_list =>'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/OAC_BACKUP/o/lineitem.tbl',
    format => json_object('delimiter' value '|'),
    column_list => 'l_orderkey number(10),
  l_partkey number(10),
  l_suppkey number(10),
  l_linenumber number(38),
  l_quantity number,
  l_extendedprice number,
  l_discount number,
  l_tax number,
  l_returnflag char(1),
  l_linestatus char(1),
  l_shipdate varchar2(10),
  l_commitdate varchar2(10),
  l_receiptdate varchar2(10),
  l_shipinstruct varchar2(25),
  l_shipmode varchar2(10),
  l_comment varchar2(44)' );

   DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
    table_name =>'NATION_EXT',
    credential_name =>'BIDEMO_CRED',
    file_uri_list =>'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/OAC_BACKUP/o/nation.tbl',
    format => json_object('delimiter' value '|'),
    column_list => 'n_nationkey number(10),
  n_name varchar2(25),
  n_regionkey number(10),
  n_comment varchar2(152)' );

   DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
    table_name =>'ORDER_EXT',
    credential_name =>'BIDEMO_CRED',
    file_uri_list =>'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/OAC_BACKUP/o/orders.tbl',
    format => json_object('delimiter' value '|'),
    column_list => 'o_orderkey number(10),
  o_custkey number(10),
  o_orderstatus char(1),
  o_totalprice number,
  o_orderdate varchar2(10),
  o_orderpriority varchar2(15),
  o_clerk varchar2(15),
  o_shippriority number(38),
  o_comment varchar2(79)' );

   DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
    table_name =>'PARTSUPP_EXT',
    credential_name =>'BIDEMO_CRED',
    file_uri_list =>'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/OAC_BACKUP/o/partsupp.tbl',
    format => json_object('delimiter' value '|'),
    column_list => 'ps_partkey number(10),
  ps_suppkey number(10),
  ps_availqty number(38),
  ps_supplycost number,
  ps_comment varchar2(199)' );

   DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
    table_name =>'REGION_EXT',
    credential_name =>'BIDEMO_CRED',
    file_uri_list =>'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/OAC_BACKUP/o/region.tbl',
    format => json_object('delimiter' value '|'),
    column_list => ' r_regionkey number(10),
  r_name varchar2(25),
  r_comment varchar2(152)' );

   DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
    table_name =>'SUPPLIER_EXT',
    credential_name =>'BIDEMO_CRED',
    file_uri_list =>'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/OAC_BACKUP/o/supplier.tbl',
    format => json_object('delimiter' value '|'),
    column_list => 's_suppkey number(10),
  s_name varchar2(25),
  s_address varchar2(40),
  s_nationkey number(10),
  s_phone varchar2(15),
  s_acctbal number,
  s_comment varchar2(101)' );
END;
/

create table tpch.h_customer (
  c_custkey number(10) not null,
  c_name varchar2(25) not null,
  c_address varchar2(40) not null,
  c_nationkey number(10) not null,
  c_phone varchar2(15) not null,
  c_acctbal number not null,
  c_mktsegment varchar2(10) not null,
  c_comment varchar2(117) not null
);


create table tpch.h_lineitem (
  l_orderkey number(10) not null,
  l_partkey number(10) not null,
  l_suppkey number(10) not null,
  l_linenumber integer not null,
  l_quantity number not null,
  l_extendedprice number not null,
  l_discount number not null,
  l_tax number not null,
  l_returnflag char(1) not null,
  l_linestatus char(1) not null,
  l_shipdate date not null,
  l_commitdate date not null,
  l_receiptdate date not null,
  l_shipinstruct varchar2(25) not null,
  l_shipmode varchar2(10) not null,
  l_comment varchar2(44) not null
);


create table tpch.h_nation (
  n_nationkey number(10) not null,
  n_name varchar2(25) not null,
  n_regionkey number(10) not null,
  n_comment varchar2(152) not null
);


create table tpch.h_order (
  o_orderkey number(10) not null,
  o_custkey number(10) not null,
  o_orderstatus char(1) not null,
  o_totalprice number not null,
  o_orderdate date not null,
  o_orderpriority varchar2(15) not null,
  o_clerk varchar2(15) not null,
  o_shippriority integer not null,
  o_comment varchar2(79) not null
);


create table tpch.h_part (
  p_partkey number(10) not null,
  p_name varchar2(55) not null,
  p_mfgr varchar2(25) not null,
  p_brand varchar2(10) not null,
  p_type varchar2(25) not null,
  p_size integer not null,
  p_container varchar2(10) not null,
  p_retailprice number not null,
  p_comment varchar2(23) not null
);


create table tpch.h_partsupp (
  ps_partkey number(10) not null,
  ps_suppkey number(10) not null,
  ps_availqty integer not null,
  ps_supplycost number not null,
  ps_comment varchar2(199) not null
);


create table tpch.h_region (
  r_regionkey number(10) not null,
  r_name varchar2(25) not null,
  r_comment varchar2(152) not null
);


create table tpch.h_supplier (
  s_suppkey number(10) not null,
  s_name varchar2(25) not null,
  s_address varchar2(40) not null,
  s_nationkey number(10) not null,
  s_phone varchar2(15) not null,
  s_acctbal number not null,
  s_comment varchar2(101) not null
);

insert /*+append*/ into tpch.h_customer 
select * from customer_ext;
commit;

insert /*+append*/ into tpch.h_lineitem
select l_orderkey,
       l_partkey,
       l_suppkey,
       l_linenumber,
       l_quantity,
       l_extendedprice,
       l_discount,
       l_tax,
       l_returnflag,
       l_linestatus,
       to_date(l_shipdate, 'YYYY-MM-DD'),
       to_date(l_commitdate, 'YYYY-MM-DD'),
       to_date(l_receiptdate, 'YYYY-MM-DD'),
       l_shipinstruct,
       l_shipmode,
       l_comment
from lineitem_ext;
commit;

insert  /*+append*/ into tpch.h_nation
select * from nation_ext;
commit;

insert /*+append*/ into tpch.h_order
select o_orderkey,
       o_custkey,
       o_orderstatus,
       o_totalprice,
       to_date(o_orderdate, 'YYYY-MM-DD'),
       o_orderpriority,
       o_clerk,
       o_shippriority,
       o_comment
from order_ext;
commit;

insert /*+append*/ into tpch.h_part
select * from part_ext;
commit;

insert /*+append*/ into tpch.h_partsupp
select * from partsupp_ext;
commit;

insert /*+append*/ into tpch.h_region
select * from region_ext;
commit;

insert /*+append*/ into tpch.h_supplier
select * from supplier_ext;
commit;
