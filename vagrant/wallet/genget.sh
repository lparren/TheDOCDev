#!/bin/bash
 
########################## Fill these in with your values ##########################
#OCID of the tenancy calls are being made in to
tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaa2umitzwlms66isnhtirz6r52bogkgtzzgvdw7dc7mlu5ma7rkn6a"
 
# OCID of the user making the rest call
user_ocid="ocid1.tenancy.oc1..aaaaaaaa2umitzwlms66isnhtirz6r52bogkgtzzgvdw7dc7mlu5ma7rkn6a"
 
# path to the private PEM format key for this user
privateKeyPath="/drives/d/localdata/github/TheDOCDev/vagrant/wallet/DelphyAdmin.pem"
 
# fingerprint of the private key for this user
fingerprint="95:ad:79:cc:90:2d:d8:21:7d:5d:90:7c:68:a9:eb:9f"
 
# The REST api you want to call, with any required paramters.
rest_api="/20181201/functions/ocid1.fnfunc.oc1.eu-frankfurt-1.aaaaaaaalv4p4t7anznbpk7spueyx2glcpoqngaior3okszjzdp7eszz2c4a/actions/invoke"
 
# The host you want to make the call against
host="36enu4jw5vq.eu-frankfurt-1.functions.oci.oraclecloud.com"
####################################################################################
 
 
date=`date -u "+%a, %d %h %Y %H:%M:%S GMT"`
date_header="date: $date"
host_header="host: $host"
request_target="(request-target): get $rest_api"
# note the order of items. The order in the signing_string matches the order in the headers
signing_string="$date_header\n$request_target\n$host_header"
headers="date (request-target) host"
 
 
echo "====================================================================================================="
printf '%b' "signing string is $signing_string \n"
signature=`printf '%b' "$signing_string" | openssl dgst -sha256 -sign $privateKeyPath | openssl enc -e -base64 | tr -d '\n'`
printf '%b' "Signed Request is  \n$signature\n"
 
echo "====================================================================================================="
set -x
#curl -v -X GET -sS https://$host$rest_api -H "date: $date" -H "Authorization: Signature version=\"1\",keyId=\"$tenancy_ocid/$user_ocid/$fingerprint\",algorithm=\"rsa-sha256\",headers=\"$headers\",signature=\"$signature\""
