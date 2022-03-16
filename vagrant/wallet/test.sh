#!/bin/bash

privateKeyPath="/drives/d/localdata/github/TheDOCDev/vagrant/wallet/test_private.pem";
date_header="date: Thu, 05 Jan 2014 21:31:40 GMT"
host_header="host: iaas.us-phoenix-1.oraclecloud.com"
request_target="(request-target): get /20160918/instances?availabilityDomain=Pjwf%3A%20PHX-AD-1&compartmentId=ocid1.compartment.oc1..aaaaaaaam3we6vgnherjq5q2idnccdflvjsnog7mlr6rtdb25gilchfeyjxa&displayName=TeamXInstances&volumeId=ocid1.volume.oc1.phx.abyhqljrgvttnlx73nmrwfaux7kcvzfs3s66izvxf2h4lgvyndsdsnoiwr5q"
signing_string="$request_target\n$date_header\n$host_header"
printf '%b' "signing string is $signing_string \n"
printf '%b' "signed request is \n"
printf '%b' "$signing_string" | openssl dgst -sha256 -sign $privateKeyPath | openssl enc -e -base64 | tr -d '\n'
printf "\n\n"