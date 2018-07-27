variable "aws_profile" {
  description = "The aws profile name set up in your environment"
  default = "roundtable"
}

/*
  variable "bucket_name" {
    description = "What you want your bucket to be called"
  }
*/

variable "iam_user_name" {
  description = "What you want your IAM user role to be called"
}