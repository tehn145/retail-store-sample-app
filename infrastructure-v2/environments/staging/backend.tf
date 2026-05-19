terraform {
  backend "s3" {
    bucket         = "retail-app-terraform-state-<>"  # Change this to your bucket name
    key            = "environments/staging/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "retail-app-terraform-lock-<>"
    encrypt        = true
  }
}
