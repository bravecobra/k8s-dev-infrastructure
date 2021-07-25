#!/bin/bash

# For using WSL's kubectl copy the context to the default kubectl context
# cp /mnt/c/users/<username>/.kube/config ~/.kube/config

login_domain=login.k8s.local
login_admin_domain=admin.login.k8s.local

metrics_helm_version=5.9.0
traefik_helm_version=9.19.1 # 10.1.1
certmanager_helm_version=v1.4.1
jaeger_helm_version=2.21.1 # 2.23.0
prometheus_helm_version=16.0.1 # 16.15.0
loki_helm_version=2.5.0 # 2.5.3
promtail_helm_version=3.5.1 # 3.6.0
consul_helm_version=0.31.1 # 0.32.1
vault_helm_version=0.13.0
lastic_helm_version=1.6.0
identityserver4admin_helm_version=0.4.0
argocd_helm_version=3.10.0

if grep -q microsoft /proc/version; then
  echo "Ubuntu on Windows"
  localappdata=`wslpath "$(wslvar LOCALAPPDATA)"`
else
  echo "native Linux"
  localappdata=`~/.local/share`
fi

localappdata=`wslpath "$(wslvar LOCALAPPDATA)"`
cp $localappdata/mkcert/rootCA.pem ./src/certs/cacerts.crt
cp $localappdata/mkcert/rootCA-key.pem ./src/certs/cacerts.key
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
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

## Creating namespaces
kubectl create namespace cert-manager
kubectl create namespace traefik
kubectl create namespace consul
kubectl create namespace vault
kubectl create namespace prometheus
kubectl create namespace loki
kubectl create namespace jaeger
kubectl create namespace elasticsearch
kubectl create namespace identityserver4
kubectl create namespace argocd

## Enabling metrics addon
helm upgrade --install --wait metrics-server bitnami/metrics-server --version=$metrics_helm_version --values=./src/shell/metrics/metrics-values.yaml

## Cert-manager
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/$certmanager_helm_version/cert-manager.crds.yaml
helm upgrade --install --wait cert-manager jetstack/cert-manager -n cert-manager --version $certmanager_helm_version --set installCRDs=false
kubectl apply -f ./src/shell/cert-manager/crds/
sleep 10s

## install traefik as ingress-controller
kubectl apply -f ./src/shell/traefik/crds/trafik-cert.yaml
helm upgrade --install --wait traefik traefik/traefik -n traefik --version $traefik_helm_version -f ./src/shell/traefik/traefik-values.yaml
kubectl apply -f ./src/shell/traefik/crds/

## Consul
helm upgrade --install --wait consul hashicorp/consul -n consul --version $consul_helm_version -f ./src/shell/consul/consul-values.yaml
kubectl apply -f ./src/shell/consul/crds/

## Update CoreDNS
# todo: sed coredns.yaml to contain the correct consul dns ip
kubectl -n kube-system get configmap coredns -o yaml > ./src/shell/coredns/coredns-orig.yaml
if ! grep -q "identityserver4" ./src/shell/coredns/coredns-orig.yaml; then
  cat ./src/shell/coredns/coredns-orig.yaml | sed -e 's/ready/rewrite name login.k8s.local identityserver4-identity.identityserver4.svc.cluster.local\n        rewrite name admin.login.k8s.local identityserver4-admin.identityserver4.svc.cluster.local\n        ready/g' > ./src/shell/coredns/coredns-patched.yaml
  kubectl apply -f ./src/shell/coredns/coredns-patched.yaml
fi

## Prometheus
helm upgrade --install --wait prometheus prometheus-community/kube-prometheus-stack -n prometheus --version $prometheus_helm_version -f ./src/shell/prometheus/prometheus-values.yaml
kubectl apply -f ./src/shell/prometheus/crds/
kubectl apply $(ls ./src/shell/prometheus/crds/dashboards/*.yaml | awk '{ print " -f " $1 }')

## Loki
helm upgrade --install --wait loki grafana/loki -n loki --version $loki_helm_version -f ./src/shell/loki/loki-values.yaml
helm upgrade --install --wait promtail grafana/promtail -n loki --version $promtail_helm_version -f ./src/shell/loki/promtail-values.yaml
#kubectl apply -f ./src/shell/loki/crds/

## Jaeger
helm upgrade --install --wait jaeger jaegertracing/jaeger-operator -n jaeger --version $jaeger_helm_version -f ./src/shell/jaeger/jaeger-values.yaml
kubectl apply -f ./src/shell/jaeger/crds/

## Vault
helm upgrade --install --wait vault hashicorp/vault -n vault --version $vault_helm_version -f ./src/shell/vault/vault-values.yaml
kubectl apply -f ./src/shell/vault/crds/

## ElasticSearch & Kibana
helm upgrade --install --wait elastic-operator elastic/eck-operator -n elasticsearch --version $elastic_helm_version -f ./src/shell/elasticsearch/eck-values.yaml
kubectl apply -f ./src/shell/elasticsearch/crds/

## Identityserver admin
helm upgrade --install --wait identityserver4 identityserver4admin/identityserver4admin -n identityserver4 --version $identityserver4admin_helm_version -f ./src/shell/identityserver4-admin/identityserver4admin-values.yaml
# kubectl apply -f ./src/shell/identityserver4admin/crds/

## install argocd
helm upgrade --install --wait argocd argo/argo-cd -n argocd --version $argocd_helm_version  -f ./src/shell/argocd/argo-values.yaml
argopass=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`
echo "ArgoCD username: admin"
echo "ArgoCD password: $argopass"
# argocd login argo.k8s.local:443 --grpc-web --username admin --password $argopass
# argocd app create root --grpc-web --repo=https://github.com/bravecobra/k8s-dev-infrastructure --path=src/argocd/infrastructure/root/root-app --revision=develop --dest-server=https://kubernetes.default.svc --dest-namespace=default --self-heal --auto-prune --sync-option CreateNamespace=true --sync-policy=automated
# argocd app create infrastructure --grpc-web --repo=https://github.com/bravecobra/k8s-dev-infrastructure --path=src/argocd/infrastructure/base/infrastructure-app --revision=develop --dest-server=https://kubernetes.default.svc --dest-namespace=infrastructure --self-heal --auto-prune --sync-option CreateNamespace=true --sync-policy=automated

elasticsearchpass=`kubectl -n elasticsearch get secret elastic-es-es-elastic-user -o jsonpath='{.data.elastic}' | base64 -d`
echo "Elasticsearch username: elastic"
echo "Elasticsearch password: $elasticsearchpass"
consultoken=`kubectl -n consul get secret consul-consul-bootstrap-acl-token -o jsonpath="{.data.token}" | base64 -d`
consuldns=`kubectl get svc consul-consul-dns -o jsonpath='{.spec.clusterIP}' --namespace=consul`
echo "Consul DNS Server ClusterIP: $consuldns"
echo "Consul bootstrap root token: $consultoken"