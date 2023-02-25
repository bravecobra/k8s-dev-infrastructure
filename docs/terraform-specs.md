<!-- markdownlint-disable MD033 -->
# Terraform documentation

## Description

<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| flux | >= 0.20.0 |
| github | >= 5.9.0 |
| kubectl | >= 1.14.0 |
| time | >= 0.9.1 |
| tls | 4.0.4 |

### Providers

| Name | Version |
|------|---------|
| http | 3.2.1 |
| kubectl | 1.14.0 |
| kubernetes | 2.17.0 |
| null | 3.2.1 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| argocd | ./modules/services/deployment/argocd | n/a |
| azurite | ./modules/services/storage/azurite | n/a |
| certmanager | ./modules/networking/cert-manager | n/a |
| coredns | ./modules/networking/coredns | n/a |
| dashboard | ./modules/monitoring/dashboard | n/a |
| elasticsearch | ./modules/services/search/elasticsearch | n/a |
| etcd | ./modules/services/configuration/etcd | n/a |
| flux2 | ./modules/services/deployment/flux2 | n/a |
| goldilocks | ./modules/monitoring/goldilocks | n/a |
| identityserver4 | ./modules/services/security/auth/identityserver4-admin | n/a |
| jaeger | ./modules/monitoring/tracing/jaeger | n/a |
| kafka | ./modules/services/messaging/kafka | n/a |
| keycloak | ./modules/services/security/auth/keycloak | n/a |
| linkerd | ./modules/networking/linkerd | n/a |
| localstack | ./modules/services/cloud/localstack | n/a |
| loki | ./modules/monitoring/logging/loki | n/a |
| mariadb | ./modules/services/database/rds/mariadb | n/a |
| metrics | ./modules/monitoring/metrics/metrics | n/a |
| minio | ./modules/services/storage/minio | n/a |
| mongodb | ./modules/services/database/nosql/mongodb | n/a |
| mssql | ./modules/services/database/rds/sqlserver | n/a |
| mysql | ./modules/services/database/rds/mysql | n/a |
| opentelemetry | ./modules/monitoring/ingestion/opentelemetry | n/a |
| oraclexe | ./modules/services/database/rds/oracle-xe | n/a |
| postgres | ./modules/services/database/rds/postgres | n/a |
| prometheus | ./modules/monitoring/metrics/prometheus | n/a |
| rabbitmq | ./modules/services/messaging/rabbitmq | n/a |
| redis | ./modules/services/caching/redis | n/a |
| registry | ./modules/services/storage/docker | n/a |
| seq | ./modules/monitoring/logging/seq | n/a |
| tempo | ./modules/monitoring/tracing/tempo | n/a |
| traefik | ./modules/networking/traefik | n/a |
| vault | ./modules/services/configuration/vault | n/a |
| versions | ./modules/utils/chartversions | n/a |
| vpa | ./modules/monitoring/vpa | n/a |
| whoami | ./samples/whoami | n/a |

### Resources

