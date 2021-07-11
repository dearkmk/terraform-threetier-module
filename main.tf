# In this file a module "Threetier" is being created hence provider 
# details needs to be mentioned 
# provider details also.
# Here I have used an existing module "vpc" to create a vpc

provider "aws" {
 region       = "${var.aws_region}"
 access_key   = "${var.aws_accesskey}"
 secret_key   = "${var.aws_secretkey}"
}

# "Threetier" is a module / directory which contains the code to build a
# 3 tier architecture. It creates 1 web server, 2 app servers and 1 
# database server (RDS db). A security group "allow_all" is also being
# created.  
module "Threetier" {
    source = ".//Threetier"    
    privatekeypath = "${var.privatekeypath}"
    accesskey = "${var.aws_accesskey}"
    secretkey = "${var.aws_secretkey}"
    region    = "${var.aws_region}"      
}

# The following module is used to create a VPC

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}