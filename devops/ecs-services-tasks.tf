# foo service and task definition

resource "aws_ecs_service" "foo" {
  name            = "foo-service"
  cluster         = "${aws_ecs_cluster.ecs-cluster.id}"
  task_definition = "${aws_ecs_task_definition.foo.arn}"
  desired_count   = 1
}

resource "aws_ecs_task_definition" "foo" {
  family                = "foo"
  container_definitions = <<DEFINITION
[
  {
    "cpu": 128,
    "environment": [],
    "essential": true,
    "image": "${var.foo_image}",
    "memory": 128,
    "memoryReservation": 64,
    "name": "foo"
  }
]
DEFINITION
}



# bar service and task definition

resource "aws_ecs_service" "bar" {
  name            = "bar-service"
  cluster         = "${aws_ecs_cluster.ecs-cluster.id}"
  task_definition = "${aws_ecs_task_definition.bar.arn}"
  desired_count   = 1
}

resource "aws_ecs_task_definition" "bar" {
  family                = "bar"
  container_definitions = <<DEFINITION
[
  {
    "cpu": 128,
    "environment": [],
    "essential": true,
    "image": "${var.bar_image}",
    "memory": 128,
    "memoryReservation": 64,
    "name": "bar"
  }
]
DEFINITION
}


