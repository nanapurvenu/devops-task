output "alb_dns_name" {
  value = aws_lb.alb.dns_name   # public URL of your app
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.cluster.name
}

output "ecs_service_name" {
  value = aws_ecs_service.service.name
}

output "task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}
