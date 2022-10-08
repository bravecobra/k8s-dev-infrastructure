cluster-name             = "devinfra"
worker-node-count        = 0
install_private_registry = true
kind_version             = "v1.24.3"

kind-network-subnet  = "172.19.0.0/16"
kind-network-gateway = "172.19.0.1"

# expose_azurite       = true # http port (but needs 127.0.0.1/ ip port 1000x)

# expose_jaeger        = true # ingestion port udp
# expose_seq           = true # ingestion port
# expose_loki          = true # ingestion port
# expose_opentelemetry = true # ingestion port

# expose_rabbitmq      = true # amqp