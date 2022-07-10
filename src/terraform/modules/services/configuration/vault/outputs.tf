output "vault-token" {
  value = random_password.init_password.result
}