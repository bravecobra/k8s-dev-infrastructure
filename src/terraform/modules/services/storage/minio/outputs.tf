output "minio-password" {
  value = random_password.init_password.result
}