module "networking" {
  source = "./modules/networking"

  name_prefix           = local.name_prefix
  vpc_cidr              = var.vpc_cidr
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  tags                  = local.common_tags
}

# Modulo EKS
module "eks" {
  source = "./modules/eks"

  cluster_name       = var.eks_cluster_name
  cluster_version    = var.eks_version
  name_prefix        = local.name_prefix
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  instance_types     = var.node_instance_types
  desired_size       = var.node_desired_size
  min_size           = var.node_min_size
  max_size           = var.node_max_size
  tags               = local.common_tags
}

# Modulos de dados RDS, Redis e DynamoDB
module "data" {
  source = "./modules/data"

  name_prefix         = local.name_prefix
  vpc_id              = module.networking.vpc_id
  private_subnet_ids  = module.networking.private_subnet_ids
  database_subnet_ids = module.networking.database_subnet_ids
  rds_instances       = local.rds_instances
  db_username         = var.db_username
  db_password         = var.db_password
  db_instance_class   = var.db_instance_class
  redis_node_type     = var.redis_node_type
  dynamodb_table_name = "ToggleMasterAnalytics"
  tags                = local.common_tags
}

# Modulo SQS
module "messaging" {
  source = "./modules/messaging"

  queue_name = var.sqs_queue_name
  tags       = local.common_tags
}

# Modulo ECR
module "ecr" {
  source = "./modules/ecr"

  repositories = var.ecr_repositories
  tags         = local.common_tags
}

# Modulo ArgoCD
module "argocd" {
  source = "./modules/argocd"
}

