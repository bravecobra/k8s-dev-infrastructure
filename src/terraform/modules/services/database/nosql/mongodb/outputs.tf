output "mongodb-root-password" {
  value = random_password.init_password.result
}