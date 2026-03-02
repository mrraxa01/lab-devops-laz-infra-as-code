# state.tf
terraform {
  backend "s3" {
    bucket  = "terraform-state-mrraxa-lab1"
    key     = "site/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    use_lockfile = true

  }
}
