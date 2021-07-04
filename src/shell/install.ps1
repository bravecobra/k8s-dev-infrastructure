$traefik_helm_version = "9.19.1"
$certmanager_helm_version = "v1.3.1"
$jaeger_helm_version= "2.21.1"
$prometheus_helm_version= "16.0.1"
$loki_helm_version= "2.5.0"
$promtail_helm_version= "3.5.1"
$consul_helm_version= "0.31.1"
$vault_helm_version = "0.13.0"

Copy-Item $env:LOCALAPPDATA\mkcert\rootCA.pem ./src/certs/cacerts.crt
Copy-Item $env:LOCALAPPDATA\mkcert\rootCA-key.pem ./src/certs/cacerts.key
kubectl create secret tls ca-key-pair --namespace=cert-manager --cert=./src/certs/cacerts.crt --key=./src/certs/cacerts.key  --dry-run=client -o yaml > ./src/argocd/argo/cert-manager/crds/cacerts.yaml

helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add traefik https://helm.traefik.io/traefik
helm repo add datalust https://helm.datalust.co
helm repo add fluent https://fluent.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add elastic https://helm.elastic.co
helm repo add identityserver4admin https://bravecobra.github.io/identityserver4.admin-helm/charts/
helm repo add jetstack https://charts.jetstack.io
helm repo update

##Creating namespaces
kubectl create namespace cert-manager
kubectl create namespace traefik
kubectl create namespace consul
kubectl create namespace vault
kubectl create namespace prometheus
kubectl create namespace loki
kubectl create namespace jaeger

## Cert-manager
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.3.1/cert-manager.crds.yaml
helm upgrade --install --wait cert-manager jetstack/cert-manager -n cert-manager --version $certmanager_helm_version --set installCRDs=false

kubectl apply -f ./src/shell/cert-manager/crds/cacerts.yaml
kubectl apply -f ./src/shell/cert-manager/crds/cluster-issuer.yaml
Start-Sleep -Seconds 10

## install traefik as ingress-controller
helm upgrade --install --wait traefik traefik/traefik -n traefik --version $traefik_helm_version -f ./src/shell/traefik/traefik-values.yaml
kubectl apply -f ./src/shell/traefik/crds/

## Consul
helm upgrade --install --wait consul hashicorp/consul -n consul --version $consul_helm_version -f ./src/shell/consul/consul-values.yaml
kubectl apply -f ./src/shell/consul/crds/

## Prometheus
helm upgrade --install --wait prometheus prometheus-community/kube-prometheus-stack -n prometheus --version $prometheus_helm_version -f ./src/shell/prometheus/prometheus-values.yaml
kubectl apply -f ./src/shell/prometheus/crds/
kubectl apply -f ./src/shell/prometheus/crds/dashboards/

## Loki
helm upgrade --install --wait loki grafana/loki -n loki --version $loki_helm_version -f ./src/shell/loki/loki-values.yaml
helm upgrade --install --wait promtail grafana/promtail -n loki --version $promtail_helm_version -f ./src/shell/loki/promtail-values.yaml
#kubectl apply -f ./src/shell/loki/crds/

## Jaeger
helm upgrade --install --wait jaeger jaegertracing/jaeger-operator -n jaeger --version $jaeger_helm_version -f ./src/shell/jaeger/jaeger-values.yaml
kubectl apply -f ./src/shell/jaeger/crds/

#Vault
helm upgrade --install --wait vault hashicorp/vault -n vault --version $vault_helm_version -f ./src/shell/vault/vault-values.yaml
kubectl apply -f ./src/shell/vault/crds/

$consultoken = kubectl -n consul get secret consul-consul-bootstrap-acl-token -o jsonpath="{.data.token}" | base64 -d
Write-Host "Consul bootstrap root token: $consultoken"