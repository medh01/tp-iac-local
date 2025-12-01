output "db_container_name" {
  description = "Name of the database container."
  value       = docker_container.db_container.name
}

output "db_container_id" {
  description = "ID of the database container."
  value       = docker_container.db_container.id
}

output "app_container_name" {
  description = "Name of the web application container."
  value       = docker_container.app_container.name
}

output "app_access_url" {
  description = "URL to access the web application."
  value       = "http://localhost:${var.app_port_external}"
}
