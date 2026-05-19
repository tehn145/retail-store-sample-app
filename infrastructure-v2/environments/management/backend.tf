# ============================================================
# Terraform Backend: S3 + DynamoDB (Remote State)
# ============================================================

terraform {
  backend "s3" {
    bucket         = "retail-app-terraform-state-<>"
    key            = "environments/management/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "retail-app-terraform-lock-<>"
    encrypt        = true
  }
}
