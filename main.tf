provider "aws" {
  profile = "${var.aws_profile}"
}

#########
#  IAM  #
#########

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

########
#  S3  #
########

resource "aws_s3_bucket" "s3-bucket" {
  bucket = "${var.bucket_name}"
}

resource "aws_s3_bucket" "staging-s3-bucket" {
  bucket = "staging-${var.bucket_name}"
}

resource "aws_s3_bucket_policy" "s3-bucket-policy" {
  bucket = "${aws_s3_bucket.s3-bucket.id}"

  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid": "Stmt1526330824446",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_user.s3-user.arn}"
      },
      "Action": "s3:*",
      "Resource": ["${aws_s3_bucket.s3-bucket.arn}/*"]
    },
    {
      "Sid":"AllowRead",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["${aws_s3_bucket.s3-bucket.arn}/*"]
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "staging-s3-bucket-policy" {
  bucket = "${aws_s3_bucket.staging-s3-bucket.id}"

  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid": "Stmt1526330824446",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_user.s3-user.arn}"
      },
      "Action": "s3:*",
      "Resource": ["${aws_s3_bucket.staging-s3-bucket.arn}/*"]
    },
    {
      "Sid":"AllowRead",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["${aws_s3_bucket.staging-s3-bucket.arn}/*"]
    }
  ]
}
EOF
}

