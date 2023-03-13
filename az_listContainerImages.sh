#!/bin/bash

echo "-------------------------------------------------------------"
echo "Running: [$0] [$1] [$2]"
echo "-------------------------------------------------------------"

# Good reference url:  https://stackoverflow.com/questions/59322742/getting-the-latest-image-tag-from-acr-repository

b2cTenancy="$1"
acrname="$2"

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


acSetLog=`az account set --subscription $subscription`
acrLoginLog=`az acr login --name $acrname`

echo '-----------------------------------------------------------------'
echo 'az acr repository list --name $acrname --output table '
echo '-----------------------------------------------------------------'
az acr repository list --name $acrname --output table 
echo '-----------------------------------------------------------------'
echo 'az acr repository show --name $acrname --repository <repositoryName>'
echo '-----------------------------------------------------------------'
az acr repository show --name $acrname --repository <repositoryName>
echo '-----------------------------------------------------------------'
echo 'az acr repository show-tags --name $acrname --repository <repositoryName>'
echo '-----------------------------------------------------------------'
az acr repository show-tags --name $acrname --repository <repositoryName>
echo '-----------------------------------------------------------------'
echo 'az acr repository show-manifests --name $acrname --repository <repositoryName>'
echo '-----------------------------------------------------------------'
az acr repository show-manifests --name $acrname --repository <repositoryName>
