variable "name_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "database_subnet_ids" {
  type = list(string)
}

variable "rds_instances" {
  type = map(object({
    identifier = string
    db_name    = string
  }))
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_instance_class" {
  type = string
}

variable "redis_node_type" {
  type = string
}

variable "dynamodb_table_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}