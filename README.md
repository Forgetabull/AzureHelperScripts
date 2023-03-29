# AzureHelperScripts

This is a repo of handy Azure scripts that either use azure cli or microsoft graphql in order to perform actions that I had trouble doing otherwise.  These scripts (or variants of) were quite useful for automation.

|Script|Purpose|
|---|---|
|az_addADGroupToUser.sh|Add a group to an azure ad User|
|az_createAZStorageFolderIfNotExist.sh|Creates a storage folder if it doesn't exist in AZ|
|az_createAZStorageShareIfNotExist.sh|Run this one first, if you don't have a share|
|az_delADGroupToUser.sh|Remove an AD group from an azure AD user|
|az_findUser.sh|Find a user in Azure AD via some token|
|az_findUserByEmail.sh|Find a user in Azure AD via email|
|az_getAllUsers.sh|Fetch all users from an azure AD|
|az_getAppServiceLogs.sh|Fetch the appservice logs for a container|
|az_getDirectoryAudits.sh|Fetch the directory audits for an azure AD|
|az_listAllADGroupsForUser.sh|List all the AD groups an Azure AD User is a member of|
|az_listContainerImages.sh|List all container images in an azure container storage (ACS)|
|az_listFunctions.sh|List all azure functions|
|az_listSubscriptions.sh|List the subscriptions|
