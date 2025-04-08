module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source = "./modules/subnets"

  vpc_id                  = module.vpc.vpc_id
  availability_zones      = ["us-east-1a", "us-east-1b"]
  public_subnet_cidr_az1  = "10.0.1.0/24"
  public_subnet_cidr_az2  = "10.0.2.0/24"
  private_subnet_cidr_az1 = "10.0.11.0/24"
  private_subnet_cidr_az2 = "10.0.12.0/24"
}

module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source               = "./modules/route_table"
  vpc_id               = module.vpc.vpc_id
  internet_gateway_id  = module.igw.internet_gateway_id
  public_subnet_az1_id = module.subnets.public_subnet_az1_id
  public_subnet_az2_id = module.subnets.public_subnet_az2_id
}

module "private_route_table" {
  source                = "./modules/private_route_table"
  subnet_id             = module.subnets.public_subnet_az1_id
  vpc_id                = module.vpc.vpc_id
  private_subnet_az1_id = module.subnets.private_subnet_az1_id
  private_subnet_az2_id = module.subnets.private_subnet_az2_id
  depends_on            = [module.route_table]
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "data_source" {
  source = "./modules/data_source"
}

module "ec2_instances" {
  source = "./modules/ec2_instances"

  ami_id                = module.data_source.image_id
  instance_type         = var.instance_type
  public_subnet_az1_id  = module.subnets.public_subnet_az1_id
  public_subnet_az2_id  = module.subnets.public_subnet_az2_id
  private_subnet_az1_id = module.subnets.private_subnet_az1_id
  private_subnet_az2_id = module.subnets.private_subnet_az2_id
  key_name              = var.key_name
  instances_sg_id       = module.security_groups.instances_sg_id
  private_key_path      = var.private_key_path
  private_lb_dns        = module.load_balancers.private_lb_dns_name
}

module "load_balancers" {
  source          = "./modules/load_balancers"
  project_name    = "myapp"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = [module.subnets.public_subnet_az1_id, module.subnets.public_subnet_az2_id]
  private_subnets = [module.subnets.private_subnet_az1_id, module.subnets.private_subnet_az2_id]
  public_instance_ids = {
    az1 = module.ec2_instances.public_ec2_az1_id
    az2 = module.ec2_instances.public_ec2_az2_id
  }
  private_instance_ids = {
    az1 = module.ec2_instances.private_ec2_az1_id
    az2 = module.ec2_instances.private_ec2_az2_id
  }
  public_lb_sg_id  = module.security_groups.lb_sg_id
  private_lb_sg_id = module.security_groups.lb_sg_id
}

module "S3" {
  source = "./modules/S3"
}

module "DynamoDB" {
  source = "./modules/DynamoDB"
}
