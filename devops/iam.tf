resource "aws_iam_role" "task-confs-read-role" {
  name = "task_role_confs"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "task-get-conf" {
  name  = "task_get_confs_attachmnet"
  roles = ["${aws_iam_role.task-confs-read-role.name}"]

  #AWS managed policy: Provides read only access to all buckets via the AWS Management Console.
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
