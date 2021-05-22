resource "null_resource" "create-certificate-crt" {
  provisioner "local-exec" {
    command = "mkcert -cert-file ${var.domain-name}.crt -key-file ${var.domain-name}.key ${var.domain-name} *.${var.domain-name} infrastructure.${var.domain-name} *.infrastructure.${var.domain-name}"
    working_dir = "./certs"
    interpreter = ["PowerShell", "-Command"]
  }
}

resource "null_resource" "create-certificate-pkcs12" {
  provisioner "local-exec" {
    command = "mkcert -pkcs12 ${var.domain-name}.pfx ${var.domain-name} *.${var.domain-name} *.${var.domain-name} infrastructure.${var.domain-name} *.infrastructure.${var.domain-name}"
    working_dir = "./certs"
    interpreter = ["PowerShell", "-Command"]
  }
}

resource "kubernetes_secret" "traefik_cert" {
  metadata {
    name = "traefik-cert"
    namespace = "infrastructure"
  }
  data = {
      "tls.crt" = file("./certs/${var.domain-name}.crt")
      "tls.key" = file("./certs/${var.domain-name}.key")
  }
  depends_on = [
    null_resource.create-certificate-crt
  ]
  type = "kubernetes.io/tls"
}

resource "helm_release" "traefik" {
  name       = "traefik"

  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"
  values = [
    "${file("${path.module}/traefik-values.yaml")}"
  ]
}

# resource "kubernetes_manifest" "tls-store" {
#   provider = kubernetes-alpha
#   manifest = yamldecode(file("${path.module}/certs.yaml"))
#   depends_on = [
#     helm_release.traefik
#   ]
# }

# resource "kubernetes_manifest" "route_dashboard" {
#   provider = kubernetes-alpha
#   manifest = yamldecode(file("${path.module}/dashboard.yaml"))
#   depends_on = [
#     helm_release.traefik
#   ]
# }