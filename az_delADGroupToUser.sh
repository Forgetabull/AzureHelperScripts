#!/bin/bash
echo "-------------------------------------------------------------"
echo "Running: [$0] [$1] [$2] [$3]"
echo "-------------------------------------------------------------"

# ./az_delADGroupToUser.sh PROD <adgroupname> <userid>

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

echo "Removing $2 from selected user..."

az ad group member remove --group $2 --member-id $3

#./az_listAllADGroupsForUser.sh $1 $3

echo "Done."

