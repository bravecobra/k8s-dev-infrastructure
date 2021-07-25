# Installation

## Prerequisites

Check you have all the [cli tools](./preparation/cli.md) installed and that you can connect to a running cluster.

```bash
kubectl cluster-info --context kind-devinfra
```

> When you created your local cluster on windows and now runnign WSL, copy your windows context to your WSL installation.

```bash
cp /mnt/c/users/<your username>>/.kube/config ~/.kube/config
```

## Update Local DNS

Since we are running completely locally, we want to add some entries to the hosts file to forward domainnames to our locally running cluster.
On Windows, open `C:\Windows\system32\drivers\etc\hosts` in an editor as `Administrator` and add the following entries.
On linux edit your `/etc/hosts` file as root.

```text
127.0.0.1 k8s.local infrastructure.k8s.local traefik.infrastructure.k8s.local
127.0.0.1 jaeger.infrastructure.k8s.local prometheus.infrastructure.k8s.local grafana.infrastructure.k8s.local
# 127.0.0.1 seq.infrastructure.k8s.local
127.0.0.1 consul.infrastructure.k8s.local vault.infrastructure.k8s.local
127.0.0.1 es.infrastructure.k8s.local kibana.infrastructure.k8s.local
127.0.0.1 login.k8s.local admin.login.k8s.local api.login.k8s.local
127.0.0.1 argo.k8s.local
```

## Installer

Next run the installer in as Linux/WSL shell:

```bash
./src/shell/install.sh
```
