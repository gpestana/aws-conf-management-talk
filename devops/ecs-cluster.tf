resource "aws_ecs_cluster" "ecs-cluster" {
  name = "ecs-cluster"
}

resource "aws_ecr_repository" "ecr" {
  name = "ec-registry"
}

# IAM and roles

data "aws_iam_policy_document" "ec2-assume-role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "container-instance-ec2" {
  name               = "ContainerInstanceProfile"
  assume_role_policy = "${data.aws_iam_policy_document.ec2-assume-role.json}"
}

resource "aws_iam_role_policy_attachment" "ec2-service-role" {
  role       = "${aws_iam_role.container-instance-ec2.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "container-instance" {
  name = "${aws_iam_role.container-instance-ec2.name}"
  role = "${aws_iam_role.container-instance-ec2.name}"
}

# Static container instance

resource "aws_instance" "container" {
  ami           = "${var.ecs-ami}"
  instance_type = "t2.micro"

  user_data = <<USERDATA
#!/bin/bash
echo ECS_CLUSTER=ecs-cluster >> /etc/ecs/ecs.config
USERDATA

  iam_instance_profile = "${aws_iam_instance_profile.container-instance.name}"
}
