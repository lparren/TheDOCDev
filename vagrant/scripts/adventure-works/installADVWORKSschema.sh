echo "*******************************************************"
echo "*** Installing advworks sample schema                  ***"
echo "*******************************************************"
cd /tmp
unzip advworks-data.zip
ls -l *.csv
mkdir /home/oracle/advworks
mv *.csv /home/oracle/advworks
rm *.csv
dos2unix -f /home/oracle/advworks/*.csv
echo "*** Create ADVWORKS schema"
sqlplus system/$ORACLE_PWD@localhost:1521/$ORACLE_PDB << EOF
    BEGIN
       EXECUTE IMMEDIATE 'CREATE ROLE DEVELOPER_ROLE_19C';
    EXCEPTION
      WHEN OTHERS THEN NULL;
   END;
   /
    -- Basic Connectivity and Resource Management
    GRANT CREATE SESSION, SET CONTAINER TO DEVELOPER_ROLE_19C;
    GRANT RESOURCE TO DEVELOPER_ROLE_19C;

    -- Core Object Creation Privileges
    GRANT CREATE VIEW, CREATE SYNONYM, CREATE PUBLIC SYNONYM TO DEVELOPER_ROLE_19C;
    GRANT CREATE MATERIALIZED VIEW, CREATE TABLE, CREATE SEQUENCE TO DEVELOPER_ROLE_19C;
    GRANT CREATE PROCEDURE, CREATE TRIGGER, CREATE TYPE TO DEVELOPER_ROLE_19C;

    -- Advanced Development and Debugging
    GRANT CREATE JOB, CREATE DIMENSION, CREATE INDEXTYPE, CREATE OPERATOR TO DEVELOPER_ROLE_19C;
    GRANT DEBUG CONNECT SESSION, ON COMMIT REFRESH, FORCE TRANSACTION TO DEVELOPER_ROLE_19C;

    drop user advworks cascade;
    CREATE USER advworks IDENTIFIED BY advworks;
    GRANT DEVELOPER_ROLE_19C TO advworks;
    GRANT UNLIMITED TABLESPACE TO advworks;

    CREATE OR REPLACE DIRECTORY advworks_dir AS '/home/oracle/advworks';
    GRANT READ, WRITE ON DIRECTORY advworks_dir TO advworks;
EOF

echo "*** Create tables schema"
sqlplus advworks/advworks@localhost:1521/$ORACLE_PDB << EOF
-- ================================================================
-- Create sequences for IDENTITY replacement
-- ================================================================

CREATE SEQUENCE seq_dimaccount_accountkey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_dimcurrency_currencykey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_dimcustomer_customerkey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_dimdepartmentgroup_departmentgroupkey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_dimemployee_employeekey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_dimgeography_geographykey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_dimorganization_organizationkey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_dimproduct_productkey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_dimproductcategory_productcategorykey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_dimproductsubcategory_productsubcategorykey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_dimpromotion_promotionkey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_dimreseller_resellerkey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_dimsalesreason_salesreasonkey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_dimsalesterritory_salesterritorykey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_dimscenario_scenariokey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_factcallcenter_factcallcenterid START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_factfinance_financekey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_factsalesquota_salesquotakey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_factsurveyresponse_surveyresponsekey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_prospectivebuyer_prospectivebuyerkey START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_sysdiagrams_diagram_id START WITH 1 INCREMENT BY 1;

-- ========================================================
-- Create User Defined Functions
-- ========================================================

CREATE OR REPLACE FUNCTION udfbuildiso8601date (
   p_year  IN NUMBER,
   p_month IN NUMBER,
   p_day   IN NUMBER
) RETURN DATE IS
   v_result DATE;
BEGIN
   v_result := TO_DATE ( to_char(p_year)
                         || '-'
                         || lpad(
      to_char(p_month),
      2,
      '0'
   )
                         || '-'
                         || lpad(
      to_char(p_day),
      2,
      '0'
   ),'YYYY-MM-DD' );
   RETURN v_result;
END udfbuildiso8601date;
/

CREATE OR REPLACE FUNCTION udfminimumdate (
   p_x IN DATE,
   p_y IN DATE
) RETURN DATE IS
   v_z DATE;
BEGIN
   IF p_x <= p_y THEN
      v_z := p_x;
   ELSE
      v_z := p_y;
   END IF;
   RETURN v_z;
END udfminimumdate;

CREATE OR REPLACE FUNCTION udftwodigitzerofill (
   p_number IN NUMBER
) RETURN CHAR IS
   v_result VARCHAR2(2 CHAR);
BEGIN
   IF p_number > 9 THEN
      v_result := to_char(p_number);
   ELSE
      v_result := '0' || to_char(p_number);
   END IF;
   RETURN v_result;
END udftwodigitzerofill;
/

-- ========================================================
-- Create tables
-- ========================================================

CREATE TABLE dimaccount (
   accountkey                    NUMBER PRIMARY KEY,
   parentaccountkey              NUMBER,
   accountcodealternatekey       NUMBER,
   parentaccountcodealternatekey NUMBER,
   accountdescription            VARCHAR2(50 CHAR),
   accounttype                   VARCHAR2(50 CHAR),
   operator                      VARCHAR2(50 CHAR),
   custommembers                 VARCHAR2(300 CHAR),
   valuetype                     VARCHAR2(50 CHAR),
   custommemberoptions           VARCHAR2(200 CHAR)
);


CREATE TABLE dimcurrency (
   currencykey          NUMBER PRIMARY KEY,
   currencyalternatekey VARCHAR2(3 CHAR) NOT NULL,
   currencyname         VARCHAR2(50 CHAR) NOT NULL
);


CREATE TABLE dimcustomer (
   customerkey          NUMBER PRIMARY KEY,
   geographykey         NUMBER,
   customeralternatekey VARCHAR2(15 CHAR) NOT NULL,
   title                VARCHAR2(8 CHAR),
   firstname            VARCHAR2(50 CHAR),
   middlename           VARCHAR2(50 CHAR),
   lastname             VARCHAR2(50 CHAR),
   namestyle            NUMBER(1),
   birthdate            DATE,
   maritalstatus        VARCHAR2(1 CHAR),
   suffix               VARCHAR2(10 CHAR),
   gender               VARCHAR2(1 CHAR),
   emailaddress         VARCHAR2(50 CHAR),
   yearlyincome         NUMBER(19,4),
   totalchildren        NUMBER(3),
   numberchildrenathome NUMBER(3),
   englisheducation     VARCHAR2(40 CHAR),
   spanisheducation     VARCHAR2(40 CHAR),
   frencheducation      VARCHAR2(40 CHAR),
   englishoccupation    VARCHAR2(100 CHAR),
   spanishoccupation    VARCHAR2(100 CHAR),
   frenchoccupation     VARCHAR2(100 CHAR),
   houseownerflag       VARCHAR2(1 CHAR),
   numbercarsowned      NUMBER(3),
   addressline1         VARCHAR2(120 CHAR),
   addressline2         VARCHAR2(120 CHAR),
   phone                VARCHAR2(20 CHAR),
   datefirstpurchase    DATE,
   commutedistance      VARCHAR2(15 CHAR)
);


CREATE TABLE dimdate (
   datekey              NUMBER NOT NULL PRIMARY KEY,
   fulldatealternatekey DATE NOT NULL,
   daynumberofweek      NUMBER(3) NOT NULL,
   englishdaynameofweek VARCHAR2(10 CHAR) NOT NULL,
   spanishdaynameofweek VARCHAR2(10 CHAR) NOT NULL,
   frenchdaynameofweek  VARCHAR2(10 CHAR) NOT NULL,
   daynumberofmonth     NUMBER(3) NOT NULL,
   daynumberofyear      NUMBER(5) NOT NULL,
   weeknumberofyear     NUMBER(3) NOT NULL,
   englishmonthname     VARCHAR2(10 CHAR) NOT NULL,
   spanishmonthname     VARCHAR2(10 CHAR) NOT NULL,
   frenchmonthname      VARCHAR2(10 CHAR) NOT NULL,
   monthnumberofyear    NUMBER(3) NOT NULL,
   calendarquarter      NUMBER(3) NOT NULL,
   calendaryear         NUMBER(5) NOT NULL,
   calendarsemester     NUMBER(3) NOT NULL,
   fiscalquarter        NUMBER(3) NOT NULL,
   fiscalyear           NUMBER(5) NOT NULL,
   fiscalsemester       NUMBER(3) NOT NULL
);


CREATE TABLE dimdepartmentgroup (
   departmentgroupkey       NUMBER PRIMARY KEY,
   parentdepartmentgroupkey NUMBER,
   departmentgroupname      VARCHAR2(50 CHAR)
);


CREATE TABLE dimemployee (
   employeekey                          NUMBER PRIMARY KEY,
   parentemployeekey                    NUMBER,
   employeenationalidalternatekey       VARCHAR2(15 CHAR),
   parentemployeenationalidalternatekey VARCHAR2(15 CHAR),
   salesterritorykey                    NUMBER,
   firstname                            VARCHAR2(50 CHAR) NOT NULL,
   lastname                             VARCHAR2(50 CHAR) NOT NULL,
   middlename                           VARCHAR2(50 CHAR),
   namestyle                            NUMBER(1) NOT NULL,
   title                                VARCHAR2(50 CHAR),
   hiredate                             DATE,
   birthdate                            DATE,
   loginid                              VARCHAR2(256 CHAR),
   emailaddress                         VARCHAR2(50 CHAR),
   phone                                VARCHAR2(25 CHAR),
   maritalstatus                        VARCHAR2(1 CHAR),
   emergencycontactname                 VARCHAR2(50 CHAR),
   emergencycontactphone                VARCHAR2(25 CHAR),
   salariedflag                         NUMBER(1),
   gender                               VARCHAR2(1 CHAR),
   payfrequency                         NUMBER(3),
   baserate                             NUMBER(19,4),
   vacationhours                        NUMBER(5),
   sickleavehours                       NUMBER(5),
   currentflag                          NUMBER(1) NOT NULL,
   salespersonflag                      NUMBER(1) NOT NULL,
   departmentname                       VARCHAR2(50 CHAR),
   startdate                            DATE,
   enddate                              DATE,
   status                               VARCHAR2(50 CHAR),
   employeephoto                        BLOB
);



CREATE TABLE dimgeography (
   geographykey             NUMBER PRIMARY KEY,
   city                     VARCHAR2(30 CHAR),
   stateprovincecode        VARCHAR2(3 CHAR),
   stateprovincename        VARCHAR2(50 CHAR),
   countryregioncode        VARCHAR2(3 CHAR),
   englishcountryregionname VARCHAR2(50 CHAR),
   spanishcountryregionname VARCHAR2(50 CHAR),
   frenchcountryregionname  VARCHAR2(50 CHAR),
   postalcode               VARCHAR2(15 CHAR),
   salesterritorykey        NUMBER,
   ipaddresslocator         VARCHAR2(15 CHAR)
);



CREATE TABLE dimorganization (
   organizationkey       NUMBER PRIMARY KEY,
   parentorganizationkey NUMBER,
   percentageofownership VARCHAR2(16 CHAR),
   organizationname      VARCHAR2(50 CHAR),
   currencykey           NUMBER
);



CREATE TABLE dimproduct (
   productkey            NUMBER PRIMARY KEY,
   productalternatekey   VARCHAR2(25 CHAR),
   productsubcategorykey NUMBER,
   weightunitmeasurecode VARCHAR2(3 CHAR),
   sizeunitmeasurecode   VARCHAR2(3 CHAR),
   englishproductname    VARCHAR2(50 CHAR) NOT NULL,
   spanishproductname    VARCHAR2(50 CHAR) NOT NULL,
   frenchproductname     VARCHAR2(50 CHAR) NOT NULL,
   standardcost          NUMBER(19,4),
   finishedgoodsflag     NUMBER(1) NOT NULL,
   color                 VARCHAR2(15 CHAR) NOT NULL,
   safetystocklevel      NUMBER(5),
   reorderpoint          NUMBER(5),
   listprice             NUMBER(19,4),
   prdsize               VARCHAR2(50 CHAR),
   sizerange             VARCHAR2(50 CHAR),
   weight                NUMBER,
   daystomanufacture     NUMBER,
   productline           VARCHAR2(2 CHAR),
   dealerprice           NUMBER(19,4),
   prdclass              VARCHAR2(2 CHAR),
   prdstyle              VARCHAR2(2 CHAR),
   modelname             VARCHAR2(50 CHAR),
   largephoto            BLOB,
   englishdescription    VARCHAR2(2000 CHAR),
   frenchdescription     VARCHAR2(2000 CHAR),
   chinesedescription    VARCHAR2(2000 CHAR),
   arabicdescription     VARCHAR2(2000 CHAR),
   hebrewdescription     VARCHAR2(2000 CHAR),
   thaidescription       VARCHAR2(2000 CHAR),
   germandescription     VARCHAR2(2000 CHAR),
   japanesedescription   VARCHAR2(2000 CHAR),
   turkishdescription    VARCHAR2(2000 CHAR),
   startdate             TIMESTAMP,
   enddate               TIMESTAMP,
   status                VARCHAR2(7 CHAR)
);



CREATE TABLE dimproductcategory (
   productcategorykey          NUMBER PRIMARY KEY,
   productcategoryalternatekey NUMBER,
   englishproductcategoryname  VARCHAR2(50 CHAR) NOT NULL,
   spanishproductcategoryname  VARCHAR2(50 CHAR) NOT NULL,
   frenchproductcategoryname   VARCHAR2(50 CHAR) NOT NULL
);



CREATE TABLE dimproductsubcategory (
   productsubcategorykey          NUMBER PRIMARY KEY,
   productsubcategoryalternatekey NUMBER,
   englishproductsubcategoryname  VARCHAR2(50 CHAR) NOT NULL,
   spanishproductsubcategoryname  VARCHAR2(50 CHAR) NOT NULL,
   frenchproductsubcategoryname   VARCHAR2(50 CHAR) NOT NULL,
   productcategorykey             NUMBER
);


CREATE TABLE dimpromotion (
   promotionkey             NUMBER PRIMARY KEY,
   promotionalternatekey    NUMBER,
   englishpromotionname     VARCHAR2(255 CHAR),
   spanishpromotionname     VARCHAR2(255 CHAR),
   frenchpromotionname      VARCHAR2(255 CHAR),
   discountpct              BINARY_DOUBLE,
   englishpromotiontype     VARCHAR2(50 CHAR),
   spanishpromotiontype     VARCHAR2(50 CHAR),
   frenchpromotiontype      VARCHAR2(50 CHAR),
   englishpromotioncategory VARCHAR2(50 CHAR),
   spanishpromotioncategory VARCHAR2(50 CHAR),
   frenchpromotioncategory  VARCHAR2(50 CHAR),
   startdate                TIMESTAMP NOT NULL,
   enddate                  TIMESTAMP,
   minqty                   NUMBER,
   maxqty                   NUMBER
);



CREATE TABLE dimreseller (
   resellerkey          NUMBER PRIMARY KEY,
   geographykey         NUMBER,
   reselleralternatekey VARCHAR2(15 CHAR),
   phone                VARCHAR2(25 CHAR),
   businesstype         VARCHAR2(20 CHAR) NOT NULL,
   resellername         VARCHAR2(50 CHAR) NOT NULL,
   numberemployees      NUMBER,
   orderfrequency       VARCHAR2(1 CHAR),
   ordermonth           NUMBER(3),
   firstorderyear       NUMBER,
   lastorderyear        NUMBER,
   productline          VARCHAR2(50 CHAR),
   addressline1         VARCHAR2(60 CHAR),
   addressline2         VARCHAR2(60 CHAR),
   annualsales          NUMBER(19,4),
   bankname             VARCHAR2(50 CHAR),
   minpaymenttype       NUMBER(3),
   minpaymentamount     NUMBER(19,4),
   annualrevenue        NUMBER(19,4),
   yearopened           NUMBER
);



CREATE TABLE dimsalesreason (
   salesreasonkey          NUMBER PRIMARY KEY,
   salesreasonalternatekey NUMBER NOT NULL,
   salesreasonname         VARCHAR2(50 CHAR) NOT NULL,
   salesreasonreasontype   VARCHAR2(50 CHAR) NOT NULL
);



CREATE TABLE dimsalesterritory (
   salesterritorykey          NUMBER PRIMARY KEY,
   salesterritoryalternatekey NUMBER,
   salesterritoryregion       VARCHAR2(50 CHAR) NOT NULL,
   salesterritorycountry      VARCHAR2(50 CHAR) NOT NULL,
   salesterritorygroup        VARCHAR2(50 CHAR),
   salesterritoryimage        BLOB
);


CREATE TABLE dimscenario (
   scenariokey  NUMBER PRIMARY KEY,
   scenarioname VARCHAR2(50 CHAR)
);


CREATE TABLE factadditionalinternationalproductdescription (
   productkey         NUMBER NOT NULL,
   culturename        VARCHAR2(50 CHAR) NOT NULL,
   productdescription CLOB NOT NULL,
   CONSTRAINT pk_factaddintlproddesc PRIMARY KEY ( productkey,
                                                   culturename )
);


CREATE TABLE factcallcenter (
   factcallcenterid    NUMBER PRIMARY KEY,
   datekey             NUMBER NOT NULL,
   wagetype            VARCHAR2(15 CHAR) NOT NULL,
   shift               VARCHAR2(20 CHAR) NOT NULL,
   leveloneoperators   NUMBER(5) NOT NULL,
   leveltwooperators   NUMBER(5) NOT NULL,
   totaloperators      NUMBER(5) NOT NULL,
   calls               NUMBER NOT NULL,
   automaticresponses  NUMBER NOT NULL,
   orders              NUMBER NOT NULL,
   issuesraised        NUMBER(5) NOT NULL,
   averagetimeperissue NUMBER(5) NOT NULL,
   servicegrade        BINARY_DOUBLE NOT NULL,
   loaddate               DATE
);


CREATE TABLE factcurrencyrate (
   currencykey  NUMBER NOT NULL,
   datekey      NUMBER NOT NULL,
   averagerate  BINARY_DOUBLE NOT NULL,
   endofdayrate BINARY_DOUBLE NOT NULL,
   loaddate        DATE,
   CONSTRAINT pk_factcurrencyrate PRIMARY KEY ( currencykey,
                                                datekey )
);


CREATE TABLE factfinance (
   financekey         NUMBER PRIMARY KEY,
   datekey            NUMBER NOT NULL,
   organizationkey    NUMBER NOT NULL,
   departmentgroupkey NUMBER NOT NULL,
   scenariokey        NUMBER NOT NULL,
   accountkey         NUMBER NOT NULL,
   amount             BINARY_DOUBLE NOT NULL,
   loaddate              DATE
);


CREATE TABLE factinternetsales (
   productkey            NUMBER NOT NULL,
   orderdatekey          NUMBER NOT NULL,
   duedatekey            NUMBER NOT NULL,
   shipdatekey           NUMBER NOT NULL,
   customerkey           NUMBER NOT NULL,
   promotionkey          NUMBER NOT NULL,
   currencykey           NUMBER NOT NULL,
   salesterritorykey     NUMBER NOT NULL,
   salesordernumber      VARCHAR2(20 CHAR) NOT NULL,
   salesorderlinenumber  NUMBER(3) NOT NULL,
   revisionnumber        NUMBER(3) NOT NULL,
   orderquantity         NUMBER(5) NOT NULL,
   unitprice             NUMBER(19,4) NOT NULL,
   extendedamount        NUMBER(19,4) NOT NULL,
   unitpricediscountpct  BINARY_DOUBLE NOT NULL,
   discountamount        BINARY_DOUBLE NOT NULL,
   productstandardcost   NUMBER(19,4) NOT NULL,
   totalproductcost      NUMBER(19,4) NOT NULL,
   salesamount           NUMBER(19,4) NOT NULL,
   taxamt                NUMBER(19,4) NOT NULL,
   freight               NUMBER(19,4) NOT NULL,
   carriertrackingnumber VARCHAR2(25 CHAR),
   customerponumber      VARCHAR2(25 CHAR),
   orderdate             DATE,
   duedate               DATE,
   shipdate              DATE,
   CONSTRAINT pk_factinternetsales PRIMARY KEY ( salesordernumber,
                                                 salesorderlinenumber )
);


CREATE TABLE factinternetsalesreason (
   salesordernumber     VARCHAR2(20 CHAR) NOT NULL,
   salesorderlinenumber NUMBER(3) NOT NULL,
   salesreasonkey       NUMBER NOT NULL,
   CONSTRAINT pk_factinternetsalesreason PRIMARY KEY ( salesordernumber,
                                                       salesorderlinenumber,
                                                       salesreasonkey )
);



CREATE TABLE factproductinventory (
   productkey   NUMBER NOT NULL,
   datekey      NUMBER NOT NULL,
   movementdate DATE NOT NULL,
   unitcost     NUMBER(19,4) NOT NULL,
   unitsin      NUMBER NOT NULL,
   unitsout     NUMBER NOT NULL,
   unitsbalance NUMBER NOT NULL,
   CONSTRAINT pk_factproductinventory PRIMARY KEY ( productkey,
                                                    datekey )
);


CREATE TABLE factresellersales (
   productkey            NUMBER NOT NULL,
   orderdatekey          NUMBER NOT NULL,
   duedatekey            NUMBER NOT NULL,
   shipdatekey           NUMBER NOT NULL,
   resellerkey           NUMBER NOT NULL,
   employeekey           NUMBER NOT NULL,
   promotionkey          NUMBER NOT NULL,
   currencykey           NUMBER NOT NULL,
   salesterritorykey     NUMBER NOT NULL,
   salesordernumber      VARCHAR2(20 CHAR) NOT NULL,
   salesorderlinenumber  NUMBER(3) NOT NULL,
   revisionnumber        NUMBER(3),
   orderquantity         NUMBER(5),
   unitprice             NUMBER(19,4),
   extendedamount        NUMBER(19,4),
   unitpricediscountpct  BINARY_DOUBLE,
   discountamount        BINARY_DOUBLE,
   productstandardcost   NUMBER(19,4),
   totalproductcost      NUMBER(19,4),
   salesamount           NUMBER(19,4),
   taxamt                NUMBER(19,4),
   freight               NUMBER(19,4),
   carriertrackingnumber VARCHAR2(25 CHAR),
   customerponumber      VARCHAR2(25 CHAR),
   orderdate             DATE,
   duedate               DATE,
   shipdate              DATE,
   CONSTRAINT pk_factresellersales PRIMARY KEY ( salesordernumber,
                                                 salesorderlinenumber )
);


CREATE TABLE factsalesquota (
   salesquotakey    NUMBER PRIMARY KEY,
   employeekey      NUMBER NOT NULL,
   datekey          NUMBER NOT NULL,
   calendaryear     NUMBER(5) NOT NULL,
   calendarquarter  NUMBER(3) NOT NULL,
   salesamountquota NUMBER(19,4) NOT NULL,
   loaddate            DATE
);


CREATE TABLE factsurveyresponse (
   surveyresponsekey             NUMBER PRIMARY KEY,
   datekey                       NUMBER NOT NULL,
   customerkey                   NUMBER NOT NULL,
   productcategorykey            NUMBER NOT NULL,
   englishproductcategoryname    VARCHAR2(50 CHAR) NOT NULL,
   productsubcategorykey         NUMBER NOT NULL,
   englishproductsubcategoryname VARCHAR2(50 CHAR) NOT NULL,
   loaddate                         DATE
);


CREATE TABLE newfactcurrencyrate (
   averagerate  BINARY_FLOAT,
   currencyid   VARCHAR2(3 CHAR),
   currencydate DATE,
   endofdayrate BINARY_FLOAT,
   currencykey  NUMBER,
   datekey      NUMBER
);


CREATE TABLE prospectivebuyer (
   prospectivebuyerkey  NUMBER PRIMARY KEY,
   prospectalternatekey VARCHAR2(15 CHAR),
   firstname            VARCHAR2(50 CHAR),
   middlename           VARCHAR2(50 CHAR),
   lastname             VARCHAR2(50 CHAR),
   birthdate            DATE,
   maritalstatus        VARCHAR2(1 CHAR),
   gender               VARCHAR2(1 CHAR),
   emailaddress         VARCHAR2(50 CHAR),
   yearlyincome         NUMBER(19,4),
   totalchildren        NUMBER(3),
   numberchildrenathome NUMBER(3),
   education            VARCHAR2(40 CHAR),
   occupation           VARCHAR2(100 CHAR),
   houseownerflag       VARCHAR2(1 CHAR),
   numbercarsowned      NUMBER(3),
   addressline1         VARCHAR2(120 CHAR),
   addressline2         VARCHAR2(120 CHAR),
   city                 VARCHAR2(30 CHAR),
   stateprovincecode    VARCHAR2(3 CHAR),
   postalcode           VARCHAR2(15 CHAR),
   phone                VARCHAR2(20 CHAR),
   salutation           VARCHAR2(8 CHAR),
   unknown              NUMBER
);


CREATE TABLE sysdiagrams (
   name         VARCHAR2(128 CHAR) NOT NULL,
   principal_id NUMBER NOT NULL,
   diagram_id   NUMBER PRIMARY KEY,
   version      NUMBER,
   definition   CLOB
);

-- ========================================================
-- Create Indexes
-- ========================================================

CREATE UNIQUE INDEX ak_dimcurrency_currencyalternatekey ON
   dimcurrency (
      currencyalternatekey
   );

CREATE UNIQUE INDEX ix_dimcustomer_customeralternatekey ON
   dimcustomer (
      customeralternatekey
   );

CREATE UNIQUE INDEX ak_dimloaddatefulldatealternatekey ON
   dimdate (
      fulldatealternatekey
   );

CREATE UNIQUE INDEX ak_dimproduct_productalternatekey_startdate ON
   dimproduct (
      productalternatekey,
      startdate
   );

CREATE UNIQUE INDEX ak_dimproductcategory_productcategoryalternatekey ON
   dimproductcategory (
      productcategoryalternatekey
   );

CREATE UNIQUE INDEX ak_dimproductsubcategory_productsubcategoryalternatekey ON
   dimproductsubcategory (
      productsubcategoryalternatekey
   );

CREATE UNIQUE INDEX ak_dimpromotion_promotionalternatekey ON
   dimpromotion (
      promotionalternatekey
   );

CREATE UNIQUE INDEX ak_dimreseller_reselleralternatekey ON
   dimreseller (
      reselleralternatekey
   );

CREATE UNIQUE INDEX ak_dimsalesterritory_salesterritoryalternatekey ON
   dimsalesterritory (
      salesterritoryalternatekey
   );

CREATE UNIQUE INDEX ak_factcallcenter_datekey_shift ON
   factcallcenter (
      datekey,
      shift
   );

CREATE UNIQUE INDEX uk_principal_name ON
   sysdiagrams (
      principal_id,
      name
   );
EOF

echo "*** Create external tables schema"
sqlplus advworks/advworks@localhost:1521/$ORACLE_PDB << EOF
CREATE TABLE ext_dimaccount (
   accountkey                    NUMBER,
   parentaccountkey              NUMBER,
   accountcodealternatekey       NUMBER,
   parentaccountcodealternatekey NUMBER,
   accountdescription            VARCHAR2(50 CHAR),
   accounttype                   VARCHAR2(50 CHAR),
   operator                      VARCHAR2(50 CHAR),
   custommembers                 VARCHAR2(300 CHAR),
   valuetype                     VARCHAR2(50 CHAR),
   custommemberoptions           VARCHAR2(200 CHAR)
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL
   ) LOCATION ( 'DimAccount.csv' )
);

CREATE TABLE ext_dimcurrency (
   currencykey          NUMBER,
   currencyalternatekey VARCHAR2(3 CHAR) NOT NULL,
   currencyname         VARCHAR2(50 CHAR) NOT NULL
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL
   ) LOCATION ( 'DimCurrency.csv' )
);


CREATE TABLE ext_dimcustomer (
   customerkey          NUMBER,
   geographykey         NUMBER,
   customeralternatekey VARCHAR2(15 CHAR) NOT NULL,
   title                VARCHAR2(8 CHAR),
   firstname            VARCHAR2(50 CHAR),
   middlename           VARCHAR2(50 CHAR),
   lastname             VARCHAR2(50 CHAR),
   namestyle            NUMBER(1),
   birthdate            VARCHAR2(50 CHAR),
   maritalstatus        VARCHAR2(1 CHAR),
   suffix               VARCHAR2(10 CHAR),
   gender               VARCHAR2(1 CHAR),
   emailaddress         VARCHAR2(50 CHAR),
   yearlyincome         NUMBER(19,4),
   totalchildren        NUMBER(3),
   numberchildrenathome NUMBER(3),
   englisheducation     VARCHAR2(40 CHAR),
   spanisheducation     VARCHAR2(40 CHAR),
   frencheducation      VARCHAR2(40 CHAR),
   englishoccupation    VARCHAR2(100 CHAR),
   spanishoccupation    VARCHAR2(100 CHAR),
   frenchoccupation     VARCHAR2(100 CHAR),
   houseownerflag       VARCHAR2(1 CHAR),
   numbercarsowned      NUMBER(3),
   addressline1         VARCHAR2(120 CHAR),
   addressline2         VARCHAR2(120 CHAR),
   phone                VARCHAR2(20 CHAR),
   datefirstpurchase    VARCHAR2(50 CHAR),
   commutedistance      VARCHAR2(15 CHAR)
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL
   ) LOCATION ( 'DimCustomer.csv' )
);


CREATE TABLE ext_dimdate (
   datekey              NUMBER NOT NULL,
   fulldatealternatekey VARCHAR2(50 CHAR) NOT NULL,
   daynumberofweek      NUMBER(3) NOT NULL,
   englishdaynameofweek VARCHAR2(10 CHAR) NOT NULL,
   spanishdaynameofweek VARCHAR2(10 CHAR) NOT NULL,
   frenchdaynameofweek  VARCHAR2(10 CHAR) NOT NULL,
   daynumberofmonth     NUMBER(3) NOT NULL,
   daynumberofyear      NUMBER(5) NOT NULL,
   weeknumberofyear     NUMBER(3) NOT NULL,
   englishmonthname     VARCHAR2(10 CHAR) NOT NULL,
   spanishmonthname     VARCHAR2(10 CHAR) NOT NULL,
   frenchmonthname      VARCHAR2(10 CHAR) NOT NULL,
   monthnumberofyear    NUMBER(3) NOT NULL,
   calendarquarter      NUMBER(3) NOT NULL,
   calendaryear         NUMBER(5) NOT NULL,
   calendarsemester     NUMBER(3) NOT NULL,
   fiscalquarter        NUMBER(3) NOT NULL,
   fiscalyear           NUMBER(5) NOT NULL,
   fiscalsemester       NUMBER(3) NOT NULL
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL
   ) LOCATION ( 'DimDate.csv' )
);


CREATE TABLE ext_dimdepartmentgroup (
   departmentgroupkey       NUMBER,
   parentdepartmentgroupkey NUMBER,
   departmentgroupname      VARCHAR2(50 CHAR)
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL
   ) LOCATION ( 'DimDepartmentGroup.csv' )
);

CREATE TABLE ext_dimemployee (
   employeekey                          NUMBER,
   parentemployeekey                    NUMBER,
   employeenationalidalternatekey       VARCHAR2(15 CHAR),
   parentemployeenationalidalternatekey VARCHAR2(15 CHAR),
   salesterritorykey                    NUMBER,
   firstname                            VARCHAR2(50 CHAR) NOT NULL,
   lastname                             VARCHAR2(50 CHAR) NOT NULL,
   middlename                           VARCHAR2(50 CHAR),
   namestyle                            NUMBER(1) NOT NULL,
   title                                VARCHAR2(50 CHAR),
   hiredate                             VARCHAR2(50 CHAR),
   birthdate                            VARCHAR2(50 CHAR),
   loginid                              VARCHAR2(256 CHAR),
   emailaddress                         VARCHAR2(50 CHAR),
   phone                                VARCHAR2(25 CHAR),
   maritalstatus                        VARCHAR2(1 CHAR),
   emergencycontactname                 VARCHAR2(50 CHAR),
   emergencycontactphone                VARCHAR2(25 CHAR),
   salariedflag                         NUMBER(1),
   gender                               VARCHAR2(1 CHAR),
   payfrequency                         NUMBER(3),
   baserate                             NUMBER(19,4),
   vacationhours                        NUMBER(5),
   sickleavehours                       NUMBER(5),
   currentflag                          NUMBER(1) NOT NULL,
   salespersonflag                      NUMBER(1) NOT NULL,
   departmentname                       VARCHAR2(50 CHAR),
   startdate                            VARCHAR2(50 CHAR),
   enddate                              VARCHAR2(50 CHAR),
   status                               VARCHAR2(50 CHAR),
   employeephoto                        BLOB
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL (
         employeekey,
         parentemployeekey,
         employeenationalidalternatekey,
         parentemployeenationalidalternatekey,
         salesterritorykey,
         firstname,
         lastname,
         middlename,
         namestyle,
         title,
         hiredate,
         birthdate,
         loginid,
         emailaddress,
         phone,
         maritalstatus,
         emergencycontactname,
         emergencycontactphone,
         salariedflag,
         gender,
         payfrequency,
         baserate,
         vacationhours,
         sickleavehours,
         currentflag,
         salespersonflag,
         departmentname,
         startdate,
         enddate,
         status,
         employeephoto CHAR ( 1000000 )
      )
   ) LOCATION ( 'DimEmployee.csv' )
);


CREATE TABLE ext_dimgeography (
   geographykey             NUMBER,
   city                     VARCHAR2(30 CHAR),
   stateprovincecode        VARCHAR2(3 CHAR),
   stateprovincename        VARCHAR2(50 CHAR),
   countryregioncode        VARCHAR2(3 CHAR),
   englishcountryregionname VARCHAR2(50 CHAR),
   spanishcountryregionname VARCHAR2(50 CHAR),
   frenchcountryregionname  VARCHAR2(50 CHAR),
   postalcode               VARCHAR2(15 CHAR),
   salesterritorykey        NUMBER,
   ipaddresslocator         VARCHAR2(15 CHAR)
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL
   ) LOCATION ( 'DimGeography.csv' )
);


CREATE TABLE ext_dimorganization (
   organizationkey       NUMBER,
   parentorganizationkey NUMBER,
   percentageofownership VARCHAR2(16 CHAR),
   organizationname      VARCHAR2(50 CHAR),
   currencykey           NUMBER
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL
   ) LOCATION ( 'DimOrganization.csv' )
);


CREATE TABLE ext_dimproduct (
   productkey            NUMBER,
   productalternatekey   VARCHAR2(25 CHAR),
   productsubcategorykey NUMBER,
   weightunitmeasurecode VARCHAR2(3 CHAR),
   sizeunitmeasurecode   VARCHAR2(3 CHAR),
   englishproductname    VARCHAR2(50 CHAR),
   spanishproductname    VARCHAR2(50 CHAR),
   frenchproductname     VARCHAR2(50 CHAR),
   standardcost          NUMBER(19,4),
   finishedgoodsflag     NUMBER(1),
   color                 VARCHAR2(15 CHAR),
   safetystocklevel      NUMBER(5),
   reorderpoint          NUMBER(5),
   listprice             NUMBER(19,4),
   prdsize               VARCHAR2(50 CHAR),
   sizerange             VARCHAR2(50 CHAR),
   weight                NUMBER,
   daystomanufacture     NUMBER,
   productline           VARCHAR2(2 CHAR),
   dealerprice           NUMBER(19,4),
   prdclass              VARCHAR2(2 CHAR),
   prdstyle              VARCHAR2(2 CHAR),
   modelname             VARCHAR2(50 CHAR),
   largephoto            BLOB,
   englishdescription    VARCHAR2(2000 CHAR),
   frenchdescription     VARCHAR2(2000 CHAR),
   chinesedescription    VARCHAR2(2000 CHAR),
   arabicdescription     VARCHAR2(2000 CHAR),
   hebrewdescription     VARCHAR2(2000 CHAR),
   thaidescription       VARCHAR2(2000 CHAR),
   germandescription     VARCHAR2(2000 CHAR),
   japanesedescription   VARCHAR2(2000 CHAR),
   turkishdescription    VARCHAR2(2000 CHAR),
   startdate             TIMESTAMP,
   enddate               TIMESTAMP,
   status                VARCHAR2(7 CHAR)
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL (
         productkey,
         productalternatekey,
         productsubcategorykey,
         weightunitmeasurecode,
         sizeunitmeasurecode,
         englishproductname,
         spanishproductname,
         frenchproductname,
         standardcost,
         finishedgoodsflag,
         color,
         safetystocklevel,
         reorderpoint,
         listprice,
         prdsize,
         sizerange,
         weight,
         daystomanufacture,
         productline,
         dealerprice,
         prdclass,
         prdstyle,
         modelname,
         largephoto CHAR ( 1000000 ),
         englishdescription CHAR ( 2000 ),
         frenchdescription CHAR ( 2000 ),
         chinesedescription CHAR ( 2000 ),
         arabicdescription CHAR ( 2000 ),
         hebrewdescription CHAR ( 2000 ),
         thaidescription CHAR ( 2000 ),
         germandescription CHAR ( 2000 ),
         japanesedescription CHAR ( 2000 ),
         turkishdescription CHAR ( 2000 ),
         startdate CHAR ( 50 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3",
         enddate CHAR ( 50 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3",
         status
      )
   ) LOCATION ( 'DimProduct.csv' )
);

CREATE TABLE ext_dimproductcategory (
   productcategorykey          NUMBER,
   productcategoryalternatekey NUMBER,
   englishproductcategoryname  VARCHAR2(50 CHAR) NOT NULL,
   spanishproductcategoryname  VARCHAR2(50 CHAR) NOT NULL,
   frenchproductcategoryname   VARCHAR2(50 CHAR) NOT NULL
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL
   ) LOCATION ( 'DimProductCategory.csv' )
);


CREATE TABLE ext_dimproductsubcategory (
   productsubcategorykey          NUMBER,
   productsubcategoryalternatekey NUMBER,
   englishproductsubcategoryname  VARCHAR2(50 CHAR) NOT NULL,
   spanishproductsubcategoryname  VARCHAR2(50 CHAR) NOT NULL,
   frenchproductsubcategoryname   VARCHAR2(50 CHAR) NOT NULL,
   productcategorykey             NUMBER
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL
   ) LOCATION ( 'DimProductSubcategory.csv' )
);


CREATE TABLE ext_dimpromotion (
   promotionkey             NUMBER,
   promotionalternatekey    NUMBER,
   englishpromotionname     VARCHAR2(255 CHAR),
   spanishpromotionname     VARCHAR2(255 CHAR),
   frenchpromotionname      VARCHAR2(255 CHAR),
   discountpct              NUMBER,
   englishpromotiontype     VARCHAR2(50 CHAR),
   spanishpromotiontype     VARCHAR2(50 CHAR),
   frenchpromotiontype      VARCHAR2(50 CHAR),
   englishpromotioncategory VARCHAR2(50 CHAR),
   spanishpromotioncategory VARCHAR2(50 CHAR),
   frenchpromotioncategory  VARCHAR2(50 CHAR),
   startdate                TIMESTAMP NOT NULL,
   enddate                  TIMESTAMP,
   minqty                   NUMBER,
   maxqty                   NUMBER
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL (
         promotionkey,
         promotionalternatekey,
         englishpromotionname,
         spanishpromotionname,
         frenchpromotionname,
         discountpct,
         englishpromotiontype,
         spanishpromotiontype,
         frenchpromotiontype,
         englishpromotioncategory,
         spanishpromotioncategory,
         frenchpromotioncategory,
         startdate CHAR ( 23 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3",
         enddate CHAR ( 23 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3",
         minqty,
         maxqty
      )
   ) LOCATION ( 'DimPromotion.csv' )
);

CREATE TABLE ext_dimreseller (
   resellerkey          NUMBER,
   geographykey         NUMBER,
   reselleralternatekey VARCHAR2(15 CHAR),
   phone                VARCHAR2(25 CHAR),
   businesstype         VARCHAR2(20 CHAR) NOT NULL,
   resellername         VARCHAR2(50 CHAR) NOT NULL,
   numberemployees      NUMBER,
   orderfrequency       VARCHAR2(1 CHAR),
   ordermonth           NUMBER(3),
   firstorderyear       NUMBER,
   lastorderyear        NUMBER,
   productline          VARCHAR2(50 CHAR),
   addressline1         VARCHAR2(60 CHAR),
   addressline2         VARCHAR2(60 CHAR),
   annualsales          NUMBER(19,4),
   bankname             VARCHAR2(50 CHAR),
   minpaymenttype       NUMBER(3),
   minpaymentamount     NUMBER(19,4),
   annualrevenue        NUMBER(19,4),
   yearopened           NUMBER
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL
   ) LOCATION ( 'DimReseller.csv' )
);


CREATE TABLE ext_dimsalesreason (
   salesreasonkey          NUMBER,
   salesreasonalternatekey NUMBER NOT NULL,
   salesreasonname         VARCHAR2(50 CHAR) NOT NULL,
   salesreasonreasontype   VARCHAR2(50 CHAR) NOT NULL
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL
   ) LOCATION ( 'DimSalesReason.csv' )
);


CREATE TABLE ext_dimsalesterritory (
   salesterritorykey          NUMBER,
   salesterritoryalternatekey NUMBER,
   salesterritoryregion       VARCHAR2(50 CHAR) NOT NULL,
   salesterritorycountry      VARCHAR2(50 CHAR) NOT NULL,
   salesterritorygroup        VARCHAR2(50 CHAR),
   salesterritoryimage        BLOB
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL (
         salesterritorykey,
         salesterritoryalternatekey,
         salesterritoryregion,
         salesterritorycountry,
         salesterritorygroup,
         salesterritoryimage CHAR ( 1000000 )
      )
   ) LOCATION ( 'DimSalesTerritory.csv' )
);

CREATE TABLE ext_dimscenario (
   scenariokey  NUMBER,
   scenarioname VARCHAR2(50 CHAR)
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL
   ) LOCATION ( 'DimScenario.csv' )
);


CREATE TABLE ext_factadditionalinternationalproductdescription (
   productkey         NUMBER NOT NULL,
   culturename        VARCHAR2(50 CHAR) NOT NULL,
   productdescription CLOB NOT NULL
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL (
         productkey,
         culturename,
         productdescription CHAR ( 1000000 )
      )
   ) LOCATION ( 'FactAdditionalInternationalProductDescription.csv' )
);


CREATE TABLE ext_factcallcenter (
   factcallcenterid    NUMBER,
   datekey             NUMBER NOT NULL,
   wagetype            VARCHAR2(15 CHAR) NOT NULL,
   shift               VARCHAR2(20 CHAR) NOT NULL,
   leveloneoperators   NUMBER(5) NOT NULL,
   leveltwooperators   NUMBER(5) NOT NULL,
   totaloperators      NUMBER(5) NOT NULL,
   calls               NUMBER NOT NULL,
   automaticresponses  NUMBER NOT NULL,
   orders              NUMBER NOT NULL,
   issuesraised        NUMBER(5) NOT NULL,
   averagetimeperissue NUMBER(5) NOT NULL,
   servicegrade        NUMBER NOT NULL,
   loaddate            TIMESTAMP
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL (
         factcallcenterid,
         datekey,
         wagetype,
         shift,
         leveloneoperators,
         leveltwooperators,
         totaloperators,
         calls,
         automaticresponses,
         orders,
         issuesraised,
         averagetimeperissue,
         servicegrade,
         loaddate CHAR ( 23 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3"
      )
   ) LOCATION ( 'FactCallCenter.csv' )
);


CREATE TABLE ext_factcurrencyrate (
   currencykey  NUMBER NOT NULL,
   datekey      NUMBER NOT NULL,
   averagerate  NUMBER NOT NULL,
   endofdayrate NUMBER NOT NULL,
   loaddate     TIMESTAMP
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL (
         currencykey, 
         datekey,     
         averagerate, 
         endofdayrate,
         loaddate CHAR ( 23 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3"
)
   ) LOCATION ( 'FactCurrencyRate.csv' )
);


CREATE TABLE ext_factfinance (
   financekey         NUMBER,
   datekey            NUMBER NOT NULL,
   organizationkey    NUMBER NOT NULL,
   departmentgroupkey NUMBER NOT NULL,
   scenariokey        NUMBER NOT NULL,
   accountkey         NUMBER NOT NULL,
   amount             NUMBER NOT NULL,
   loaddate           TIMESTAMP
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL (
         financekey,
         datekey,
         organizationkey,
         departmentgroupkey,
         scenariokey,
         accountkey,
         amount,
         loaddate CHAR ( 23 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3"
      )
   ) LOCATION ( 'FactFinance.csv' )
);


CREATE TABLE ext_factinternetsales (
   productkey            NUMBER NOT NULL,
   orderdatekey          NUMBER NOT NULL,
   duedatekey            NUMBER NOT NULL,
   shipdatekey           NUMBER NOT NULL,
   customerkey           NUMBER NOT NULL,
   promotionkey          NUMBER NOT NULL,
   currencykey           NUMBER NOT NULL,
   salesterritorykey     NUMBER NOT NULL,
   salesordernumber      VARCHAR2(20 CHAR) NOT NULL,
   salesorderlinenumber  NUMBER(3) NOT NULL,
   revisionnumber        NUMBER(3) NOT NULL,
   orderquantity         NUMBER(5) NOT NULL,
   unitprice             NUMBER(19,4) NOT NULL,
   extendedamount        NUMBER(19,4) NOT NULL,
   unitpricediscountpct  NUMBER NOT NULL,
   discountamount        NUMBER NOT NULL,
   productstandardcost   NUMBER(19,4) NOT NULL,
   totalproductcost      NUMBER(19,4) NOT NULL,
   salesamount           NUMBER(19,4) NOT NULL,
   taxamt                NUMBER(19,4) NOT NULL,
   freight               NUMBER(19,4) NOT NULL,
   carriertrackingnumber VARCHAR2(25 CHAR),
   customerponumber      VARCHAR2(25 CHAR),
   orderdate             TIMESTAMP,
   duedate               TIMESTAMP,
   shipdate              TIMESTAMP
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL (
         productkey,
         orderdatekey,
         duedatekey,
         shipdatekey,
         customerkey,
         promotionkey,
         currencykey,
         salesterritorykey,
         salesordernumber,
         salesorderlinenumber,
         revisionnumber,
         orderquantity,
         unitprice,
         extendedamount,
         unitpricediscountpct,
         discountamount,
         productstandardcost,
         totalproductcost,
         salesamount,
         taxamt,
         freight,
         carriertrackingnumber,
         customerponumber,
         orderdate CHAR ( 23 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3",
         duedate CHAR ( 23 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3",
         shipdate CHAR ( 23 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3"
      )
   ) LOCATION ( 'FactInternetSales.csv' )
);


CREATE TABLE ext_factinternetsalesreason (
   salesordernumber     VARCHAR2(20 CHAR) NOT NULL,
   salesorderlinenumber NUMBER(3) NOT NULL,
   salesreasonkey       NUMBER NOT NULL
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL
   ) LOCATION ( 'FactInternetSalesReason.csv' )
);


CREATE TABLE ext_factproductinventory (
   productkey   NUMBER NOT NULL,
   datekey      NUMBER NOT NULL,
   movementdate VARCHAR2(50 CHAR) NOT NULL,
   unitcost     NUMBER(19,4) NOT NULL,
   unitsin      NUMBER NOT NULL,
   unitsout     NUMBER NOT NULL,
   unitsbalance NUMBER NOT NULL
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL
   ) LOCATION ( 'FactProductInventory.csv' )
);


CREATE TABLE ext_factresellersales (
   productkey            NUMBER NOT NULL,
   orderdatekey          NUMBER NOT NULL,
   duedatekey            NUMBER NOT NULL,
   shipdatekey           NUMBER NOT NULL,
   resellerkey           NUMBER NOT NULL,
   employeekey           NUMBER NOT NULL,
   promotionkey          NUMBER NOT NULL,
   currencykey           NUMBER NOT NULL,
   salesterritorykey     NUMBER NOT NULL,
   salesordernumber      VARCHAR2(20 CHAR) NOT NULL,
   salesorderlinenumber  NUMBER(3) NOT NULL,
   revisionnumber        NUMBER(3),
   orderquantity         NUMBER(5),
   unitprice             NUMBER(19,4),
   extendedamount        NUMBER(19,4),
   unitpricediscountpct  NUMBER,
   discountamount        NUMBER,
   productstandardcost   NUMBER(19,4),
   totalproductcost      NUMBER(19,4),
   salesamount           NUMBER(19,4),
   taxamt                NUMBER(19,4),
   freight               NUMBER(19,4),
   carriertrackingnumber VARCHAR2(25 CHAR),
   customerponumber      VARCHAR2(25 CHAR),
   orderdate             TIMESTAMP,
   duedate               TIMESTAMP,
   shipdate              TIMESTAMP
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader 
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8 
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL (
         productkey,
         orderdatekey,
         duedatekey,
         shipdatekey,
         resellerkey,
         employeekey,
         promotionkey,
         currencykey,
         salesterritorykey,
         salesordernumber,
         salesorderlinenumber,
         revisionnumber,
         orderquantity,
         unitprice,
         extendedamount,
         unitpricediscountpct,
         discountamount,
         productstandardcost,
         totalproductcost,
         salesamount,
         taxamt,
         freight,
         carriertrackingnumber,
         customerponumber,
         orderdate CHAR ( 23 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3",
         duedate CHAR ( 23 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3",
         shipdate CHAR ( 23 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3"
      )
   ) LOCATION ( 'FactResellerSales.csv' )
);


CREATE TABLE ext_factsalesquota (
   salesquotakey    NUMBER,
   employeekey      NUMBER NOT NULL,
   datekey          NUMBER NOT NULL,
   calendaryear     NUMBER(5) NOT NULL,
   calendarquarter  NUMBER(3) NOT NULL,
   salesamountquota NUMBER(19,4) NOT NULL,
   loaddate         TIMESTAMP
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL (
            salesquotakey,
            employeekey,
            datekey,
            calendaryear,
            calendarquarter,
            salesamountquota,
            loaddate CHAR ( 23 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3"
      )
   ) LOCATION ( 'FactSalesQuota.csv' )
);


CREATE TABLE ext_factsurveyresponse (
   surveyresponsekey             NUMBER,
   datekey                       NUMBER NOT NULL,
   customerkey                   NUMBER NOT NULL,
   productcategorykey            NUMBER NOT NULL,
   englishproductcategoryname    VARCHAR2(50 CHAR) NOT NULL,
   productsubcategorykey         NUMBER NOT NULL,
   englishproductsubcategoryname VARCHAR2(50 CHAR) NOT NULL,
   loaddate                      TIMESTAMP
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL (
         surveyresponsekey,
         datekey,
         customerkey,
         productcategorykey,
         englishproductcategoryname,
         productsubcategorykey,
         englishproductsubcategoryname,
         loaddate CHAR ( 23 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3"
      )
   ) LOCATION ( 'FactSurveyResponse.csv' )
);


CREATE TABLE ext_newfactcurrencyrate (
   averagerate  BINARY_FLOAT,
   currencyid   VARCHAR2(3 CHAR),
   currencydate VARCHAR2(50 CHAR),
   endofdayrate BINARY_FLOAT,
   currencykey  NUMBER,
   datekey      NUMBER
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL
   ) LOCATION ( 'NewFactCurrencyRate.csv' )
);


CREATE TABLE ext_prospectivebuyer (
   prospectivebuyerkey  NUMBER,
   prospectalternatekey VARCHAR2(15 CHAR),
   firstname            VARCHAR2(50 CHAR),
   middlename           VARCHAR2(50 CHAR),
   lastname             VARCHAR2(50 CHAR),
   birthdate            TIMESTAMP,
   maritalstatus        VARCHAR2(1 CHAR),
   gender               VARCHAR2(1 CHAR),
   emailaddress         VARCHAR2(50 CHAR),
   yearlyincome         NUMBER(19,4),
   totalchildren        NUMBER(3),
   numberchildrenathome NUMBER(3),
   education            VARCHAR2(40 CHAR),
   occupation           VARCHAR2(100 CHAR),
   houseownerflag       VARCHAR2(1 CHAR),
   numbercarsowned      NUMBER(3),
   addressline1         VARCHAR2(120 CHAR),
   addressline2         VARCHAR2(120 CHAR),
   city                 VARCHAR2(30 CHAR),
   stateprovincecode    VARCHAR2(3 CHAR),
   postalcode           VARCHAR2(15 CHAR),
   phone                VARCHAR2(20 CHAR),
   salutation           VARCHAR2(8 CHAR),
   unknown              NUMBER
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' MISSING FIELD VALUES ARE NULL (
         prospectivebuyerkey,
         prospectalternatekey,
         firstname,
         middlename,
         lastname,
         birthdate CHAR ( 23 ) DATE_FORMAT TIMESTAMP MASK "YYYY-MM-DD HH24:MI:SS.FF3",
         maritalstatus,
         gender,
         emailaddress,
         yearlyincome,
         totalchildren,
         numberchildrenathome,
         education,
         occupation,
         houseownerflag,
         numbercarsowned,
         addressline1,
         addressline2,
         city,
         stateprovincecode,
         postalcode,
         phone,
         salutation,
         unknown
      )
   ) LOCATION ( 'ProspectiveBuyer.csv' )
);

CREATE TABLE ext_sysdiagrams (
   name         VARCHAR2(128 CHAR) NOT NULL,
   principal_id NUMBER NOT NULL,
   diagram_id   NUMBER,
   version      NUMBER,
   definition   CLOB
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
   DEFAULT DIRECTORY advworks_dir ACCESS PARAMETERS ( RECORDS DELIMITED BY NEWLINE CHARACTERSET AL32UTF8
      FIELDS TERMINATED BY '|' (
         name,
         principal_id,
         diagram_id,
         version,
         definition CHAR ( 1000000 )
      )
   ) LOCATION ( 'sysdiagrams.csv' )
);
EOF


echo "*** Populate tables"
sqlplus advworks/advworks@localhost:1521/$ORACLE_PDB << EOF
ALTER SESSION SET nls_date_format='YYYY-MM-DD';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS.FF';    


INSERT /*+ APPEND */ INTO dimaccount
   SELECT *
     FROM ext_dimaccount;
