#!/bin/bash

# Variables
NAMESPACE="monitoring"
RELEASE_NAME="kube-prom-stack"
CHART_REPO="https://prometheus-community.github.io/helm-charts"
CHART_NAME="kube-prometheus-stack"
CHART_VERSION="56.6.1" # Optional: specific chart version

# Step 1: Add Helm repo and update
helm repo add prometheus-community $CHART_REPO
helm repo update

# Step 2: Create namespace if it doesn't exist
kubectl get ns $NAMESPACE >/dev/null 2>&1 || kubectl create ns $NAMESPACE

# Step 3: Install kube-prometheus-stack via Helm
helm install $RELEASE_NAME prometheus-community/$CHART_NAME \
  --namespace $NAMESPACE \
  --version $CHART_VERSION \
  --set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false \
  --set grafana.service.type=LoadBalancer

# Wait for resources to be ready
echo "Waiting for pods in '$NAMESPACE' namespace to become ready..."
kubectl wait --for=condition=Available deployment -l app.kubernetes.io/instance=$RELEASE_NAME -n $NAMESPACE --timeout=300s

echo "✅ Kube Prometheus Stack has been installed successfully."
