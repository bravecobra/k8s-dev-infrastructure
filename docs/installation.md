# Installation

## Local DNS

Since we running completely locally, we want to add some entries to the hosts file.
Open `C:\Windows\system32\drivers\etc\hosts` in an editor as `Administrator` and add the following entries

```text
127.0.0.1 k8s.local infrastructure.k8s.local traefik.infrastructure.k8s.local
127.0.0.1 jaeger.infrastructure.k8s.local prometheus.infrastructure.k8s.local grafana.infrastructure.k8s.local
127.0.0.1 seq.infrastructure.k8s.local
127.0.0.1 consul.infrastructure.k8s.local vault.infrastructure.k8s.local
#127.0.0.1 es.infrastructure.k8s.local kibana.infrastructure.k8s.local
```

## Generating the traefik certificate secret

We use self-signed certificates instead of LetsEncrypt as that would require either a proper DNS or an accessible HTTP endpoint. Neither might be an option, so we'll go with the self-signed for now. We could extend it further later on.

To generate the certficates for `k8s.local` and `*.k8s.local`, use [mkcert](https://github.com/FiloSottile/mkcert) which you can install easily with `choco install mkcert`.

```powershell
mkcert -cert-file src/skaffold/crds/certs/k8s.local.crt -key-file src/skaffold/crds/certs/k8s.local.key k8s.local *.k8s.local infrastructure.k8s.local *.infrastructure.k8s.local
# mkcert -pkcs12 src/skaffold/crds/certs/k8s.local.pfx k8s.local *.k8s.local *.k8s.local infrastructure.k8s.local *.infrastructure.k8s.local
```

We then generate a kubernetes secret from the certificate

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

## Forward internal DNS Queries to Consul with CoreDNS

In order for the internal services to be able to use the Consul DNS, we need to update the CoreDNS configmap to add consul as a DNS server

Fetch the ip address of the Consul DNS

```powershell
kubectl get svc consul-consul-dns -o jsonpath='{.spec.clusterIP}' --namespace=infrastructure
```

Update the values of the consul dns service in `.\infrastructure\coredns\coredns.yaml`

> Important: `coredns.yaml` is the syntax for CoreDNS 1.7.0, matching the tested. You can also fetch the current configmap and append the consul part as described in the [Consul Docs](https://www.consul.io/docs/k8s/dns).

```powershell
kubectl apply -f .\infrastructure\coredns\coredns.yaml
```

Test it out by running a job

```powershell
kubectl apply -f .\infrastructure\coredns\test-dns-job.yaml --namespace=infrastructure
```

## Generated credentials

### Consul

Grab the bootstrap ACL token and use it to login into the ACL tab of the UI.

```powershell
kubectl get secrets/consul-consul-bootstrap-acl-token -n infrastructure --template={{.data.token}} | base64 -d
```

### Grafana

```text
username: admin
password: prom-operator
```

## Endpoints

- [Traefik](https://traefik.infrastructure.k8s.local/dashboard/)
- [Consul](https://consul.infrastructure.k8s.local/)
- [Prometheus](https://prometheus.infrastructure.k8s.local/)
- [Grafana](https://grafana.infrastructure.k8s.local/)
- [Jaeger](https://jaeger.infrastructure.k8s.local/)
