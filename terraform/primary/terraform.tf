terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 5.1.0"
    }
  }

  backend "s3" {
    bucket       = "aer-finalproject"
    key          = "aer-finalproject-dr.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