INSERT /*+ APPEND */ INTO dimcurrency
   SELECT *
     FROM ext_dimcurrency;
INSERT /*+ APPEND */ INTO dimcustomer
   SELECT *
     FROM ext_dimcustomer;
INSERT /*+ APPEND */ INTO dimdate
   SELECT *
     FROM ext_dimdate;
INSERT /*+ APPEND */ INTO dimdepartmentgroup
   SELECT *
     FROM ext_dimdepartmentgroup;
INSERT /*+ APPEND */ INTO dimemployee
   SELECT *
     FROM ext_dimemployee;
INSERT /*+ APPEND */ INTO dimgeography
   SELECT *
     FROM ext_dimgeography;
INSERT /*+ APPEND */ INTO dimorganization
   SELECT *
     FROM ext_dimorganization;
INSERT /*+ APPEND */ INTO dimproduct
   SELECT *
     FROM ext_dimproduct;
INSERT /*+ APPEND */ INTO dimproductcategory
   SELECT *
     FROM ext_dimproductcategory;
INSERT /*+ APPEND */ INTO dimproductsubcategory
   SELECT *
     FROM ext_dimproductsubcategory;
INSERT /*+ APPEND */ INTO dimpromotion
   SELECT *
     FROM ext_dimpromotion;
INSERT /*+ APPEND */ INTO dimreseller
   SELECT *
     FROM ext_dimreseller;
