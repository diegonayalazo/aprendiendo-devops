#!/bin/bash

# Namespace and service/release name
NAMESPACE="monitoring"
SERVICE_NAME="kube-prom-stack-grafana"
LOCAL_PORT=3000
REMOTE_PORT=80

kubectl port-forward -n "$NAMESPACE" svc/"$SERVICE_NAME" "$LOCAL_PORT":"$REMOTE_PORT"