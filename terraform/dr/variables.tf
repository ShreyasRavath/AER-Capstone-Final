
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "aer-cluster-dr"
}

variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-2"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "prod"
}
