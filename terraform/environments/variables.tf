variable "vpc_cidr" {
  description = "The main IP range block for the entire Amazon VPC network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "The geographical AWS availability zones used for multi-AZ high availability"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
