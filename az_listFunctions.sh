#!/bin/bash
# Fetchs all the invited users and creates corresponding local users in azure ad.

echo "---------------------------------------------------------------------------"
echo "$0 [$1]"
echo "---------------------------------------------------------------------------"

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

echo "Fetching Azure Functions in [$b2cTenancy]"

#the below call lists the functions available on the subscription
#az functionapp list --verbose --subscription $subscription 

az functionapp deployment source show --name <functionname> --resource-group InterlateResGrp --subscription $subscription 
echo "---------------------------------------------------------------------------"
az functionapp function show --name <functionname> --resource-group InterlateResGrp --subscription $subscription  --function-name <triggername>


echo "---------------------------------------------------------------------------"
