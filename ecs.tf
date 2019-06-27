// https://www.terraform.io/docs/providers/aws/r/ecs_cluster.html
resource "aws_ecs_cluster" "main" {
  name = var.cluster_name

  tags = {
    Name = var.cluster_name
    Project = var.project_name
    Owner = var.owner_name
  }
}

data "template_file" "service" {
  template = file("${path.module}/container_definitions.json")
  vars = {
    service_name = var.service_name
    service_image = var.service_image
    service_cpu = var.service_cpu
    service_memory = var.service_memory
    service_port = var.service_port
  }
}

// https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html
resource "aws_ecs_task_definition" "task" {
  family = var.service_name
  execution_role_arn = aws_iam_role.ecs_task_execution.id
  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE"]
  cpu = var.service_cpu
  memory = var.service_memory

  container_definitions = data.template_file.service.rendered

  //  volume {
  //    name = "${var.service_name}-storage"
  //    host_path = var.service_volume_host_path
  //    docker_volume_configuration {
  //      scope = "shared"
  //      autoprovision = true
  //    }
  //  }


}

// https://www.terraform.io/docs/providers/aws/r/ecs_service.html
resource "aws_ecs_service" "service" {
  name = var.service_name
  cluster = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count = var.service_desired_count

  launch_type = "FARGATE"

  network_configuration {
    subnets = var.service_subnets
    security_groups = var.service_security_group_ids
    assign_public_ip = var.service_assign_public_ip
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.service.arn
    container_name = var.service_name
    container_port = var.service_port
  }


  depends_on = [
    aws_lb_listener.service]
}
