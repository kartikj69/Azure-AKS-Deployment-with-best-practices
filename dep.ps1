#!/bin/bash
$SUBSCRIPTION_ID="5cdb542c-8f18-4259-af9c-d25b30e56e9d"
$RESOURCE_GROUP="Kartik-Jindal-RG"
$LOCATION="centralindia"
$NAME_PREFIX="aks-bp"
$ENVIRONMENT="dev"
$CLUSTER_NAME="${NAME_PREFIX}-${ENVIRONMENT}"
$NODE_RESOURCE_GROUP="${NAME_PREFIX}-${ENVIRONMENT}-nodes"
$DNS_PREFIX="${NAME_PREFIX}-${ENVIRONMENT}"
$VNET_NAME="${NAME_PREFIX}-${ENVIRONMENT}-vnet"
$SUBNET_NAME="${NAME_PREFIX}-${ENVIRONMENT}-subnet"
$KUBERNETES_VERSION="1.29.0"
$NODE_SIZE="Standard_D2s_v3"
$NODE_COUNT=1
$VNET_ADDRESS_PREFIX="10.0.0.0/16"
$SUBNET_ADDRESS_PREFIX="10.0.0.0/24"
$SERVICE_CIDR="10.1.0.0/16"
$DNS_SERVICE_IP="10.1.0.10"
$LOG_ANALYTICS_WORKSPACE="log-${CLUSTER_NAME}"

az account set --subscription $SUBSCRIPTION_ID

az network vnet create --resource-group $RESOURCE_GROUP --name $VNET_NAME --address-prefix $VNET_ADDRESS_PREFIX --location $LOCATION

az network vnet subnet create --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --name $SUBNET_NAME --address-prefix $SUBNET_ADDRESS_PREFIX

$SUBNET_ID=$(az network vnet subnet show --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --name $SUBNET_NAME --query id -o tsv)

Write-Output "Creating Log Analytics workspace..."
az monitor log-analytics workspace create --resource-group $RESOURCE_GROUP --workspace-name $LOG_ANALYTICS_WORKSPACE --location $LOCATION --sku PerGB2018 --retention-time 30 --tags Environment=Development ManagedBy=CLI ClusterName=$CLUSTER_NAME

$LOG_ANALYTICS_WORKSPACE_ID=$(az monitor log-analytics workspace show --resource-group $RESOURCE_GROUP --workspace-name $LOG_ANALYTICS_WORKSPACE --query id -o tsv)

az aks create --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --node-resource-group $NODE_RESOURCE_GROUP --location $LOCATION --kubernetes-version $KUBERNETES_VERSION --node-count $NODE_COUNT --node-vm-size $NODE_SIZE --dns-name-prefix $DNS_PREFIX --enable-managed-identity --network-plugin azure --network-policy azure --vnet-subnet-id $SUBNET_ID --service-cidr $SERVICE_CIDR --dns-service-ip $DNS_SERVICE_IP --enable-private-cluster --enable-cluster-autoscaler --min-count 1 --max-count 3 --zones 1 --node-osdisk-size 50 --max-pods 30 --enable-addons monitoring --workspace-resource-id $LOG_ANALYTICS_WORKSPACE_ID --enable-azure-rbac --enable-aad --enable-defender --yes --tags Environment=Development ManagedBy=CLI ClusterName=$CLUSTER_NAME

az aks enable-addons --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --addons azure-keyvault-secrets-provider --enable-secret-rotation

$PRINCIPAL_ID=$(az aks show --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --query identity.principalId -o tsv)

$VNET_ID=$(az network vnet show --resource-group $RESOURCE_GROUP --name $VNET_NAME --query id -o tsv)

az role assignment create --assignee $PRINCIPAL_ID --role "Network Contributor" --scope $VNET_ID

az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME