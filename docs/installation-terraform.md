<!-- markdownlint-disable MD046 -->
# Installation

## Prerequisites

Check you've done all the [preparation](./preparation.md) and that you can connect to a running cluster. You should have all the required CLI tools and a running local cluster (using either `k3d`, `kind`, `docker desktop`, `rancher desktop` or `minikube`).

To check:

```bash
kubectl cluster-info --context <your cluster name>
```

!!!Note
    When you created your local cluster on windows and now running WSL, copy your windows context to your WSL installation.

    ```bash
    cp /mnt/c/users/<your username>/.kube/config ~/.kube/config
    ```

## Update Local DNS

Since we are running completely locally, we want to add some entries to the hosts file to forward domainnames to our locally running cluster.
On Windows, open `C:\Windows\system32\drivers\etc\hosts` in an editor as `Administrator` and add the following entries.
On Linux edit your `/etc/hosts` file as root.

```text
127.0.0.1 k8s.local infrastructure.k8s.local traefik.infrastructure.k8s.local traefik.k8s.local
127.0.0.1 jaeger.infrastructure.k8s.local prometheus.infrastructure.k8s.local seq.infrastructure.k8s.local grafana.infrastructure.k8s.local
127.0.0.1 consul.infrastructure.k8s.local vault.infrastructure.k8s.local
127.0.0.1 es.infrastructure.k8s.local kibana.infrastructure.k8s.local
127.0.0.1 login.k8s.local admin.login.k8s.local api.login.k8s.local
127.0.0.1 app1.k8s.local api.app1.k8s.local
127.0.0.1 argo.k8s.local
127.0.0.1 linkerd.infrastructure.k8s.local
127.0.0.1 whoami1.k8s.local whoami2.k8s.local
127.0.0.1 keycloak.k8s.local auth.k8s.local
127.0.0.1 etcd.infrastructure.k8s.local
127.0.0.1 minio.infrastructure.k8s.local console.minio.infrastructure.k8s.local
127.0.0.1 azurite.infrastructure.k8s.local
127.0.0.1 rabbitmq.infrastructure.k8s.local
127.0.0.1 localstack.infrastructure.k8s.local
127.0.0.1 flux.infrastructure.k8s.local
127.0.0.1 kafka.infrastructure.k8s.local
127.0.0.1 mysql.infrastructure.k8s.local
127.0.0.1 mariadb.infrastructure.k8s.local
127.0.0.1 postgres.infrastructure.k8s.local
127.0.0.1 mssql.infrastructure.k8s.local
127.0.0.1 oracle.infrastructure.k8s.local
127.0.0.1 mongo.infrastructure.k8s.local
127.0.0.1 oracle.infrastructure.k8s.local
127.0.0.1 redis.infrastructure.k8s.local
```

## Generate a root certificate

Assuming the root certificate is already created with `mkcert -install`, then

=== "Windows"

    ```bash
    cd src/terraform
    ./generate-certificate.ps1
    ```

=== "Linux/WSL"

    Next run the installer in a Linux/WSL shell:

    ```bash
    cd src/terraform
    ./generate-certificate.sh
    ```

## Helm repositories

| Name                 | URL                                                               |
| -------------------- | ----------------------------------------------------------------- |
| stable               | [https://charts.helm.sh/stable]                                   |
| hashicorp            | [https://helm.releases.hashicorp.com]                             |
| datawire             | [https://www.getambassador.io]                                    |
| jaegertracing        | [https://jaegertracing.github.io/helm-charts]                     |
| bitnami              | [https://charts.bitnami.com/bitnami]                              |
| prometheus-community | [https://prometheus-community.github.io/helm-charts]              |
| traefik              | [https://helm.traefik.io/traefik]                                 |
| datalust             | [https://helm.datalust.co]                                        |
| fluent               | [https://fluent.github.io/helm-charts]                            |
| grafana              | [https://grafana.github.io/helm-charts]                           |
| agua                 | [https://aguafrommars.github.io/helm]                             |
| elastic              | [https://helm.elastic.co]                                         |
| jetstack             | [https://charts.jetstack.io]                                      |
| identityserver4admin | [https://bravecobra.github.io/identityserver4.admin-helm/charts/] |
| argo                 | [https://argoproj.github.io/argo-helm]                            |
| argo-cd              | [https://argoproj.github.io/argo-helm]                            |
| linkerd              | [https://helm.linkerd.io/stable]                                  |
| longhorn             | [https://charts.longhorn.io]                                      |
| codecentric          | [https://codecentric.github.io/helm-charts]                       |
| open-telemetry       | [https://open-telemetry.github.io/opentelemetry-helm-charts]      |
| minio                | [https://charts.min.io/]                                          |
| kubecost             | [https://kubecost.github.io/cost-analyzer/]                       |
| localstack-charts    | [https://localstack.github.io/helm-charts]                        |
| fluxcd-community     | [https://fluxcd-community.github.io/helm-charts]                  |
| simcube              | [https://simcubeltd.github.io/simcube-helm-charts/]               |
| oracle               | [https://oracle.github.io/helm-charts]                            |
| cilium               | [https://helm.cilium.io/]                                         |
| confluentinc         | [https://confluentinc.github.io/cp-helm-charts/]                  |
| strimzi              | [https://strimzi.io/charts/]                                      |
| aqua                 | [https://aquasecurity.github.io/helm-charts/]                     |
| jfrog                | [https://charts.jfrog.io]                                         |
| joxit                | [https://helm.joxit.dev]                                          |

To add these easily

=== "Windows"

```bash
cd src/terraform
./add-helm-repos.ps1
```

=== "Linux/WSL"

```bash
cd src/terraform
./add-helm-repos.sh
```

## Installer

Edit the `terraform.tfvars` as you see fit.

=== "Windows"

    ```bash
    cd src/terraform
    helm repo update
    terraform init
    terraform apply -auto-approve
    ```

=== "Linux/WSL"

    Next run the installer in a Linux/WSL shell:

    ```bash
    cd src/terraform
    helm repo update
    terraform init
    terraform apply -auto-approve
    ```