INSERT /*+ APPEND */ INTO dimsalesreason
   SELECT *
     FROM ext_dimsalesreason;
INSERT /*+ APPEND */ INTO dimsalesterritory
   SELECT *
     FROM ext_dimsalesterritory;
INSERT /*+ APPEND */ INTO dimscenario
   SELECT *
     FROM ext_dimscenario;
INSERT /*+ APPEND */ INTO factadditionalinternationalproductdescription
   SELECT *
     FROM ext_factadditionalinternationalproductdescription;
INSERT /*+ APPEND */ INTO factcallcenter
   SELECT *
     FROM ext_factcallcenter;
INSERT /*+ APPEND */ INTO factcurrencyrate
   SELECT *
     FROM ext_factcurrencyrate;
INSERT /*+ APPEND */ INTO factfinance
   SELECT *
     FROM ext_factfinance;
INSERT /*+ APPEND */ INTO factinternetsales
   SELECT *
     FROM ext_factinternetsales;
INSERT /*+ APPEND */ INTO factinternetsalesreason
   SELECT *
     FROM ext_factinternetsalesreason;
INSERT /*+ APPEND */ INTO factproductinventory
   SELECT *
     FROM ext_factproductinventory;
INSERT /*+ APPEND */ INTO factresellersales
   SELECT *
     FROM ext_factresellersales;
