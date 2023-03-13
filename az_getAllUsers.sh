#!/bin/bash
echo "-------------------------------------------------------------"
echo "Running: [$0] [$1]"
echo "-------------------------------------------------------------"

#Retrieve the list of users from Azure that have been created in the past day.
#Save the data as a csv


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

rm $0.csv

url="https://graph.microsoft.com/beta/users"

nextLink=`echo $url`

echo "Fetch the list of invited users..."

echo "DisplayName,GivenName,Surname,Mail,OtherEmails,CreationType,CreatedDateTime,AccountEnabled\n"> $0.csv

until [[ $nextLink == null* ]]
do
    json=`az rest --method GET --uri $nextLink --headers 'Content-Type=application/json' --subscription $subscription `

    #echo $json >> $0.raw.csv

    # Fetch all the invited users and save them to a csv
    echo $json | jq '.value |=sort_by(.createdDateTime) |.value |reverse | .[] | {displayName : .displayName, givenName: .givenName, surname: .surname, mail: .mail, otherMails: .otherMails, creationType: (.creationType // .identities[].issuer), createdDateTime: .createdDateTime, accountEnabled: .accountEnabled} | "\(.displayName)#\(.givenName)#\(.surname)#\(.mail)#\(.otherMails)#\(.creationType)#\(.createdDateTime)#\(.accountEnabled)"' | sed 's/,/ /g' | sed 's/#/,/g' | sed 's/"//g' | sed 's/'\''/"/g' | sed 's/\\//g' | sed 's/\[//g' | sed 's/\]//g' | grep -v "$b2cTenancy.onmicrosoft.com"  >> $0.csv

    # Fetch the next link (if there is one)
    nextLink=`echo $json | jq '.["@odata.nextLink"]' | sed 's/"//g' | sed 's/'\''/"/g'`
done 


