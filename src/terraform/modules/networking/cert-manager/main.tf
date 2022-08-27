resource "helm_release" "cert-manager" {
  name = "cert-manager"

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = var.namespace
  version    = var.helm_release
  // wait       = true
  // wait_for_jobs = true
  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "kubernetes_secret" "ca-key-pair" {
  metadata {
    name      = "ca-key-pair"
    namespace = "cert-manager"
  }
  data = {
    "tls.crt" = file("../certs/cacerts.crt")
    "tls.key" = file("../certs/cacerts.key")
  }
  type = "kubernetes.io/tls"
}

resource "time_sleep" "wait_x_seconds" {
  depends_on = [
    helm_release.cert-manager,
    kubernetes_secret.ca-key-pair
  ]

  create_duration = "20s"
}

resource "kubectl_manifest" "cluster-issuer" {
  depends_on = [
    time_sleep.wait_x_seconds
  ]
  yaml_body = file("${path.module}/templates/cluster-issuer.yaml")
}