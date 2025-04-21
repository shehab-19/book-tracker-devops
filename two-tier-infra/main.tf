module "vpc-networking" {
  source = "./modules/networking"
  vpc-name = "my-vpc-2"
}

module "security" {
    source = "./modules/security"
    vpc-id = module.vpc-networking.vpc_id
    make_bastion = true
    bastion-public-subnet = module.vpc-networking.public_subnet_ids[0]
    user_data = "bastion.sh"
    
}

module "auto-scaling-group" {
  source = "./modules/auto-scaling-group"
  vpc-id = module.vpc-networking.vpc_id
  key_name = module.security.aws_key_pair_name
  web_sg = module.security.web-security_group_id
  alb_sg = module.security.lb-security_group_id
  public_subnet_ids = module.vpc-networking.public_subnet_ids
  max_size = 3
  min_size = 2
  desired_capacity = 2
}


module "database" {
  source = "./modules/database"
  db-name = "bookstore"
  db-identifier = "database01"
  db_sg = module.security.db-security_group_id
  db-subnets = module.vpc-networking.public_subnet_ids
  db-username = module.security.ssm_db_username
  db-password = module.security.ssm_db_password
}
