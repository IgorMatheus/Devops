variable "region" {
  default = "us-east-1"
}

variable "name" {
  default = "master01"
}

variable "env" {
  default = "dev"
}

variable "ami" {
  default = "ami-0fec2c2e2017f4e7b"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_pair" {
  default = "aws-k8s"
}

variable "private_key" {
  default = "/home/igor/Downloads/aws-k8s.pem"
}
