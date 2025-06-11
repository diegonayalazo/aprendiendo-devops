#!/bin/bash

NAMESPACE="kafka"
RELEASE_NAME="strimzi"
CHART_REPO="https://strimzi.io/charts/"
CHART_NAME="strimzi-kafka-operator"
CHART_VERSION="0.46.0"  # Update as needed

# Create namespace if not exists
kubectl get ns $NAMESPACE >/dev/null 2>&1 || kubectl create ns $NAMESPACE

# Add and update Helm repo
helm repo add strimzi $CHART_REPO
helm repo update

# Install Strimzi Operator via Helm
helm install $RELEASE_NAME strimzi/$CHART_NAME \
  --namespace $NAMESPACE \
  --version $CHART_VERSION \
  --set watchAnyNamespace=true \
   --set kafka.metrics.enabled=true \
  --set zookeeper.metrics.enabled=true \
  --set entityOperator.topicOperator.metrics.enabled=true \
  --set entityOperator.userOperator.metrics.enabled=true \
  --set kafkaExporter.enabled=true \
  --set kafkaExporter.metrics.enabled=true

echo "✅ Strimzi Operator installed in namespace '$NAMESPACE'."
