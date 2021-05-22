resource "kubernetes_namespace" "infrastructure" {
  metadata {
    name = "infrastructure"
  }
}

// resource "null_resource" "example2" {
//   provisioner "local-exec" {
//     command = "Get-Date > completed.txt"
//     interpreter = ["PowerShell", "-Command"]
//   }
// }

module "traefik" {
  source = "./modules/traefik"
  domain-name = var.domain-name
}