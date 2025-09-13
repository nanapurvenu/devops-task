# App Name
variable "app_name" {
  description = "Name of the ECS application"
  type        = string
  default     = "devops-task-app"
}

# Docker Image
variable "docker_image" {
  description = "Docker image for ECS container"
  type        = string
  default     = "venureddy3417/devops-task:v1"  
}

# AWS Region

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

# Optional: Desired ECS task count

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}

