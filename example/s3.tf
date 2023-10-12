provider "aws" {
  region = "ca-central-1"
}
# Public and Private Read-Only
module "s3_bucket_public_private_read" {
  source              = "../"
  bucket_name         = "denis-santos-dev-01" # Optional
  application_id      = "APP100"
  environment         = "prod"
  region              = "ca-central-1"
  block_public_access = false
}

# Private Read-Only
module "s3_bucket_private_read" {
  source              = "../"
  application_id      = "APP200"
  environment         = "dev"
  region              = "ca-central-1"
  block_public_access = true
}

# Private with Granular Access
module "s3_bucket_granular_read_access" {
  source              = "../"
  application_id      = "APP300"
  environment         = "uat"
  region              = "ca-central-1"
  block_public_access = true
  bucket_access_roles = ["arn:aws:iam::252202848788:role/s3_full_access",
                         "arn:aws:iam::252202848788:role/s3_read_only"]
}