# --- Terraform Configuration and Provider ---
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# --- 1. Resource: PostgreSQL Database ---

# Download PostgreSQL image from Docker Hub
resource "docker_image" "postgres_image" {
  name         = "postgres:latest"
  keep_locally = true
}

# Create and configure the PostgreSQL container
resource "docker_container" "db_container" {
  name  = "tp-db-postgres"
  image = docker_image.postgres_image.image_id

  ports {
    internal = 5432
    external = 5432
  }

  # Database configuration via environment variables
  env = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}",
  ]
}

# --- 2. Resource: Nginx Web Application ---

# Build the application image from local Dockerfile_app
resource "docker_image" "app_image" {
  name = "tp-web-app:latest"
  build {
    context    = "."
    dockerfile = "Dockerfile_app"
  }
}

# Create the web application container
resource "docker_container" "app_container" {
  name  = "tp-app-web"
  image = docker_image.app_image.image_id

  # Explicit dependency: DB must be ready before the Application
  depends_on = [
    docker_container.db_container
  ]

  # Map internal port 80 to external port defined in variables.tf (default 8080)
  ports {
    internal = 80
    external = var.app_port_external
  }
}
