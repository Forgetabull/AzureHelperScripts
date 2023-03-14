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

# Log into demo tenancy
azLoginLog=`az login  --allow-no-subscriptions  --username <azureusername> --password <azurepassword> --tenant $b2cTenancy.onmicrosoft.com --output none `

url="https://graph.microsoft.com/beta/users?$select=identities,displayName,mail,externalUserState,externalUserStateChangeDateTime"

nextLink=`echo $url`

echo "Fetch all current display names..."

dt=$(date '+%Y%m%d%H%M');

outFileName="$0.$dt.out"

rm $outFileName

until [[ $nextLink == null* ]]
do
    json=`az rest --method GET --uri $nextLink --headers 'Content-Type=application/json' --subscription $subscription `

    #echo $json  >> $0_LocalAccount.out

    echo $json | jq '.value |=sort_by(.id, .id)| .value | .[] | { ID : .id, assignedID : .identities[].issuerAssignedId, Name : .displayName, GivenName: .givenName, Surname: .surname, userType : .userType, creationType: (.creationType // .identities[].issuer)} | "\(.ID)#\(.assignedID)#\(.GivenName) \(.Surname)#\(.userType)#\(.creationType)"'   | sed 's/,/ /g'| sed 's/#/,/g' | sed 's/"//g' | sed 's/'\''/"/g' | grep -v "$b2cTenancy.onmicrosoft.com" | grep -v "null null" 

    # Fetch the next link (if there is one)
    nextLink=`echo $json | jq '.["@odata.nextLink"]' | sed 's/"//g' | sed 's/'\''/"/g'`
done 

echo "---------------------------------------------------------------------------"
echo "Done. ($outFileName)"
echo "---------------------------------------------------------------------------"
