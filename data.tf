data "aws_vpc" "my-vpc" {
    default = "vpc-db576dbf"
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