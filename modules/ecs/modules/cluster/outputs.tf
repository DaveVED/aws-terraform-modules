output "cluster_id" {
  value       = aws_ecs_cluster.ecs.id
  description = "AWS ECS Cluster ID."
}