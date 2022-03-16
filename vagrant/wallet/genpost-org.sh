#!/bin/bash

#[DEFAULT]
#user=ocid1.user.oc1..aaaaaaaagqypzygm53525las7owi3bmywtce4wp6ugz5gprjjokcpoxtheia
#fingerprint=2a:9a:00:41:7b:1a:c2:66:ae:dc:58:bf:99:7b:ae:7e
#tenancy=ocid1.tenancy.oc1..aaaaaaaa2umitzwlms66isnhtirz6r52bogkgtzzgvdw7dc7mlu5ma7rkn6a
#region=eu-frankfurt-1
#key_file=<path to your private keyfile> # TODO

########################## Fill these in with your values ##########################
#OCID of the tenancy calls are being made in to
tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaa2umitzwlms66isnhtirz6r52bogkgtzzgvdw7dc7mlu5ma7rkn6a"
 
# OCID of the user making the rest call
user_ocid="ocid1.user.oc1..aaaaaaaagqypzygm53525las7owi3bmywtce4wp6ugz5gprjjokcpoxtheia"

# path to the private PEM format key for this user
privateKeyPath="/drives/d/localdata/github/TheDOCDev/vagrant/wallet/DelphyAdmin.pem"

# fingerprint of the private key for this user
fingerprint="2a:9a:00:41:7b:1a:c2:66:ae:dc:58:bf:99:7b:ae:7e"

# The REST api you want to call, with any required paramters.
rest_api="/20181201/functions/ocid1.fnfunc.oc1.eu-frankfurt-1.aaaaaaaalv4p4t7anznbpk7spueyx2glcpoqngaior3okszjzdp7eszz2c4a/actions/invoke"
#rest_api="/20181201/functions/ocid1.fnfunc.oc1.eu-frankfurt-1.aaaaaaaawgmrrco2uwxfumkdsgerikmb4i4rwxrbkotebha6urr445czdhtq/actions/invoke"

# The host you want to make the call against
host="36enu4jw5vq.eu-frankfurt-1.functions.oci.oraclecloud.com"

# the json file containing the data you want to POST to the rest endpoint
body="./request.json"
####################################################################################

# Www-Authenticate: Signature headers="date (request-target) host content-length content-type x-content-sha256"

# extra headers required for a POST/PUT request
body_arg=(--data-binary @${body})
content_sha256="$(openssl dgst -binary -sha256 < $body | openssl enc -e -base64)";
content_sha256_header="x-content-sha256: $content_sha256"
content_length="$(wc -c < $body | xargs)";
content_length_header="content-length: $content_length"
#headers="(request-target) date host"
headers="date (request-target) host"
# add on the extra fields required for a POST/PUT
#headers=$headers" x-content-sha256 content-type content-length"
headers=$headers" content-length content-type x-content-sha256"
content_type_header="content-type: application/json";

printf '\n'
printf '%b' "headers is\n$headers\n"
printf '\n'

date=`date -u "+%a, %d %h %Y %H:%M:%S GMT"`
#date="Thu, 03 Jun 2021 09:57:02 GMT" 
date_header="date: $date"
host_header="host: $host"
request_target="(request-target): post $rest_api"

# note the order of items. The order in the signing_string matches the order in the headers, including the extra POST fields
#signing_string="$request_target\n$date_header\n$host_header"
signing_string="$date_header\n$request_target\n$host_header"
# add on the extra fields required for a POST/PUT
#signing_string="$signing_string\n$content_sha256_header\n$content_type_header\n$content_length_header"
signing_string="$signing_string\n$content_length_header\n$content_type_header\n$content_sha256_header"


echo "====================================================================================================="
printf '%b' "signing string is $signing_string \n"
signature=`printf '%b' "$signing_string" | openssl dgst -sha256 -sign $privateKeyPath | openssl enc -e -base64 | tr -d '\n'`
printf '%b' "Signed Request is  \n$signature\n"

echo "====================================================================================================="
set -x
curl -v -X POST --data-binary "@request.json" -sS https://$host$rest_api -H "date: $date" -H "x-content-sha256: $content_sha256" -H "content-type: application/json" -H "content-length: $content_length" -H "Authorization: Signature version=\"1\",keyId=\"$tenancy_ocid/$user_ocid/$fingerprint\",algorithm=\"rsa-sha256\",headers=\"$headers\",signature=\"$signature\""