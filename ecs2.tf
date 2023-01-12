#create ecs cluster

resource "aws_ecs_cluster" "project-cluster" {
  name = "project-cluster"

  setting {
    name = "containerInsights"
    value = "enabled"
  }
}

data "template_file" "helloapp" {
    template = file("./templates/nginxtask-revision1.json")
}

resource "aws_ecs_task_definition" "task-def" {
    family = "nginxtask"
    requires_compatibilities = ["FARGATE"]
    network_mode             = "awsvpc"
    cpu                      = 1024
    memory                   = 2048
    /* task_role_arn = aws_iam_role.ecs-tasks-execution-role.arn */
    execution_role_arn = aws_iam_role.ecs_tasks_execution_role.arn
    container_definitions = data.template_file.helloapp.rendered
}


resource "aws_ecs_service" "project-service" {
    name = "project-service"
    cluster = aws_ecs_cluster.project-cluster.id
    task_definition = aws_ecs_task_definition.task-def.arn
    desired_count = 2
    launch_type = "FARGATE"
    platform_version = "LATEST"
    scheduling_strategy = "REPLICA"


    network_configuration {
      security_groups = [aws_security_group.ECS-Sec-Grp.id]
      subnets = [aws_subnet.priv-sub-2.id, aws_subnet.priv-sub-1.id]
      assign_public_ip = false
    }

    load_balancer {
      target_group_arn = aws_lb_target_group.alb-target-grp.arn
      container_name = "nginxdemo"
      container_port = 80
    }

    lifecycle {
      ignore_changes = [task_definition, desired_count]
    }
}

