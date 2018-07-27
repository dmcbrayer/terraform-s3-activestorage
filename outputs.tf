output "s3-bucket" {
  value = <<EOF

----------------
Bucket name: ${aws_s3_bucket.s3-bucket.id}
Bucket domain name: ${aws_s3_bucket.s3-bucket.bucket_domain_name}
----------------
EOF
}

output "user_name" {
  value = "${aws_iam_user.s3-user.name}"
}

output "secrets" {
  value = <<EOF

----------------
Access Key Id: ${aws_iam_access_key.s3-user.id}
Secret Key: ${aws_iam_access_key.s3-user.secret}
----------------
EOF
}