INSERT /*+ APPEND */ INTO factsalesquota
   SELECT *
     FROM ext_factsalesquota;
INSERT /*+ APPEND */ INTO factsurveyresponse
   SELECT *
     FROM ext_factsurveyresponse;
INSERT /*+ APPEND */ INTO newfactcurrencyrate
   SELECT *
     FROM ext_newfactcurrencyrate;
INSERT /*+ APPEND */ INTO prospectivebuyer
   SELECT *
     FROM ext_prospectivebuyer;
INSERT /*+ APPEND */ INTO sysdiagrams
   SELECT *
     FROM ext_sysdiagrams;
EOF


echo "*** Add constraints"
sqlplus advworks/advworks@localhost:1521/$ORACLE_PDB << EOF
-- ========================================================
-- Create Foreign Key Constraints
-- ========================================================

ALTER TABLE dimaccount
   ADD CONSTRAINT fk_dimaccount_dimaccount FOREIGN KEY ( parentaccountkey )
      REFERENCES dimaccount ( accountkey );

ALTER TABLE dimcustomer
   ADD CONSTRAINT fk_dimcustomer_dimgeography FOREIGN KEY ( geographykey )
      REFERENCES dimgeography ( geographykey );

ALTER TABLE dimdepartmentgroup
   ADD CONSTRAINT fk_dimdepartmentgroup_dimdepartmentgroup FOREIGN KEY ( parentdepartmentgroupkey )
      REFERENCES dimdepartmentgroup ( departmentgroupkey );

