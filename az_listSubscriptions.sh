#!/bin/bash

echo "-------------------------------------------------------------"
echo "Running: [$0]"
echo "-------------------------------------------------------------"

appObjectId=`az login  --allow-no-subscriptions  --username ila-buildserver@interlate.com --password *GCix5m@3^`

az account list | jq -r '.[] | "\(.name), \(.id)"' | sed 's/"//g' | grep -v "N/A(tenant level account)"


