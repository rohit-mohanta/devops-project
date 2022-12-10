## Sub-task 1

- AWS CLI is installed and configured with full access.
![[aws-cli.png]]
- S3 bucket as Terraform backend.

```
provider "aws" {
	region = "us-east-1"
}

resource "aws_s3_bucket" "terraform-state" {
	bucket = "terraform-state-rohit-456"
	
/* lifecycle {

prevent_destroy = true

} */

}

resource "aws_s3_bucket_versioning" "versioning" {
	bucket = aws_s3_bucket.terraform-state.id
	versioning_configuration {
		status = "Enabled"

	}

}

resource "aws_dynamodb_table" "terraform-locks" {

	name = "terraform-state-locking"
	billing_mode = "PAY_PER_REQUEST"
	hash_key = "LockID"

	attribute {
		name = "LockID"
		type = "S"

	}

}

terraform {
	backend "s3" {
		bucket = "terraform-state-rohit-456"
		key = "global/s3/terraform.tfstate"
		region = "us-east-1"
		dynamodb_table = "terraform-state-locking"
	}

}
```

