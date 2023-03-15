#!/bin/bash
echo "-------------------------------------------------------------"
echo "Running: [$0] [$1] [$2]"
echo "-------------------------------------------------------------"

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

appObjectId=`az login  --allow-no-subscriptions  --username <azureusername> --password <azurepassword> --tenant $b2cTenancy.onmicrosoft.com --output none `

az webapp log download --name $1 --resource-group $2


