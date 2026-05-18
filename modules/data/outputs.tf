output "rds_endpoints" {
  value = {
    for k, v in aws_db_instance.postgres : k => v.address
  }
}

output "redis_primary_endpoint" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.analytics.name
}