ALTER TABLE dimemployee
   ADD CONSTRAINT fk_dimemployee_dimsalesterritory FOREIGN KEY ( salesterritorykey )
      REFERENCES dimsalesterritory ( salesterritorykey );

ALTER TABLE dimemployee
   ADD CONSTRAINT fk_dimemployee_dimemployee FOREIGN KEY ( parentemployeekey )
      REFERENCES dimemployee ( employeekey );

ALTER TABLE dimgeography
   ADD CONSTRAINT fk_dimgeography_dimsalesterritory FOREIGN KEY ( salesterritorykey )
      REFERENCES dimsalesterritory ( salesterritorykey );

ALTER TABLE dimorganization
   ADD CONSTRAINT fk_dimorganization_dimcurrency FOREIGN KEY ( currencykey )
      REFERENCES dimcurrency ( currencykey );

ALTER TABLE dimorganization
   ADD CONSTRAINT fk_dimorganization_dimorganization FOREIGN KEY ( parentorganizationkey )
      REFERENCES dimorganization ( organizationkey );

ALTER TABLE dimproduct
   ADD CONSTRAINT fk_dimproduct_dimproductsubcategory FOREIGN KEY ( productsubcategorykey )
      REFERENCES dimproductsubcategory ( productsubcategorykey );

