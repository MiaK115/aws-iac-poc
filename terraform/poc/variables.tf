variable "project_name" {
  description = "A short name used for tagging and resource names."
  type        = string
  default     = "retail-poc"
}

variable "region" {
  description = "AWS region to deploy to."
  type        = string
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones to use."
  type        = number
  default     = 2
}

variable "public_subnet_bits" {
  description = "New bits for calculating public subnet CIDRs."
  type        = number
  default     = 8
}

variable "private_subnet_bits" {
  description = "New bits for calculating private subnet CIDRs."
  type        = number
  default     = 8
}

variable "instance_type" {
  description = "EC2 instance type for app servers."
  type        = string
  default     = "t3.micro"
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances."
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Min size of the ASG."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Max size of the ASG."
  type        = number
  default     = 2
}

variable "db_username" {
  description = "Master username for RDS."
  type        = string
  default     = "appuser"
}

variable "db_password" {
  description = "Master password for RDS."
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Initial database name."
  type        = string
  default     = "appdb"
}

variable "enable_waf" {
  description = "Attach an AWS WAF WebACL with managed rules to the ALB."
  type        = bool
  default     = false
}

variable "allow_ssh_cidr" {
  description = "CIDR allowed to SSH to EC2 (set to your IP or keep empty to disable)."
  type        = string
  default     = ""
}

variable "enable_alb_access_logs" {
  description = "Enable ALB access logs to S3."
  type        = bool
  default     = false
}

variable "alb_logs_bucket_name" {
  description = "Existing S3 bucket name to store ALB access logs (required if enable_alb_access_logs=true)."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Common tags to apply to all resources."
  type        = map(string)
  default = {
    "project" = "retail-poc"
    "owner"   = "student"
    "env"     = "poc"
  }
}
