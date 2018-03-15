provider "aws" {
  region  = "eu-west-1"
  profile = "gpestana"
  version = "~> 1.9"
}

provider "template" {
  version = "~> 1.0"
}
