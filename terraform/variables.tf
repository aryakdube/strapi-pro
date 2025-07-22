variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "ami_id" {
  description = "AMI ID for EC2 (Ubuntu 22.04)"
  type        = string
  default     = "ami-0d1b5a8c13042c939"  
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "AWS EC2 KeyPair name"
  type        = string
  default     = "aryak_login"  
}
variable "image_tag" {
  description = "Docker image tag to deploy"
  type        = string
  default     = "latest"
}
