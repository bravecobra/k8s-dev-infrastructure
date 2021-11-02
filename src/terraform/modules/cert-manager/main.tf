resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
}


resource "helm_release" "cert-manager" {
  name = "cert-manager"

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = "cert-manager"
  version    = var.helm_release
  // wait       = true
  // wait_for_jobs = true
  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [
    kubernetes_namespace.cert-manager
  ]
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

resource "time_sleep" "wait_10_seconds" {
  depends_on = [
    helm_release.cert-manager,
    kubernetes_secret.ca-key-pair
  ]

  create_duration = "10s"
}

resource "kubectl_manifest" "cluster-issuer" {
  depends_on = [
    time_sleep.wait_10_seconds
  ]
  yaml_body = file("${path.module}/cluster-issuer.yaml")
}