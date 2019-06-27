variable "cluster_name" {}
variable "lb_listener_port" {}
variable "lb_security_group_ids" {}
variable "lb_subnet_ids" {
  type = "list"
}
variable "owner_name" {}
variable "project_name" {}
variable "service_assign_public_ip" {
  default = false
}
variable "service_cpu" {
  default = "1024"
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
}
variable "service_desired_count" {}
variable "service_image" {}
variable "service_memory" {
  default = "2048"
  description = "Fargate instance memory to provision (in MiB)"
}
variable "service_name" {}
variable "service_port" {}
variable "service_security_group_ids" {
  type = "list"
}
variable "service_subnets" {
  type = "list"
}
variable "service_volume_host_path" {}
variable "vpc_id" {}
