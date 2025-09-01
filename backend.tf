terraform {
  backend "s3" {
    bucket = "sctp-ce11-tfstate"
    key    = "andyhon-tf-assigment2.7-act.tfstate" 
    region = "us-east-1"
  }
}