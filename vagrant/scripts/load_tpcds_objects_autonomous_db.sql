begin	
dbms_cloud.copy_data(
    table_name    => 'CATALOG_PAGE',
    schema_name   => 'EDW_TPCDS',
    file_uri_list => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/catalog_page.dat',
    format        =>
            JSON_OBJECT(
                'ignoremissingcolumns' VALUE 'true',
                'removequotes' VALUE 'true',
                'dateformat' VALUE 'YYYY-MM-DD',
                'blankasnull' VALUE 'true'
            )
);
end;

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'CATALOG_PAGE',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/catalog_page.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'CATALOG_RETURNS',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/catalog_returns.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'CATALOG_SALES',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/catalog_sales.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'CUSTOMER',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/customer.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'CUSTOMER_ADDRESS',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/customer_address.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'CUSTOMER_DEMOGRAPHICS',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/customer_demographics.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'DATE_DIM',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/date_dim.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'DBGEN_VERSION',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/dbgen_version.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'HOUSEHOLD_DEMOGRAPHICS',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/household_demographics.dat'
        ,
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'INCOME_BAND',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/income_band.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'INVENTORY',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/inventory.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'ITEM',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/item.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'PROMOTION',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/promotion.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'REASON',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/reason.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'SHIP_MODE',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/ship_mode.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'STORE',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/store.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'STORE_RETURNS',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/store_returns.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'STORE_SALES',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/store_sales.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'TIME_DIM',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/time_dim.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'WAREHOUSE',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/warehouse.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'WEB_PAGE',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/web_page.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'WEB_RETURNS',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/web_returns.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'WEB_SALES',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/web_sales.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/

BEGIN
    dbms_cloud.copy_data(
        table_name      => 'WEB_SITE',
        schema_name     => 'EDW_TPCDS',
        file_uri_list   => 'https://objectstorage.eu-amsterdam-1.oraclecloud.com/n/axr9klrvy8b9/b/TPCDS/o/web_site.dat',
        credential_name => 'BIDEMO_CRED',
        format          =>
                JSON_OBJECT(
                    'ignoremissingcolumns' VALUE 'true',
                    'removequotes' VALUE 'true',
                    'dateformat' VALUE 'YYYY-MM-DD',
                    'blankasnull' VALUE 'true'
                )
    );
END;
/