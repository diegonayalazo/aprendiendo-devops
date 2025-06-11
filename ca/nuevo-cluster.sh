#!/bin/bash

# Set variables
RESOURCE_GROUP="rg-app-ventas-01"
AKS_CLUSTER_NAME="aks-ventas-01"
LOCATION="eastus"
NODE_SIZE="standard_d4ds_v4"
NODE_COUNT=1
K8S_VERSION="1.33"  # You can change this based on available versions

az login

# Step 1: Create resource group
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION

# Step 2: Create AKS cluster
az aks create \
  --resource-group $RESOURCE_GROUP \
  --name $AKS_CLUSTER_NAME \
  --node-vm-size $NODE_SIZE \
  --node-count $NODE_COUNT \
  --kubernetes-version $K8S_VERSION \
  --enable-managed-identity \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 5 \
  --generate-ssh-keys

# Step 3: Get AKS credentials for kubectl
az aks get-credentials \
  --resource-group $RESOURCE_GROUP \
  --name $AKS_CLUSTER_NAME

echo "AKS Cluster '$AKS_CLUSTER_NAME' created and kubectl configured."

#az aks update --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME --cluster-autoscaler-profile scan-interval=20s,scale-down-delay-after-add=10m,scale-down-delay-after-failure=1m,scale-down-unneeded-time=5m,scale-down-unready-time=5m,max-graceful-termination-sec=30,skip-nodes-with-local-storage=false,max-empty-bulk-delete=100,max-total-unready-percentage=100,ok-total-unready-count=1000,max-node-provision-time=15m

az aks approuting enable --resource-group rg-app-ventas-01 --name aks-ventas-01