cluster-name = "devinfra"
server-node-count = 1
worker-node-count = 2

k3d-cluster-name    = ["devinfra"]

k3d-cluster-port    = 6550
k3d-cluster-ip      = "127.0.0.1"
k3s-version         = "v1.23.6-k3s1"
k3d-cluster-domain  = "k8s.local"

expose_azurite      = true
expose_jaeger       = true
expose_prometheus   = true
expose_seq          = true
expose_elasticsearch = false
expose_rabbitmq      = false
