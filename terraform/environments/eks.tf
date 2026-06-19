module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0" # Pins to the latest stable enterprise module architecture

  cluster_name    = "enterprise-ai-cluster"
  cluster_version = "1.30" # Uses a modern, stable Kubernetes version

  # Ensures public internet access to the control plane is limited 
  # and endpoint visibility is securely controlled
  cluster_endpoint_public_access = true

  # Attach the cluster to your network from Phase 1
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets # Places all worker computing instances inside secure private networks

  # Enable Identity Provider (OIDC) for Zero-Trust IRSA configuration
  enable_irsa = true

  # Managed Node Groups (The actual servers that run your container pods)
  eks_managed_node_groups = {
    general_nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t3.medium"] # Cost-efficient compute instances perfect for development testing
      capacity_type  = "ON_DEMAND"

      labels = {
        Environment = "dev"
        Role        = "general-compute"
      }
    }
  }
}
