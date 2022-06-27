variable "region" {
    default = "us-east-1"
  
}

variable "ami" {
    # default = "ami-0cff7528ff583bf9a"
    description = "my ami"

}

variable "ins_type" {
    description = "free tier type"
    default = "t2.micro"
  
}

variable "ins-key" {
    default = "devsand-key"
  
}