| Name | Type |
|------|------|
| [kubectl_manifest.notify_watchers](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.argocd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.azurite](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.cert-manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.dashboard](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.docker_registry](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.elasticsearch](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.etcd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.flux_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.goldilocks](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.identityserver4](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.jaeger](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.kafka](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.keycloak](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.linkerd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.localstack](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.loki](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.mariadb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.minio](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.mongodb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.mssql](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.mysql](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.opentelemetry](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.oracle](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.postgres](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.prometheus](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.rabbitmq](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.redis](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.seq](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.tempo](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.traefik](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.vault](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.vpa](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.whoami](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [null_resource.flux_uninstall](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [http_http.manifestfiles](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [kubectl_file_documents.oracle_manifests](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| argocd\_helm\_version | n/a | `string` | `""` | no |
| argocd\_namespace | n/a | `string` | `"argocd"` | no |
| azurite\_namespace | n/a | `string` | `"azurite"` | no |
| azurite\_version | n/a | `string` | `"latest"` | no |
| cert\_manager\_helm\_version | cert-manager | `string` | `""` | no |
| cert\_manager\_namespace | n/a | `string` | `"cert-manager"` | no |
| cluster-context-name | n/a | `string` | n/a | yes |
| cluster-type | n/a | `string` | `"k3s"` | no |
| dashboard\_helm\_version | dashboard | `string` | `""` | no |
| dashboard\_namespace | n/a | `string` | `"dashboard"` | no |
| docker\_registry\_helm\_version | n/a | `string` | `""` | no |
| docker\_registry\_namespace | n/a | `string` | `"registryui"` | no |
| domain-name | n/a | `string` | n/a | yes |
| elasticsearch\_helm\_version | n/a | `string` | `""` | no |
| elasticsearch\_namespace | n/a | `string` | `"elasticsearch"` | no |
| etcd\_helm\_version | n/a | `string` | `""` | no |
| etcd\_namespace | n/a | `string` | `"etcd"` | no |
| expose\_azurite | n/a | `bool` | `false` | no |
| expose\_jaeger | n/a | `bool` | `false` | no |
| expose\_kafka | n/a | `bool` | `false` | no |
| expose\_loki | n/a | `bool` | `false` | no |
| expose\_mariadb | n/a | `bool` | `false` | no |
| expose\_mongodb | n/a | `bool` | `false` | no |
| expose\_mssql | n/a | `bool` | `false` | no |
| expose\_mysql | n/a | `bool` | `false` | no |
| expose\_opentelemetry | n/a | `bool` | `false` | no |
| expose\_oracle | n/a | `bool` | `false` | no |
| expose\_postgres | n/a | `bool` | `false` | no |
| expose\_rabbitmq | n/a | `bool` | `false` | no |
| expose\_redis | n/a | `bool` | `false` | no |
| expose\_seq | n/a | `bool` | `false` | no |
| fluent\_helm\_version | n/a | `string` | `""` | no |
| flux2\_github\_repository\_branch | n/a | `string` | `"master"` | no |
| flux2\_github\_repository\_create | n/a | `bool` | `true` | no |
| flux2\_github\_repository\_name | n/a | `string` | `"k8s-flux-example"` | no |
| flux2\_github\_repository\_path | n/a | `string` | `"clusters/k8s-local"` | no |
| flux2\_github\_repository\_visibility | n/a | `string` | `"private"` | no |
| flux2\_namespace | flux2 | `string` | `"flux-system"` | no |
| goldilocks\_helm\_version | n/a | `string` | `""` | no |
| goldilocks\_namespace | n/a | `string` | `"goldilocks"` | no |
| identityserver4admin\_helm\_version | n/a | `string` | `""` | no |
| identityserver4admin\_mssql\_helm\_version | n/a | `string` | `""` | no |
| identityserver4admin\_namespace | n/a | `string` | `"identityserver4"` | no |
| install\_argocd | argocd | `bool` | `false` | no |
| install\_azurite | Azurite | `bool` | `false` | no |
| install\_cert\_manager | n/a | `bool` | `true` | no |
| install\_dashboard | n/a | `bool` | `false` | no |
| install\_docker\_registry | n/a | `bool` | `false` | no |
| install\_elasticsearch | elasticsearch | `bool` | `false` | no |
| install\_etcd | Etcd | `bool` | `false` | no |
| install\_flux2 | n/a | `bool` | `false` | no |
| install\_goldilocks | goldilocks | `bool` | `false` | no |
| install\_grafana | grafana | `bool` | `false` | no |
| install\_identityserver4admin | identityserver4-admin | `bool` | `false` | no |
| install\_jaeger | n/a | `bool` | `false` | no |
| install\_kafka | kafka | `bool` | `false` | no |
| install\_keycloak | Keycloak | `bool` | `false` | no |
| install\_kibana | n/a | `bool` | `false` | no |
| install\_linkerd | linkerd | `bool` | `false` | no |
| install\_localstack | localstack | `bool` | `false` | no |
| install\_loki | loki | `bool` | `false` | no |
| install\_mariadb | Mariadb | `bool` | `false` | no |
| install\_metrics | metrics | `bool` | `false` | no |
| install\_minio | minio | `bool` | `false` | no |
| install\_mongodb | mongodb | `bool` | `false` | no |
| install\_mssql | mssql | `bool` | `false` | no |
| install\_mysql | MySQL | `bool` | `false` | no |
| install\_opentelemetry | n/a | `bool` | `false` | no |
| install\_oracle | oracle | `bool` | `false` | no |
| install\_postgres | Postgres | `bool` | `false` | no |
| install\_prometheus | n/a | `bool` | `false` | no |
| install\_promtail | n/a | `bool` | `false` | no |
| install\_rabbitmq | rabbitmq | `bool` | `false` | no |
| install\_redis | redis | `bool` | `false` | no |
| install\_seq | seq | `bool` | `false` | no |
| install\_tempo | tempo | `bool` | `false` | no |
| install\_traefik | traefik | `bool` | `true` | no |
| install\_vault | vault | `bool` | `false` | no |
| install\_vpa | VPA | `bool` | `false` | no |
| install\_whoami | WhoAmI | `bool` | `false` | no |
| jaeger\_helm\_version | jaeger | `string` | `""` | no |
| jaeger\_namespace | n/a | `string` | `"jaeger"` | no |
| kafka\_helm\_version | n/a | `string` | `""` | no |
| kafka\_namespace | n/a | `string` | `"kafka"` | no |
| keycloak\_helm\_version | n/a | `string` | `""` | no |
| keycloak\_include\_domainrealm | n/a | `bool` | `false` | no |
| keycloak\_namespace | n/a | `string` | `"keycloak"` | no |
| linkerd\_helm\_version | n/a | `string` | `""` | no |
| linkerd\_namespace | n/a | `string` | `"linkerd"` | no |
| linkerdcrds\_helm\_version | n/a | `string` | `""` | no |
| linkerdjaeger\_helm\_version | n/a | `string` | `""` | no |
| linkerdviz\_helm\_version | n/a | `string` | `""` | no |
| loadbalancer-ip | n/a | `string` | `"172.19.0.2"` | no |
| localstack\_helm\_version | n/a | `string` | `""` | no |
| localstack\_namespace | n/a | `string` | `"localstack"` | no |
| loki\_helm\_version | n/a | `string` | `""` | no |
| loki\_namespace | n/a | `string` | `"loki"` | no |
| mariadb\_helm\_version | n/a | `string` | `""` | no |
| mariadb\_namespace | n/a | `string` | `"mariadb"` | no |
| metrics\_helm\_version | n/a | `string` | `""` | no |
| minio\_helm\_version | n/a | `string` | `""` | no |
| minio\_namespace | n/a | `string` | `"minio"` | no |
| mongodb\_helm\_version | n/a | `string` | `""` | no |
| mongodb\_namespace | n/a | `string` | `"mongodb"` | no |
| monitoring\_backend | n/a | `string` | `"grafana"` | no |
| mssql\_helm\_version | n/a | `string` | `""` | no |
| mssql\_namespace | n/a | `string` | `"mssql"` | no |
| mysql\_helm\_version | n/a | `string` | `""` | no |
| mysql\_namespace | n/a | `string` | `"mysql"` | no |
| node-ips | n/a | `list(any)` | <pre>[<br>  "172.19.0.2"<br>]</pre> | no |
| opentelemetry\_helm\_version | opentelemetry | `string` | `""` | no |
| opentelemetry\_namespace | n/a | `string` | `"opentelemetry"` | no |
| oracle\_namespace | n/a | `string` | `"oracle"` | no |
| oracle\_operator\_version | n/a | `string` | `"0.2.1"` | no |
| oracle\_xe\_version | n/a | `string` | `"21.3.0-xe"` | no |
| postgres\_helm\_version | n/a | `string` | `""` | no |
| postgres\_namespace | n/a | `string` | `"postgres"` | no |
| prometheus\_helm\_version | prometheus | `string` | `""` | no |
| prometheus\_namespace | n/a | `string` | `"prometheus"` | no |
| promtail\_helm\_version | n/a | `string` | `""` | no |
| rabbitmq\_helm\_version | n/a | `string` | `""` | no |
| rabbitmq\_namespace | n/a | `string` | `"rabbitmq"` | no |
| redis\_helm\_version | n/a | `string` | `""` | no |
| redis\_namespace | n/a | `string` | `"redis"` | no |
| seq\_helm\_version | n/a | `string` | `""` | no |
| seq\_namespace | n/a | `string` | `"seq"` | no |
| tempo\_helm\_version | n/a | `string` | `""` | no |
| tempo\_namespace | n/a | `string` | `"tempo"` | no |
| traefik\_helm\_version | n/a | `string` | `""` | no |
| traefik\_namespace | n/a | `string` | `"traefik"` | no |
| vault\_helm\_version | n/a | `string` | `""` | no |
| vault\_namespace | n/a | `string` | `"vault"` | no |
| vpa\_helm\_version | n/a | `string` | `""` | no |
| vpa\_namespace | n/a | `string` | `"vpa"` | no |
| whoami\_helm\_version | n/a | `string` | `""` | no |
| whoami\_namespace | n/a | `string` | `"whoami"` | no |

### Outputs

| Name | Description |
|------|-------------|
| argocd-password | ArgoCD Initial Admin password |
| elastic-password | Elasticsearch user |
| elastic-user | Elasticsearch password |
| etcd-password | Etcd Initial Admin password |
| grafana-password | Grafana Admin password |
| grafana-user | Grafana Admin user |
| helm\_version\_argocd | ArgoCD helm version |
| helm\_version\_cert-manager | Cert-Manager helm version |
| helm\_version\_docker\_registry | Docker Registry helm version |
| helm\_version\_elasticsearch | ECK (ElasticSearch - Kibana) helm version |
| helm\_version\_etcd | Etcd helm version |
| helm\_version\_fluent | Fluent-bit helm version |
| helm\_version\_identityserveradmin | Identityserver Admin helm version |
| helm\_version\_identityserveradmin-mssql | IdentityServer Admin SQL Server helm version |
| helm\_version\_jaeger | Jaeger helm version |
| helm\_version\_kafka | Kafka helm version |
| helm\_version\_keycloak | Keycloak helm version |
| helm\_version\_linkerd | Linkerd helm version |
| helm\_version\_localstack | Localstack helm version |
| helm\_version\_loki | Loki helm version |
| helm\_version\_mariadb | MariaDB helm version |
| helm\_version\_metrics | Metrics-server helm version |
| helm\_version\_minio | Minio helm version |
| helm\_version\_mongodb | MongoDB helm version |
| helm\_version\_mssql | SQL Server helm version |
| helm\_version\_mysql | MySQL helm version |
| helm\_version\_opentelemetry | Opentelemetry collector helm version |
| helm\_version\_postgres | PostgreSQL helm version |
| helm\_version\_prometheus | Prometheus helm version |
| helm\_version\_promtail | Promtail helm version |
| helm\_version\_rabbitmq | RabbitMq helm version |
| helm\_version\_redis | Redis helm version |
| helm\_version\_seq | Seq helm version |
| helm\_version\_tempo | Tempo helm version |
| helm\_version\_traefik | Traefik helm version |
| helm\_version\_vault | Hashicorp Vault helm version |
| helm\_versions | Chart versions |
| keycloak-password | Keycloak Initial Admin password |
| mariadb-password | MariaDB password |
| minio-password | Minio Initial root password |
| mongodb-password | MongoDB password |
| mssql-password | MSSQL password |
| mysql-password | Mysql password |
| oracle-password | Oracle password |
| postgres-password | Postgres password |
| redis-password | Redis password |
| vault-password | Vault token |
<!-- END_TF_DOCS -->