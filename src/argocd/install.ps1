## setup CA Root from mkcert
Copy-Item $env:LOCALAPPDATA\mkcert\rootCA.pem ./src/certs/cacerts.crt
Copy-Item $env:LOCALAPPDATA\mkcert\rootCA-key.pem ./src/certs/cacerts.key
kubectl create secret tls ca-key-pair --namespace=cert-manager --cert=./src/certs/cacerts.crt --key=./src/certs/cacerts.key  --dry-run=client -o yaml > ./src/argocd/argo/cert-manager/crds/cacerts.yaml

## Install cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo add argo https://argoproj.github.io/argo-helm
helm repo add traefik https://helm.traefik.io/traefik
helm repo update

kubectl create namespace cert-manager
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.3.1/cert-manager.crds.yaml
helm upgrade --install --wait cert-manager jetstack/cert-manager -n cert-manager --set installCRDs=false

kubectl apply -f ./src/argocd/argo/cert-manager/crds/cacerts.yaml
kubectl apply -f ./src/argocd/argo/cert-manager/crds/cluster-issuer.yaml
Start-Sleep -Seconds 10

## install traefik as ingress-controller
kubectl create namespace infrastructure
helm upgrade --install --wait traefik traefik/traefik -n infrastructure -f ./src/argocd/argo/traefik/traefik-values.yaml

kubectl apply -f ./src/argocd/argo/traefik/crds/cert-store.yaml
kubectl apply -f ./src/argocd/argo/traefik/crds/http-redirect-middleware.yaml
kubectl apply -f ./src/argocd/argo/traefik/crds/traefik-cert.yaml
kubectl apply -f ./src/argocd/argo/traefik/crds/dashboard.yaml

## install argocd
kubectl create namespace argocd
helm upgrade --install --wait argocd argo/argo-cd -n argocd -f ./src/argocd/argo/argo-values.yaml
$argopass = kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d | Out-String
Write-Host "Argo admin pass: $argopass"
