# Installation

## Local DNS

Since we running completely locally, we want to add some entries to the hosts file to forward domainnames to our locally running cluster.
Open `C:\Windows\system32\drivers\etc\hosts` in an editor as `Administrator` and add the following entries

```text
127.0.0.1 k8s.local infrastructure.k8s.local traefik.infrastructure.k8s.local
127.0.0.1 jaeger.infrastructure.k8s.local prometheus.infrastructure.k8s.local grafana.infrastructure.k8s.local
127.0.0.1 seq.infrastructure.k8s.local
127.0.0.1 consul.infrastructure.k8s.local vault.infrastructure.k8s.local
127.0.0.1 es.infrastructure.k8s.local kibana.infrastructure.k8s.local
127.0.0.1 login.k8s.local admin.login.k8s.local api.login.k8s.local
127.0.0.1 argo.k8s.local
```

## Generating the CA certificate k8s secret with mkcert

We use self-signed certificates instead of LetsEncrypt as the latter would require either a proper DNS domain which is publically available or an publically accessible HTTP endpoint. Neither might be an option in a local development setup, so we'll go with the self-signed option for now. We could extend it further later on.

To be able to generate the certficates for `k8s.local` and `*.k8s.local`, we'll use `cert-manager` and provide it with the CA certificate from [mkcert](https://github.com/FiloSottile/mkcert) which you can install easily with `choco install mkcert`. The certificates will be created by `cert-manager` and as the CA is available on our local machine through mkcert, those will also be valid in the local browser (only).

```powershell
# execute under elevated Administrator privileges
mkcert --install
copy $env:LOCALAPPDATA\mkcert\rootCA.pem ./src/certs/cacerts.crt
copy $env:LOCALAPPDATA\mkcert\rootCA-key.pem ./src/certs/cacerts.key

# Create a k8s secret manifest containing the CA Root certificate of mkcert
kubectl create secret tls ca-key-pair --namespace=cert-manager --cert=./src/certs/cacerts.crt --key=./src/certs/cacerts.key  --dry-run=client -o yaml > ./src/argocd/base/cert-manager/crds/cacerts.yaml
```

```powershell
kubectl create namespace argocd
helm upgrade --install argocd argo/argo-cd -f ./src/argocd/argo/argo-values.yaml
```
