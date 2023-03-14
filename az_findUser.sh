#!/bin/bash
# Fetchs all the invited users and creates corresponding local users in azure ad.

# ./az_findUser.sh PROD username

echo "---------------------------------------------------------------------------"
echo "$0 [$1] [$2]"
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

url="https://graph.microsoft.com/beta/users"

nextLink=`echo $url`
echo "Data" > $0.out
until [[ $nextLink == null* ]]
do
    userRawData=`az rest --method GET --uri $nextLink --headers 'Content-Type=application/json'`
echo $userRawData >> $0.out
    userMails=`echo $userRawData | jq '.value[] | {userId: .id, userDisplayName: .displayName, signInEmail : .identities[].issuerAssignedId, creationType: (.creationType // .identities[].issuer)} + {emails: ([(.mail | select(. != null)), .otherMails[]]) | .[:2]} | {userId, userPrincipalName, userDisplayName, creationType, signInEmail} + {primaryEmail: .emails[:1] | join("")} + {secondaryEmail: .emails[1:2] | join("")}'`

    if [ -z "$2" ]
    then
      echo $userMails | jq -r '[.[]] | @csv' | grep -v "\"$1.onmicrosoft.com\""
    else
      echo $userMails | jq -r '[.[]] | @csv' | grep $2 | grep -v "\"$1.onmicrosoft.com\""
    fi

    # Fetch the next link (if there is one)
    nextLink=`echo $userRawData | jq '.["@odata.nextLink"]' | sed 's/"//g' | sed 's/'\''/"/g'`
done 

echo " "
echo "---------------------------------------------------------------------------"
echo "Done"
echo "---------------------------------------------------------------------------"
