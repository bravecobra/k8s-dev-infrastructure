Push-Location src/clusters/k3d
terraform init --upgrade
Pop-Location
Push-Location src/clusters/kind
terraform init --upgrade
Pop-Location
Push-Location src/terraform
terraform init --upgrade
Pop-Location

terraform-docs markdown table "./src/terraform" --output-file "../../docs/terraform-specs.md"
terraform-docs markdown table "./src/clusters/k3d" --output-file "../../../docs/clusters/k3s.md"
terraform-docs markdown table "./src/clusters/kind" --output-file "../../../docs/clusters/kind.md"

# monitoring
terraform-docs markdown table "./src/terraform/modules/monitoring/dashboard" --output-file "../../../../../docs/specs/dashboard.md"
terraform-docs markdown table "./src/terraform/modules/monitoring/goldilocks" --output-file "../../../../../docs/specs/goldilocks.md"
terraform-docs markdown table "./src/terraform/modules/monitoring/ingestion/opentelemetry" --output-file "../../../../../../docs/specs/opentelemetry.md"
terraform-docs markdown table "./src/terraform/modules/monitoring/logging/loki" --output-file "../../../../../../docs/specs/loki.md"
terraform-docs markdown table "./src/terraform/modules/monitoring/logging/seq" --output-file "../../../../../../docs/specs/seq.md"
terraform-docs markdown table "./src/terraform/modules/monitoring/metrics/metrics" --output-file "../../../../../../docs/specs/metrics.md"
terraform-docs markdown table "./src/terraform/modules/monitoring/metrics/prometheus" --output-file "../../../../../../docs/specs/prometheus.md"
terraform-docs markdown table "./src/terraform/modules/monitoring/tracing/jaeger" --output-file "../../../../../../docs/specs/jaeger.md"
terraform-docs markdown table "./src/terraform/modules/monitoring/tracing/tempo" --output-file "../../../../../../docs/specs/tempo.md"
terraform-docs markdown table "./src/terraform/modules/monitoring/vpa" --output-file "../../../../../docs/specs/vpa.md"
# networking
terraform-docs markdown table "./src/terraform/modules/networking/cert-manager" --output-file "../../../../../docs/specs/cert-manager.md"
terraform-docs markdown table "./src/terraform/modules/networking/coredns" --output-file "../../../../../docs/specs/coredns.md"
terraform-docs markdown table "./src/terraform/modules/networking/linkerd" --output-file "../../../../../docs/specs/linkerd.md"
terraform-docs markdown table "./src/terraform/modules/networking/traefik" --output-file "../../../../../docs/specs/traefik.md"
# services
terraform-docs markdown table "./src/terraform/modules/services/caching/redis" --output-file "../../../../../../docs/specs/redis.md"
terraform-docs markdown table "./src/terraform/modules/services/cloud/localstack" --output-file "../../../../../../docs/specs/localstack.md"
terraform-docs markdown table "./src/terraform/modules/services/configuration/etcd" --output-file "../../../../../../docs/specs/etcd.md"
terraform-docs markdown table "./src/terraform/modules/services/configuration/vault" --output-file "../../../../../../docs/specs/vault.md"
terraform-docs markdown table "./src/terraform/modules/services/database/nosql/mongodb" --output-file "../../../../../../../docs/specs/mongodb.md"
terraform-docs markdown table "./src/terraform/modules/services/database/rds/mariadb" --output-file "../../../../../../../docs/specs/mariadb.md"
terraform-docs markdown table "./src/terraform/modules/services/database/rds/mysql" --output-file "../../../../../../../docs/specs/mysql.md"
terraform-docs markdown table "./src/terraform/modules/services/database/rds/oracle-xe" --output-file "../../../../../../../docs/specs/oracle-xe.md"
terraform-docs markdown table "./src/terraform/modules/services/database/rds/postgres" --output-file "../../../../../../../docs/specs/postgres.md"
terraform-docs markdown table "./src/terraform/modules/services/database/rds/sqlserver" --output-file "../../../../../../../docs/specs/sqlserver.md"
terraform-docs markdown table "./src/terraform/modules/services/deployment/argocd" --output-file "../../../../../../docs/specs/argocd.md"
terraform-docs markdown table "./src/terraform/modules/services/deployment/flux2" --output-file "../../../../../../docs/specs/flux2.md"
terraform-docs markdown table "./src/terraform/modules/services/messaging/kafka" --output-file "../../../../../../docs/specs/kafka.md"
terraform-docs markdown table "./src/terraform/modules/services/messaging/rabbitmq" --output-file "../../../../../../docs/specs/rabbitmq.md"
terraform-docs markdown table "./src/terraform/modules/services/search/elasticsearch" --output-file "../../../../../../docs/specs/elasticsearch.md"
terraform-docs markdown table "./src/terraform/modules/services/security/auth/identityserver4-admin" --output-file "../../../../../../../docs/specs/identityserver4-admin.md"
terraform-docs markdown table "./src/terraform/modules/services/security/auth/keycloak" --output-file "../../../../../../../docs/specs/keycloak.md"
terraform-docs markdown table "./src/terraform/modules/services/storage/azurite" --output-file "../../../../../../docs/specs/azurite.md"
terraform-docs markdown table "./src/terraform/modules/services/storage/docker" --output-file "../../../../../../docs/specs/docker.md"
terraform-docs markdown table "./src/terraform/modules/services/storage/minio" --output-file "../../../../../../docs/specs/minio.md"
#versions
terraform-docs markdown table "./src/terraform/modules/utils/chartversions" --output-file "../../../../../docs/specs/chartversions.md"