provider "aws" {
  profile = "${var.aws_profile}"
}

resource "aws_iam_user" "s3-user" {
  name = "${var.iam_user_name}"
}

resource "aws_iam_access_key" "s3-user" {
  user = "${aws_iam_user.s3-user.name}"
}

resource "aws_iam_user_policy" "s3-policy" {
  name = "s3-policy"
  user = "${aws_iam_user.s3-user.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1532723878817",
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

output "user_name" {
  value = "${aws_iam_user.s3-user.name}"
}

output "key_id" {
  value = "${aws_iam_access_key.s3-user.id}"
}

output "secret" {
  value = "${aws_iam_access_key.s3-user.secret}"
}