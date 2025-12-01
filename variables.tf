# --- Database Variables (PostgreSQL) ---
variable "db_name" {
  description = "Name of the PostgreSQL database."
  type        = string
  default     = "devops_db"
}

variable "db_user" {
  description = "PostgreSQL username."
  type        = string
  default     = "devops_user"
}

variable "db_password" {
  description = "PostgreSQL password (WARNING: Simulated, do not use in Production!)"
  type        = string
  default     = "strongpassword123"
  sensitive   = true
}

# --- Application Variables ---
variable "app_port_external" {
  description = "External port to access the web application (mapped to internal port 80)."
  type        = number
  default     = 8081
}
