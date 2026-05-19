# ============================================================
# Terraform Backend: S3 + DynamoDB (Remote State)
# ============================================================

terraform {
  backend "s3" {
    # Thay đổi sau khi bootstrap
    bucket         = "retail-app-terraform-state-<>"  # Change this to your bucket name
    key            = "environments/dev/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "retail-app-terraform-lock-<>"
    encrypt        = true
  }
}
