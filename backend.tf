terraform {
  backend "s3" {
      bucket  = "backend-tf"
    key     = "vasu/terraform/test/terraform.tfstate"
    region  = "us-east-1"   
  }
}