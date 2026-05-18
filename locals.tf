locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
  }

  rds_instances = {
    flags_db = {
      identifier = "${local.name_prefix}-flags-db"
      db_name    = "flags_db"
    }
    auth_db = {
      identifier = "${local.name_prefix}-auth-db"
      db_name    = "auth_db"
    }
    targeting_db = {
      identifier = "${local.name_prefix}-targeting-db"
      db_name    = "targeting_db"
    }
  }
}