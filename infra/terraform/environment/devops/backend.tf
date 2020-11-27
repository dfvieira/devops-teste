terraform {
  backend "s3" {
    bucket  = "terraform-projects-devops/"
    encrypt = true
    key     = "env-devops/stack-sqs"
    region  = "us-east-1"
  }
}