#!/bin/bash
#echo "-------------------------------------------------------------"
#echo "Running: [$0] [$1] [$2]"
#echo "-------------------------------------------------------------"

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

azLoginLog=`az login  --allow-no-subscriptions  --username <azureusername> --password <azurepassword> --tenant $b2cTenancy.onmicrosoft.com --output none `

echo "Fetching all Azure AD Groups for selected user..."

json=`az ad user get-member-groups --id $2`

echo $json | jq '.[] | {id : .id, displayName : .displayName} | "\(.id)#\(.displayName)"' | sed 's/,/ /g' | sed 's/#/,/g' | sed 's/"//g' | sed 's/'\''/"/g' | sed 's/\\//g' | sed 's/\[//g' | sed 's/\]//g'

