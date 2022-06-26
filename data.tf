data "aws_vpc" "my-vpc" {
    filter {
    name   = "tag:Name"
    values = ["MAIN VPC"]
  } 
}

data "aws_subnet" "public-subnet-1" {
  filter {
    name   = "tag:Name"
    values = ["testsub-1"]
  }
}

data "aws_subnet" "public-subnet-2" {
  filter {
    name   = "tag:Name"
    values = ["testsub-2"]
  }
}