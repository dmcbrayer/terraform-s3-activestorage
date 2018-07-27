# Terraform S3 Buckets

This script is a starting point for configuring an S3 bucket to use with Rails ActiveStorage.

This will:
  * Create a new IAM role with S3 access permissions
  * Create a new S3 bucket 
  * Create an access policy on the bucket with create and edit permissions tied to the created IAM role, and public read permission.  The assumption is that all uploaded files should be readable by the public since they will be things like profile images, etc.

## Dependencies

  * [Terraform](https://www.terraform.io/downloads.html)
  * A previously set up AWS profile in `$HOME/.aws`.  Learn more [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html).

## Getting Started

First, run `terraform plan` to get an output of the resources that will be created.

Second, run `terraform apply` to apply the plan and create the AWS resources.
