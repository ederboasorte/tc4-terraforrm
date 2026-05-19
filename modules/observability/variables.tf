variable "namespace" {
  type    = string
  default = "observability"
}

variable "cluster_name" {
  type = string
}

variable "grafana_admin_password" {
  type      = string
  sensitive = true
}