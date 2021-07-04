# Installing commandline tools

## Choco

Install/download the CLIs.

```powershell
choco install base64
choco install mkcert
choco install terraform
choco install kubernetes-cli
choco install kubernetes-helm
choco install skaffold
```

## Installing the argoCD CLI

Follow the [guide](https://argoproj.github.io/argo-cd/cli_installation/)

For 2.0.3 and env variable needs to be set holding the name of the executable. This is missing from the docs.

```powershell
$env:ARGOCD_BINARY_NAME = 'argocd'
```
