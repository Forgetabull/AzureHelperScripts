#!/bin/bash
echo "---------------------------------------------------------------------------"
echo "az_createAZStorageShareIfNotExist.sh [$1] [$2] [$3]"
echo "---------------------------------------------------------------------------"

happyresult='{ "exists": true }'; 

existingdir=`az storage share exists --account-name $2 --name $1 --account-key $3
existingdir=`echo $existingdir`;

if [ "$existingdir" == "$happyresult" ]
then 
	echo "Already Exists"; 
else 
	echo "Not Found, Creating." 
	az storage share create --account-name $2 --name $1 --account-key $3
fi

echo "---------------------------------------------------------------------------"
echo "Done."
echo "---------------------------------------------------------------------------"

