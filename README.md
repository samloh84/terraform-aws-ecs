# Terraform AWS Bastion - Centos

Terraform module for creating an autoscaling group of CentOS Bastion hosts on AWS. 

## Usage

```hcl-terraform
module "eks" {
  source = "git::https://github.com/samloh84/terraform-aws-eks.git"
  cluster_name = "kubernetes"
  control_plane_subnet_ids = "${module.vpc_simple.subnet_application_tier_ids}"
  kubernetes_version = "1.12"
  owner_name = "Samuel"
  project_name = "kubernetes"
  vpc_id = "${module.vpc_simple.vpc_id}"
  vpc_name = "kubernetes"
  worker_node_bootstrap_extra_args = ""
  worker_node_desired_capacity = "1"
  worker_node_instance_type = "t3.small"
  worker_node_key_name = "kubernetes"
  worker_node_kubelet_extra_args = ""
  worker_node_max_size = "1"
  worker_node_min_size = "1"
  worker_node_post_commands = ""
  worker_node_pre_commands = ""
  worker_node_subnet_ids = "${module.vpc_simple.subnet_application_tier_ids}"
  worker_node_volume_size = "200"
}
```

## License
[MIT](https://choosealicense.com/licenses/mit/)
