variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"  
}

variable "app_name" {
  description = "Application Name"
  type        = string
  default     = "devops-task"
}  

variable "docker_image" {
  description = "Docker image to deploy"
  type        = string
  default     = "venureddy3417/devops-task:v1"  
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24","10.0.2.0/24"]  # 2 subnets for high availability
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  default     = 1
}
