output "redis-password" {
  value     = random_password.init_password.result
  sensitive = true
}