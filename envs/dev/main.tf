locals {
  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

module "kms" {
  source       = "../../modules/kms"
  project_name = var.project_name
  environment  = var.environment
  tags         = local.tags
}

module "vpc" {
  source             = "../../modules/vpc"
  project_name       = var.project_name
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  azs                = var.azs
  enable_nat_gateway = true
  tags               = local.tags
}

module "iam" {
  source       = "../../modules/iam"
  project_name = var.project_name
  environment  = var.environment
  tags         = local.tags
}

module "s3_assets" {
  source        = "../../modules/s3"
  project_name  = var.project_name
  environment   = var.environment
  bucket_suffix = "assets"
  kms_key_arn   = module.kms.key_arn
  tags          = local.tags
}

module "alb" {
  source            = "../../modules/alb"
  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  tags              = local.tags
}

module "rds" {
  source                  = "../../modules/rds"
  project_name            = var.project_name
  environment             = var.environment
  vpc_id                  = module.vpc.vpc_id
  private_subnet_ids      = module.vpc.private_subnet_ids
  allowed_security_groups = [module.alb.alb_security_group_id]
  db_name                 = "myappdb"
  db_username             = "adminuser"
  db_password             = "SecurePassword123!" # In real world, use Secrets Manager
  kms_key_arn             = module.kms.key_arn
  tags                    = local.tags
}

module "compute" {
  source                = "../../modules/ec2"
  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  iam_instance_profile  = module.iam.ec2_instance_profile_name
  alb_security_group_id = module.alb.alb_security_group_id
  target_group_arn      = module.alb.target_group_arn
  kms_key_arn           = module.kms.key_arn
  user_data             = <<-EOF
              #!/bin/bash
              echo "Hello from Terraform Platform" > index.html
              nohup python3 -m http.server 80 &
              EOF
  tags                  = local.tags
}

module "monitoring" {
  source         = "../../modules/monitoring"
  project_name   = var.project_name
  environment    = var.environment
  asg_name       = module.compute.asg_name
  db_instance_id = "${var.project_name}-${var.environment}-db"
}
