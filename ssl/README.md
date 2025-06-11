mkdir tls-cert && cd tls-cert

# Clave privada
openssl genrsa -out tls.key 2048

# Certificado autofirmado
openssl req -new -x509 -key tls.key -out tls.crt -days 365 \
  -subj "/CN=demo.local"

# Crear secret TLS para Kubernetes
kubectl create secret tls demo-tls --cert=tls.crt --key=tls.key

az aks approuting enable --resource-group rg-app-ventas-02 --name aks-ventas-02

kubectl apply -f bundle.yaml

kubectl apply -f ingress.yaml


export INGRESS_IP=4.156.71.104

echo "$INGRESS_IP demo.local" | sudo tee -a /etc/hosts

curl -k https://demo.local