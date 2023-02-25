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
| argocd\_helm\_version | Override Helm version of argocd | `string` | `""` | no |
| argocd\_namespace | Namespace of argocd | `string` | `"argocd"` | no |
| azurite\_namespace | Namespace of azurite | `string` | `"azurite"` | no |
| azurite\_version | Override version of azurite | `string` | `"latest"` | no |
| cert\_manager\_helm\_version | Override Helm version of cert-manager | `string` | `""` | no |
| cert\_manager\_namespace | Namespace of cert-manager | `string` | `"cert-manager"` | no |
| cluster-context-name | The kubectl context to use | `string` | n/a | yes |
| cluster-type | The type of the cluster. Important for Traefik to route traffic correctly | `string` | `"k3s"` | no |
| dashboard\_helm\_version | Override Helm version of dashboard | `string` | `""` | no |
| dashboard\_namespace | Namespace of dashboard | `string` | `"dashboard"` | no |
| docker\_registry\_helm\_version | Override Helm version of docker-registry | `string` | `""` | no |
| docker\_registry\_namespace | Namespace of docker-registry | `string` | `"registryui"` | no |
| domain-name | The toplevel domain of the cluster | `string` | n/a | yes |
| elasticsearch\_helm\_version | Override Helm version of ECK (Elasticsearch Operator) | `string` | `""` | no |
| elasticsearch\_namespace | Namespace of elasticsearch | `string` | `"elasticsearch"` | no |
| etcd\_helm\_version | Override Helm version of etcd | `string` | `""` | no |
| etcd\_namespace | Namespace of etcd | `string` | `"etcd"` | no |
| expose\_azurite | Flag to expose azurite externally | `bool` | `false` | no |
| expose\_jaeger | Flag to expose jaeger externally | `bool` | `false` | no |
| expose\_kafka | Flag to expose kafka externally | `bool` | `false` | no |
| expose\_loki | Flag to expose loki externally | `bool` | `false` | no |
| expose\_mariadb | Flag to expose mariadb externally | `bool` | `false` | no |
| expose\_mongodb | Flag to expose mongodb externally | `bool` | `false` | no |
| expose\_mssql | Flag to expose SQL Server externally | `bool` | `false` | no |
| expose\_mysql | Flag to expose mysql externally | `bool` | `false` | no |
| expose\_opentelemetry | Flag to expose opentelemetry collector externally | `bool` | `false` | no |
| expose\_oracle | Flag to expose Oracl XE externally | `bool` | `false` | no |
| expose\_postgres | Flag to expose postgres externally | `bool` | `false` | no |
| expose\_rabbitmq | Flag to expose rabbitmq externally | `bool` | `false` | no |
| expose\_redis | Flag to expose redis externally | `bool` | `false` | no |
| expose\_seq | Flag to expose seq externally | `bool` | `false` | no |
| fluent\_helm\_version | Override Helm version of fluent-bit | `string` | `""` | no |
| flux2\_github\_repository\_branch | The branch to read configuration from | `string` | `"master"` | no |
| flux2\_github\_repository\_create | Create github repo to read configuration from | `bool` | `true` | no |
| flux2\_github\_repository\_name | Name of the github repo to create | `string` | `"k8s-flux-example"` | no |
| flux2\_github\_repository\_path | The path inside the repo to read configuration | `string` | `"clusters/k8s-local"` | no |
| flux2\_github\_repository\_visibility | Visibility of the repository | `string` | `"private"` | no |
| flux2\_namespace | Namespace of Flux2 | `string` | `"flux-system"` | no |
| goldilocks\_helm\_version | Override Helm version of goldilocks | `string` | `""` | no |
| goldilocks\_namespace | Namespace of goldilocks | `string` | `"goldilocks"` | no |
| identityserver4admin\_helm\_version | Override Helm version of Identityserver4 Admin | `string` | `""` | no |
| identityserver4admin\_mssql\_helm\_version | Override Helm version of SQL Server for Identityserver4 Admin | `string` | `""` | no |
| identityserver4admin\_namespace | Namespace of Identityserver4 Admin | `string` | `"identityserver4"` | no |
| install\_argocd | Flag to install argocd | `bool` | `false` | no |
| install\_azurite | Flag to install azurite | `bool` | `false` | no |
| install\_cert\_manager | Flag to install cert-manager | `bool` | `true` | no |
| install\_dashboard | Flag to install kubernetes dashboard | `bool` | `false` | no |
| install\_docker\_registry | Flag to install docker-registry | `bool` | `false` | no |
| install\_elasticsearch | Flag to install elasticsearch | `bool` | `false` | no |
| install\_etcd | Flag to install etcd | `bool` | `false` | no |
| install\_flux2 | Flag to install flux2 | `bool` | `false` | no |
| install\_goldilocks | Flag to install goldilocks | `bool` | `false` | no |
| install\_grafana | Flag to install grafana | `bool` | `false` | no |
| install\_identityserver4admin | Flag to install identityserver4-admin | `bool` | `false` | no |
| install\_jaeger | Flag to install jaeger | `bool` | `false` | no |
| install\_kafka | Flag to install kafka | `bool` | `false` | no |
| install\_keycloak | Flag to install keycloak | `bool` | `false` | no |
| install\_kibana | Flag to install kibana | `bool` | `false` | no |
| install\_linkerd | Flag to install linkerd | `bool` | `false` | no |
| install\_localstack | Flag to install localstack | `bool` | `false` | no |
| install\_loki | Flag to install Loki | `bool` | `false` | no |
| install\_mariadb | Flag to install mariadb | `bool` | `false` | no |
| install\_metrics | Flag to install metrics server | `bool` | `false` | no |
| install\_minio | Flag to install minio | `bool` | `false` | no |
| install\_mongodb | Flag to install MongoDB | `bool` | `false` | no |
| install\_mssql | Flag to install SQL Server | `bool` | `false` | no |
| install\_mysql | Flag to install mysql | `bool` | `false` | no |
| install\_opentelemetry | Flag to install opentelemetry collector | `bool` | `false` | no |
| install\_oracle | Flag to install Oracle XE | `bool` | `false` | no |
| install\_postgres | Flag to install postgres | `bool` | `false` | no |
| install\_prometheus | Flag to install prometheus | `bool` | `false` | no |
| install\_promtail | Flag to install promtail | `bool` | `false` | no |
| install\_rabbitmq | Flag to install rabbitmq | `bool` | `false` | no |
| install\_redis | Flag to install redis | `bool` | `false` | no |
| install\_seq | Flag to install seq | `bool` | `false` | no |
| install\_tempo | Flag to install tempo | `bool` | `false` | no |
| install\_traefik | Flag to install traefik | `bool` | `true` | no |
| install\_vault | Flag to install vault | `bool` | `false` | no |
| install\_vpa | Flag to install vpa | `bool` | `false` | no |
| install\_whoami | Flag to install whoami | `bool` | `false` | no |
| jaeger\_helm\_version | Override Helm version of jaeger | `string` | `""` | no |
| jaeger\_namespace | Namespace of Jaeger | `string` | `"jaeger"` | no |
| kafka\_helm\_version | Override Helm version of kafka strimzi | `string` | `""` | no |
| kafka\_namespace | Namespace of kafka | `string` | `"kafka"` | no |
| keycloak\_helm\_version | Override Helm version of keycloak | `string` | `""` | no |
| keycloak\_include\_domainrealm | Flag to include a default realm | `bool` | `false` | no |
| keycloak\_namespace | Namespace of keycloak | `string` | `"keycloak"` | no |
| linkerd\_helm\_version | Override Helm version of linkerd | `string` | `""` | no |
| linkerd\_namespace | Namespace of linkerd | `string` | `"linkerd"` | no |
| linkerdcrds\_helm\_version | Override Helm version of linkerd-crds | `string` | `""` | no |
| linkerdjaeger\_helm\_version | Override Helm version of linkerd-jaeger | `string` | `""` | no |
| linkerdviz\_helm\_version | Override Helm version of linkerd-viz | `string` | `""` | no |
| loadbalancer-ip | The IP of the loadbalancer | `string` | `"172.19.0.2"` | no |
| localstack\_helm\_version | Override Helm version of localstack | `string` | `""` | no |
| localstack\_namespace | Namespace of localstack | `string` | `"localstack"` | no |
| loki\_helm\_version | Override Helm version of loki | `string` | `""` | no |
| loki\_namespace | Namespace of loki | `string` | `"loki"` | no |
| mariadb\_helm\_version | Override Helm version of mariadb | `string` | `""` | no |
| mariadb\_namespace | Namespace of mariadb | `string` | `"mariadb"` | no |
| metrics\_helm\_version | Override Helm version of metrics-server | `string` | `""` | no |
| minio\_helm\_version | Override Helm version of minio | `string` | `""` | no |
| minio\_namespace | Namespace of minio | `string` | `"minio"` | no |
| mongodb\_helm\_version | Override Helm version of mongodb | `string` | `""` | no |
| mongodb\_namespace | Namespace of mongodb | `string` | `"mongodb"` | no |
| monitoring\_backend | Default monitoring backend | `string` | `"grafana"` | no |
| mssql\_helm\_version | Override Helm version of SQL Server | `string` | `""` | no |
| mssql\_namespace | Namespace of SQL Server | `string` | `"mssql"` | no |
| mysql\_helm\_version | Override Helm version of mysql | `string` | `""` | no |
| mysql\_namespace | Namespace of mysql | `string` | `"mysql"` | no |
| node-ips | The list of ip's of nodes in the cluster | `list(any)` | <pre>[<br>  "172.19.0.2"<br>]</pre> | no |
| opentelemetry\_helm\_version | Override Helm version of opentelemetry collector | `string` | `""` | no |
| opentelemetry\_namespace | Namespace of opentelemetry collector | `string` | `"opentelemetry"` | no |
| oracle\_namespace | Namespace of Oracle XE | `string` | `"oracle"` | no |
| oracle\_operator\_version | Version of the Oracle Operator to use | `string` | `"0.2.1"` | no |
| oracle\_xe\_version | Version of the Oracle XE server to install | `string` | `"21.3.0-xe"` | no |
| postgres\_helm\_version | Override Helm version of postgres | `string` | `""` | no |
| postgres\_namespace | Namespace of postgres | `string` | `"postgres"` | no |
| prometheus\_helm\_version | Override Helm version of prometheus | `string` | `""` | no |
| prometheus\_namespace | Namespace of prometheus | `string` | `"prometheus"` | no |
| promtail\_helm\_version | Override Helm version of promtail | `string` | `""` | no |
| rabbitmq\_helm\_version | Override Helm version of rabbitmq | `string` | `""` | no |
| rabbitmq\_namespace | Namespace of rabbitmq | `string` | `"rabbitmq"` | no |
| redis\_helm\_version | Override Helm version of redis | `string` | `""` | no |
| redis\_namespace | Namespace of redis | `string` | `"redis"` | no |
| seq\_helm\_version | Override Helm version of seq | `string` | `""` | no |
| seq\_namespace | Namespace of seq | `string` | `"seq"` | no |
| tempo\_helm\_version | Override Helm version of tempo | `string` | `""` | no |
| tempo\_namespace | Namespace of tempo | `string` | `"tempo"` | no |
| traefik\_helm\_version | Override Helm version of traefik | `string` | `""` | no |
| traefik\_namespace | Namespace of traefik | `string` | `"traefik"` | no |
| vault\_helm\_version | Override Helm version of vault | `string` | `""` | no |
| vault\_namespace | Namespace of vault | `string` | `"vault"` | no |
| vpa\_helm\_version | Override Helm version of vpa | `string` | `""` | no |
| vpa\_namespace | Namespace of vpa | `string` | `"vpa"` | no |
| whoami\_helm\_version | Override Helm version of whoami | `string` | `""` | no |
| whoami\_namespace | Namespace of whoami | `string` | `"whoami"` | no |

### Outputs

| Name | Description |
|------|-------------|
| argocd-password | ArgoCD Initial Admin password |
| elastic-password | Elasticsearch user |
| elastic-user | Elasticsearch password |
| etcd-password | Etcd Initial Admin password |
| grafana-password | Grafana Admin password |
| grafana-user | Grafana Admin user |
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