// data "kubernetes_secret" "vault-token" {
//   metadata {
//     name      = "elastic-es-es-elastic-user"
//     namespace = kubernetes_namespace.elasticsearch.metadata.0.name
//   }
//   depends_on = [
//     time_sleep.wait_x_seconds
//   ]
// }

output "vault-token" {
  value = "root"
}