cluster-name = "devinfra"
server-node-count = 1
worker-node-count = 2

k3d-cluster-name    = ["devinfra"]

k3d-cluster-port    = 6550
k3d-cluster-ip      = "127.0.0.1"
k3s-version         = "v1.23.6-k3s1"
k3d-cluster-domain  = "k8s.local"

expose_azurite      = false
expose_seq          = false
expose_opentelemetry = true
expose_jaeger       = false
expose_prometheus   = false
expose_elasticsearch = false
expose_rabbitmq      = false
expose_loki         = true
