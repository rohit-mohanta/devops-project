provider "aws" {
  region = var.region
  
} 

module "vpc" {
  source = "./modules/vpc"
  region = var.region
  project_name = var.project_name
  vpc_cidr = var.vpc_cidr
  public_subnet_az1_cidr = var.public_subnet_az1_cidr
  public_subnet_az2_cidr = var.public_subnet_az2_cidr
  private_subnet_az1_cidr = var.private_subnet_az1_cidr
  private_subnet_az2_cidr = var.private_subnet_az2_cidr
}

module "nat_gateway" {
  source = "./modules/nat-gateway"
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  internet_gateway = module.vpc.internet_gateway
  vpc_id = module.vpc.vpc_id
  private_subnet_az1_id = module.vpc.private_subnet_az1_id
}

module "security-groups" {
  source = "./modules/security-groups"
  vpc_id = module.vpc.vpc_id
  project_name = var.project_name
}

resource "aws_key_pair" "rohit_456_auth" {
  key_name = "auth"
  public_key = file("~/.ssh/id_ed25519.pub")
}
module "ec2_instance_bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "bastion-instance"

  ami                    = "ami-0149b2da6ceec4bb0"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.rohit_456_auth.id
  monitoring             = false
  vpc_security_group_ids = [module.security-groups.bastion_host_SG_id]
  subnet_id              = module.vpc.public_subnet_az1_id

  tags = {
    Name = "${var.project_name}-bastion-instance"
  }
}

module "ec2_instance_jenkins" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "jenkins-instance"

  ami                    = "ami-0149b2da6ceec4bb0"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.rohit_456_auth.id
  monitoring             = false
  vpc_security_group_ids = [module.security-groups.private_instances_SG_id]
  subnet_id              = module.vpc.private_subnet_az1_id

  tags = {
    Name = "${var.project_name}-jenkins-instance"
  }
}

module "ec2_instance_app" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "app-instance"

  ami                    = "ami-0149b2da6ceec4bb0"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.rohit_456_auth.id
  monitoring             = false
  vpc_security_group_ids = [module.security-groups.private_instances_SG_id]
  subnet_id              = module.vpc.private_subnet_az1_id

  tags = {
    Name = "${var.project_name}-app-instance"
  }
}