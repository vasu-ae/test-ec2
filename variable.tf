variable "region" {
    description = "production env"
  
}

variable "ami" {
    description = "test"

}

variable "ins_type" {
    description = "free tier type"
    default = "t2.micro"
  
}

variable "ins-key" {
    default = "devsand-key"
  
}