container_definitions = jsonencode([{
  name      = var.app_name
  image     = var.venureddy3417/devops-task:v1       
  portMappings = [{
    containerPort = 3000
    hostPort      = 3000
  }]
  essential = true
  logConfiguration = {
    logDriver = "awslogs"
    options = {
      "awslogs-group"         = "/ecs/${var.app_name}"
      "awslogs-region"        = var.us-east-1
      "awslogs-stream-prefix" = "ecs"
    }
  }
}])
