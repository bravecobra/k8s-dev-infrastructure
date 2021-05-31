resource "helm_release" "cert-manager" {
  name       = "cert-manager"

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = "cert-manager"
  version    = "v1.3.1"
  create_namespace = true
  wait       = true
  wait_for_jobs = true
  set {
    name  = "installCRDs"
    value = "true"
  }
  provisioner "local-exec" {
    command = "echo 'Waiting for cert-manager validating webhook to get its CA injected, so we can start to apply custom resources ...' ; timeout 60"
  }
}

resource "kubernetes_secret" "ca-key-pair" {
  metadata {
    name = "ca-key-pair"
    namespace = "cert-manager"
  }
  data = {
    "tls.crt" = file("./certs/cacerts.crt")
    "tls.key" = file("./certs/cacerts.key")
  }
  type = "kubernetes.io/tls"
}

resource "kubectl_manifest" "cluster-issuer" {
    depends_on = [
        helm_release.cert-manager,
        kubernetes_secret.ca-key-pair
    ]
    yaml_body = file("${path.module}/cluster-issuer.yaml")
}