ALTER TABLE dimproductsubcategory
   ADD CONSTRAINT fk_dimproductsubcategory_dimproductcategory FOREIGN KEY ( productcategorykey )
      REFERENCES dimproductcategory ( productcategorykey );

ALTER TABLE dimreseller
   ADD CONSTRAINT fk_dimreseller_dimgeography FOREIGN KEY ( geographykey )
      REFERENCES dimgeography ( geographykey );

ALTER TABLE factcallcenter
   ADD CONSTRAINT fk_factcallcenter_dimdate FOREIGN KEY ( datekey )
      REFERENCES dimdate ( datekey );

ALTER TABLE factcurrencyrate
   ADD CONSTRAINT fk_factcurrencyrate_dimdate FOREIGN KEY ( datekey )
      REFERENCES dimdate ( datekey );

ALTER TABLE factcurrencyrate
   ADD CONSTRAINT fk_factcurrencyrate_dimcurrency FOREIGN KEY ( currencykey )
      REFERENCES dimcurrency ( currencykey );

ALTER TABLE factfinance
   ADD CONSTRAINT fk_factfinance_dimscenario FOREIGN KEY ( scenariokey )
      REFERENCES dimscenario ( scenariokey );

ALTER TABLE factfinance
   ADD CONSTRAINT fk_factfinance_dimorganization FOREIGN KEY ( organizationkey )
      REFERENCES dimorganization ( organizationkey );

