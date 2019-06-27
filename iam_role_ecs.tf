data "aws_iam_policy_document" "ecs_task_execution_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com"]
    }
  }
}


// https://www.terraform.io/docs/providers/aws/r/iam_service_linked_role.html
//resource "aws_iam_service_linked_role" "ecs_task_execution" {
//  aws_service_name = "ecs-tasks.amazonaws.com"
//}


// https://www.terraform.io/docs/providers/aws/r/iam_role.html
resource "aws_iam_role" "ecs_task_execution" {
  name = "ecs.${var.cluster_name}.task_execution"

  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume_role_policy.json

  tags = {
    Name = "${var.cluster_name}.task_execution"
    Cluster = var.cluster_name
    Project = var.project_name
    Owner = var.owner_name
  }
}

// https://www.terraform.io/docs/providers/aws/r/iam_role_attachment.html
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role = aws_iam_role.ecs_task_execution.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


data "aws_iam_policy_document" "ecs_autoscale_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com"]
    }
  }
}
