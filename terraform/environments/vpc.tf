module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0" # Pins the module to a stable version release

  name = "enterprise-ai-vpc"
  cidr = var.vpc_cidr

  # Multi-AZ Distribution Strategy
  azs             = var.availability_zones
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"] # Secure subnets for EKS Pods and Bedrock endpoints
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"] # Exposed subnets for Application Load Balancers

  # Secure Traffic Infrastructure Management
  enable_nat_gateway     = true
  single_nat_gateway     = true # Cost-saving design choice for development environments
  one_nat_gateway_per_az = false
  enable_vpn_gateway     = false

  # Core DNS Settings needed for EKS and OpenSearch resolution
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Enterprise Kubernetes Mapping Tags
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1" # Explicitly allows the AWS ALB controller to discover these public subnets
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1" # Explicitly allows internal load balancing
  }
}