ALTER TABLE factfinance
   ADD CONSTRAINT fk_factfinance_dimdepartmentgroup FOREIGN KEY ( departmentgroupkey )
      REFERENCES dimdepartmentgroup ( departmentgroupkey );

ALTER TABLE factfinance
   ADD CONSTRAINT fk_factfinance_dimdate FOREIGN KEY ( datekey )
      REFERENCES dimdate ( datekey );

ALTER TABLE factfinance
   ADD CONSTRAINT fk_factfinance_dimaccount FOREIGN KEY ( accountkey )
      REFERENCES dimaccount ( accountkey );

ALTER TABLE factinternetsales
   ADD CONSTRAINT fk_factinternetsales_dimcurrency FOREIGN KEY ( currencykey )
      REFERENCES dimcurrency ( currencykey );

ALTER TABLE factinternetsales
   ADD CONSTRAINT fk_factinternetsales_dimcustomer FOREIGN KEY ( customerkey )
      REFERENCES dimcustomer ( customerkey );

ALTER TABLE factinternetsales
   ADD CONSTRAINT fk_factinternetsales_dimdate FOREIGN KEY ( orderdatekey )
      REFERENCES dimdate ( datekey );

ALTER TABLE factinternetsales
   ADD CONSTRAINT fk_factinternetsales_dimdate1 FOREIGN KEY ( duedatekey )
      REFERENCES dimdate ( datekey );

ALTER TABLE factinternetsales
   ADD CONSTRAINT fk_factinternetsales_dimdate2 FOREIGN KEY ( shipdatekey )
      REFERENCES dimdate ( datekey );

ALTER TABLE factinternetsales
   ADD CONSTRAINT fk_factinternetsales_dimproduct FOREIGN KEY ( productkey )
      REFERENCES dimproduct ( productkey );

ALTER TABLE factinternetsales
   ADD CONSTRAINT fk_factinternetsales_dimpromotion FOREIGN KEY ( promotionkey )
      REFERENCES dimpromotion ( promotionkey );

ALTER TABLE factinternetsales
   ADD CONSTRAINT fk_factinternetsales_dimsalesterritory FOREIGN KEY ( salesterritorykey )
      REFERENCES dimsalesterritory ( salesterritorykey );

