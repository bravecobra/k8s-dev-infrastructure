# Quickstart

## Prerequisites

```powershell
choco install mkcert
choco install terraform
choco install kubernetes-cli
choco install kubernetes-helm
choco install skaffold
```

## Prepare locally

Open `C:\Windows\system32\drivers\etc\hosts` in an editor as `Administrator` and add the following entries

```text
127.0.0.1 k8s.local infrastructure.k8s.local traefik.infrastructure.k8s.local
127.0.0.1 jaeger.infrastructure.k8s.local prometheus.infrastructure.k8s.local grafana.infrastructure.k8s.local
127.0.0.1 seq.infrastructure.k8s.local
127.0.0.1 consul.infrastructure.k8s.local vault.infrastructure.k8s.local
#127.0.0.1 es.infrastructure.k8s.local kibana.infrastructure.k8s.local
```

Add a self-signed certificate and add the needed helm repo's

```powershell
mkcert -cert-file src/skaffold/traefik/crds/certs/k8s.local.crt -key-file src/skaffold/traefik/crds/certs/k8s.local.key k8s.local *.k8s.local infrastructure.k8s.local *.infrastructure.k8s.local

kubectl create secret tls traefik-cert --cert=./src/skaffold/traefik/crds/certs/k8s.local.crt --key=./src/skaffold/traefik/crds/certs/k8s.local.key --dry-run=client -o yaml > ./src/skaffold/traefik/crds/certs/certs.yaml

helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add traefik https://helm.traefik.io/traefik
helm repo add datalust https://helm.datalust.co
helm repo add fluent https://fluent.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

> Update the externalIP for Traefik if needed (KinD) as described in the [installation](../installation/#traefik-external-ip-kind)

## Install on the cluster

```powershell
cd src\skaffold
kubectl apply -f .\namespace.yaml
skaffold run
```
