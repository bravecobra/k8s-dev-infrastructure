output "keycloak-password" {
  value     = random_password.init_password.result
  sensitive = true
}