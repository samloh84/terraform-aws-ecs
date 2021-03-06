module "vpc-simple" {
  source = "git::https://github.com/samloh84/terraform-aws-vpc-simple.git"
  vpc_cidr_block = "10.0.0.0/16"
  remote_management_cidrs = [
    "0.0.0.0/0"]
  vpc_name = "vpc-simple"
  vpc_owner = "Samuel"
}


module "ecs" {

  source = "../../../"
  cluster_name = "ecs-test"
  lb_listener_port = "80"
  lb_security_group_ids = [module.vpc-simple.security_group_web_tier_id]
  lb_subnet_ids = module.vpc-simple.subnet_web_tier_ids
  owner_name = "samuel"
  project_name = "ecs-test"
  service_desired_count = 1
  service_image = "nginx:latest"
  service_name = "nginx"
  service_port = "80"
  service_security_group_ids = [module.vpc-simple.security_group_application_tier_id]
  service_subnets = module.vpc-simple.subnet_application_tier_ids
  service_volume_host_path = ""
  vpc_id = module.vpc-simple.vpc_id
}
