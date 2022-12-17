# k3s
cluster-context-name = "k3d-k3s-default"
domain-name          = "k8s.local"
loadbalancer-ip      = "172.18.0.6"
cluster-type         = "k3s"
node-ips = [
  "172.18.0.2",
  "172.18.0.3",
  "172.18.0.4"
]

install_whoami = true
