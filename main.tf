provider "aws" {
  profile = "${var.aws_profile}"
}

resource "aws_iam_user" "s3-user" {
  name = "${var.iam_user_name}"
}

resource "aws_iam_access_key" "s3-user" {
  user = "${aws_iam_user.s3-user.name}"
  #
  # Don't attach a policy to this user because the only
  # permissions they should have should come from the
  # bucket policy.
}

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

