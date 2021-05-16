# Installation

## Generating the traefik certificate secret

### Using a self-signed certificate

We use self-signed certificates instead of LetsEncrypt as that would require either a proper DNS or an accessible HTTP endpoint. Neither might be an option, so we'll go with the self-signed for now. We could extend it further later on.

To generate the certficates for `k8s.local` and `*.k8s.local`, use [mkcert](https://github.com/FiloSottile/mkcert) which you can install easily with `choco install mkcert`.

```powershell
mkcert -cert-file src/skaffold/crds/certs/k8s.local.crt -key-file src/skaffold/crds/certs/k8s.local.key k8s.local *.k8s.local infrastructure.k8s.local *.infrastructure.k8s.local
```

### Converting the certificate into a k8s secret

```powershell
kubectl create secret tls traefik-cert --cert=./src/skaffold/crds/certs/k8s.local.crt --key=./src/skaffold/crds/certs/k8s.local.key --dry-run=client -o yaml > ./src/skaffold/crds/certs/certs.yaml
```

## Adding helm repo's

```powershell
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

### Traefik External IP (KinD)

If running on KinD, we need to update the external IP for traefik to be able to reroute traffic

To find out the ip that master node got during creation

```powershell
> kubectl get nodes -o wide
NAME                     STATUS   ROLES                  VERSION   INTERNAL-IP
devinfra-control-plane   Ready    control-plane,master   v1.20.2   172.18.0.5
devinfra-worker          Ready    <none>                 v1.20.2   172.18.0.3
devinfra-worker2         Ready    <none>                 v1.20.2   172.18.0.2
devinfra-worker3         Ready    <none>                 v1.20.2   172.18.0.4
```

and update the `externalIPs` entry in `src/skaffold/traefik/traefik-values.yaml`

```yaml
service:
  externalIPs: [
    172.18.0.5
  ]
```

## Skaffolding

```powershell
cd src\skaffold
kubectl apply -f .\namespace.yaml
skaffold run
```

> If running on Docker-Desktop, you need to restart Docker to get it fully working as consult-inject does not find a route to the host. `KinD` does not seem to have this problem.

## Terraform

Edit your variables to connect to the correct cluster

```powershell
cd src\terraform
terraform init
terraform plan
terraform apply -var-file="configuration.tfvars"
```
