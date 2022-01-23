# Setup remote state keyvault

Steps to take for creating a terraform remote state.

First azure storage must be created which needs to be put into a resource group.

az login

## Create resource group

Manually create the resource group

az group create -l westeurope -n terraform-state

## Create storage account

Manually create storage account belonging to the terraform-state group

az storage account create -g terraform-state -l westeurope --name <storageaccountname> --sku Standard_LRS --encryption-services blob

Query the storage account key:

az storage account keys list --resource-group terraform-state --account-name <storageaccountname> --query [0].value -o tsv

ACCOUNT_KEY=$(az storage account keys list --resource-group terraform-state --account-name <storageaccountname> --query '[0].value' -o tsv)
export ARM_ACCESS_KEY=$ACCOUNT_KEY

**ACCOUNTKEY=XYZ**

Create the actual storage container based on key

az storage container create --name terraform-state-container --account-name laurijssenstoragetform --account-key <ACCOUNTKEY>

export ARM_ACCESS_KEY=$(az keyvault secret show --name terraform-backend-key --vault-name myKeyVault --query value -o tsv)


# MONGODB

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4

echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list

sudo apt-get update

sudo apt-get install -y mongodb-org-shell