ALTER TABLE factinternetsalesreason
   ADD CONSTRAINT fk_factinternetsalesreason_factinternetsales
      FOREIGN KEY ( salesordernumber,
                    salesorderlinenumber )
         REFERENCES factinternetsales ( salesordernumber,
                                        salesorderlinenumber );

ALTER TABLE factinternetsalesreason
   ADD CONSTRAINT fk_factinternetsalesreason_dimsalesreason FOREIGN KEY ( salesreasonkey )
      REFERENCES dimsalesreason ( salesreasonkey );

ALTER TABLE factproductinventory
   ADD CONSTRAINT fk_factproductinventory_dimdate FOREIGN KEY ( datekey )
      REFERENCES dimdate ( datekey );

ALTER TABLE factproductinventory
   ADD CONSTRAINT fk_factproductinventory_dimproduct FOREIGN KEY ( productkey )
      REFERENCES dimproduct ( productkey );

ALTER TABLE factresellersales
   ADD CONSTRAINT fk_factresellersales_dimcurrency FOREIGN KEY ( currencykey )
      REFERENCES dimcurrency ( currencykey );

ALTER TABLE factresellersales
   ADD CONSTRAINT fk_factresellersales_dimdate FOREIGN KEY ( orderdatekey )
      REFERENCES dimdate ( datekey );

ALTER TABLE factresellersales
   ADD CONSTRAINT fk_factresellersales_dimdate1 FOREIGN KEY ( duedatekey )
      REFERENCES dimdate ( datekey );

ALTER TABLE factresellersales
   ADD CONSTRAINT fk_factresellersales_dimdate2 FOREIGN KEY ( shipdatekey )
      REFERENCES dimdate ( datekey );

ALTER TABLE factresellersales
   ADD CONSTRAINT fk_factresellersales_dimemployee FOREIGN KEY ( employeekey )
      REFERENCES dimemployee ( employeekey );

ALTER TABLE factresellersales
   ADD CONSTRAINT fk_factresellersales_dimproduct FOREIGN KEY ( productkey )
      REFERENCES dimproduct ( productkey );

ALTER TABLE factresellersales
   ADD CONSTRAINT fk_factresellersales_dimpromotion FOREIGN KEY ( promotionkey )
      REFERENCES dimpromotion ( promotionkey );

ALTER TABLE factresellersales
   ADD CONSTRAINT fk_factresellersales_dimreseller FOREIGN KEY ( resellerkey )
      REFERENCES dimreseller ( resellerkey );

ALTER TABLE factresellersales
   ADD CONSTRAINT fk_factresellersales_dimsalesterritory FOREIGN KEY ( salesterritorykey )
      REFERENCES dimsalesterritory ( salesterritorykey );

ALTER TABLE factsalesquota
   ADD CONSTRAINT fk_factsalesquota_dimemployee FOREIGN KEY ( employeekey )
      REFERENCES dimemployee ( employeekey );

ALTER TABLE factsalesquota
   ADD CONSTRAINT fk_factsalesquota_dimdate FOREIGN KEY ( datekey )
      REFERENCES dimdate ( datekey );

ALTER TABLE factsurveyresponse
   ADD CONSTRAINT fk_factsurveyresponse_datekey FOREIGN KEY ( datekey )
      REFERENCES dimdate ( datekey );

ALTER TABLE factsurveyresponse
   ADD CONSTRAINT fk_factsurveyresponse_customerkey FOREIGN KEY ( customerkey )
      REFERENCES dimcustomer ( customerkey );

-- ========================================================
-- Create Views
-- ========================================================

pro    *** Creating Table Views ***

CREATE OR REPLACE VIEW vdmprep AS
   SELECT pc.englishproductcategoryname,
          nvl(
             p.modelname,
             p.englishproductname
          ) AS model,
          c.customerkey,
          s.salesterritorygroup AS region,
          CASE
             WHEN EXTRACT(MONTH FROM trunc(sysdate)) < EXTRACT(MONTH FROM c.birthdate) THEN
                EXTRACT(YEAR FROM trunc(sysdate)) - EXTRACT(YEAR FROM c.birthdate) - 1
             WHEN EXTRACT(MONTH FROM trunc(sysdate)) = EXTRACT(MONTH FROM c.birthdate)
                AND EXTRACT(DAY FROM trunc(sysdate)) < EXTRACT(DAY FROM c.birthdate) THEN
                EXTRACT(YEAR FROM trunc(sysdate)) - EXTRACT(YEAR FROM c.birthdate) - 1
             ELSE
                EXTRACT(YEAR FROM trunc(sysdate)) - EXTRACT(YEAR FROM c.birthdate)
          END AS age,
          CASE
             WHEN c.yearlyincome < 40000 THEN
                'Low'
             WHEN c.yearlyincome > 60000 THEN
                'High'
             ELSE
                'Moderate'
          END AS incomegroup,
          d.calendaryear,
          d.fiscalyear,
          d.monthnumberofyear AS month,
          f.salesordernumber AS ordernumber,
          f.salesorderlinenumber AS linenumber,
          f.orderquantity AS quantity,
          f.extendedamount AS amount
     FROM factinternetsales f
    INNER JOIN dimdate d
   ON f.orderdatekey = d.datekey
    INNER JOIN dimproduct p
   ON f.productkey = p.productkey
    INNER JOIN dimproductsubcategory psc
   ON p.productsubcategorykey = psc.productsubcategorykey
    INNER JOIN dimproductcategory pc
   ON psc.productcategorykey = pc.productcategorykey
    INNER JOIN dimcustomer c
   ON f.customerkey = c.customerkey
    INNER JOIN dimgeography g
   ON c.geographykey = g.geographykey
    INNER JOIN dimsalesterritory s
   ON g.salesterritorykey = s.salesterritorykey;

--CREATE OR REPLACE VIEW vTimeSeries AS
--    SELECT
--        CASE ModelRegion_base
--            WHEN 'Mountain-100' THEN 'M200'
--            WHEN 'Road-150' THEN 'R250'
--            WHEN 'Road-650' THEN 'R750'
--            WHEN 'Touring-1000' THEN 'T1000'
--            ELSE SUBSTR(ModelRegion_base, 1, 1) || SUBSTR(ModelRegion_base, -3)
--        END || ' ' || Region AS ModelRegion
--        ,(EXTRACT(YEAR FROM TRUNC(SYSDATE)) * 100) + Month AS TimeIndex
--        ,SUM(Quantity) AS Quantity
--        ,SUM(Amount) AS Amount
--		,CalendarYear
--		,Month
--		,udfBuildISO8601Date(CalendarYear, Month, 25) AS ReportingDate
--    FROM (
--        SELECT * FROM vDMPrep
--        WHERE Model IN ('Mountain-100', 'Mountain-200', 'Road-150', 'Road-250',
--            'Road-650', 'Road-750', 'Touring-1000')
--    )
--    GROUP BY
--        CASE Model
--            WHEN 'Mountain-100' THEN 'M200'
--            WHEN 'Road-150' THEN 'R250'
--            WHEN 'Road-650' THEN 'R750'
--            WHEN 'Touring-1000' THEN 'T1000'
--            ELSE SUBSTR(Model, 1, 1) || SUBSTR(Model, -3)
--        END || ' ' || Region
--        ,(EXTRACT(YEAR FROM TRUNC(SYSDATE)) * 100) + Month
--		,CalendarYear
--		,Month
--		,udfBuildISO8601Date(CalendarYear, Month, 25);
--
CREATE OR REPLACE VIEW vtargetmail AS
   SELECT c.customerkey,
          c.geographykey,
          c.customeralternatekey,
          c.title,
          c.firstname,
          c.middlename,
          c.lastname,
          c.namestyle,
          c.birthdate,
          c.maritalstatus,
          c.suffix,
          c.gender,
          c.emailaddress,
          c.yearlyincome,
          c.totalchildren,
          c.numberchildrenathome,
          c.englisheducation,
          c.spanisheducation,
          c.frencheducation,
          c.englishoccupation,
          c.spanishoccupation,
          c.frenchoccupation,
          c.houseownerflag,
          c.numbercarsowned,
          c.addressline1,
          c.addressline2,
          c.phone,
          c.datefirstpurchase,
          c.commutedistance,
          x.region,
          x.age,
          CASE
             WHEN x.bikes = 0 THEN
                0
             ELSE
                1
          END AS bikebuyer
     FROM dimcustomer c
    INNER JOIN (
      SELECT customerkey,
             region,
             age,
             SUM(
                CASE
                   WHEN englishproductcategoryname = 'Bikes' THEN
                      1
                   ELSE
                      0
                END
             ) AS bikes
        FROM vdmprep
       GROUP BY customerkey,
                region,
                age
   ) x
   ON c.customerkey = x.customerkey;

CREATE OR REPLACE VIEW vassocseqorders AS
   SELECT DISTINCT ordernumber,
                   customerkey,
                   region,
                   incomegroup
     FROM vdmprep
    WHERE fiscalyear = 2013;

CREATE OR REPLACE VIEW vassocseqlineitems AS
   SELECT ordernumber,
          linenumber,
          model
     FROM vdmprep
    WHERE fiscalyear = 2013;
EOF

