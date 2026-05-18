output "vpc_id" {
  value = module.networking.vpc_id
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "rds_endpoints" {
  value     = module.data.rds_endpoints
}

output "redis_primary_endpoint" {
  value = module.data.redis_primary_endpoint
}

output "dynamodb_table_name" {
  value = module.data.dynamodb_table_name
}

output "sqs_queue_url" {
  value = module.messaging.queue_url
}

output "ecr_repository_urls" {
  value = module.ecr.repository_urls
}