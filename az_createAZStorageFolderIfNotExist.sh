#!/bin/bash
echo "---------------------------------------------------------------------------"
echo "az_createAZStorageFolderIfNotExist.sh [$1] [$2] [$3] [$4]"
echo "---------------------------------------------------------------------------"

happyresult='{ "exists": true }'; 

existingdir=`az storage directory exists --account-name $2 --share-name $3 --account-key $4 --name $1`
existingdir=`echo $existingdir`;

if [ "$existingdir" == "$happyresult" ]
then 
	echo "Already Exists"; 
else 
	echo "Not Found, Creating." 
	az storage directory create --account-name $2 --share-name $3 --account-key $4 --name $1
fi

echo "---------------------------------------------------------------------------"
echo "Done."
echo "---------------------------------------------------------------------------"

