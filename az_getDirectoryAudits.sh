#!/bin/bash

echo "[$0] ---------------------------------------------"
echo "[$0] [$1]"
echo "[$0] ---------------------------------------------"

b2cTenancy="$1"

subscription="none"
case $b2cTenancy in
	DEV)
		subscription="<subscription guid here>"
		;;

	TEST)
		subscription="<subscription guid here>"
		;;

    PROD)
		subscription="<subscription guid here>"
		;;

esac

az login  --allow-no-subscriptions  --username <azureusername> --password <azurepassword> --tenant $b2cTenancy.onmicrosoft.com --output none 

url="https://graph.microsoft.com/beta/auditLogs/directoryAudits"

nextLink=`echo $url`

dt=$(date '+%Y%m%d%H%M%S');

jsonFileName="$0.$dt.out"

echo "[$0] Writing to file: [$jsonFileName]"
echo "[$0] "

rm $jsonFileName 2>/dev/null

until [[ $nextLink == null* ]]
do
    userList=`az rest --method GET --uri $nextLink --headers 'Content-Type=application/json' --subscription $subscription `

    # Just save the json for now.
    echo $userList >> $jsonFileName

    # Fetch the next link (if there is one)
    nextLink=`echo $userList | jq '.["@odata.nextLink"]' | sed 's/"//g' | sed 's/'\''/"/g'`

    #if [ -z "$nextLink" ]
    if [ "$nextLink" == "null" ]
    then
       echo "[$0] No more data to fetch..."
    else
       echo "[$0] Fetching more data from $nextLink"
    fi
done 

echo "[$0]  "
echo "[$0] ---------------------------------------------"
echo "[$0] Done. ($jsonFileName)"
echo "[$0] ---------------------------------------------"
