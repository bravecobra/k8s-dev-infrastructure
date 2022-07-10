output "ca-cert" {
  description = "CA certificate"
  value       = data.local_file.ca-cert.content
}