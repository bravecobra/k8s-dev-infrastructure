resource "kubectl_manifest" "seq-cert" {
  yaml_body = templatefile("${path.module}/templates/seq-cert.yaml", {
    domain-name = var.domain-name
    namespace   = var.namespace
  })
}

resource "helm_release" "seq" {
  name       = "seq"
  chart      = "seq"
  repository = "https://helm.datalust.co"
  version    = var.helm_release
  namespace  = var.namespace
  values = [
    templatefile("${path.module}/seq-values.yaml", {
      domain-name = var.domain-name
    }),
  ]
}

resource "helm_release" "fluent" {
  name       = "fluent"
  chart      = "fluent-bit"
  repository = "https://fluent.github.io/helm-charts"
  version    = var.fluent_helm_release
  namespace  = var.namespace
  values = [
    templatefile("${path.module}/fluent-values.yaml", {
      namespace            = var.namespace,
      FLUENT_GELF_HOST     = "seq.${var.namespace}.svc.cluster.local",
      FLUENT_GELF_PORT     = "12201",
      FLUENT_GELF_PROTOCOL = "tcp",
    }),
  ]
  depends_on = [
    helm_release.seq
  ]
}

resource "kubectl_manifest" "seq_ingestion" {
  count = var.expose_ingestion ? 1 : 0
  yaml_body = templatefile("${path.module}/templates/seq-ingestion-route.yaml", {
    namespace   = var.namespace,
    domain-name = var.domain-name
  })
  depends_on = [
    helm_release.seq
  ]
}
