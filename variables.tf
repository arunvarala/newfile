variable "AWS_ACCESS_KEY" {
default = "xxxxxxxxxx"
}

variable "AWS_SECRET_KEY" {
default = "xxxxxxxxxxxxxxxx"
}

variable "AWS_REGION" {
  default = "us-east-2"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default = "ami-8a7859ef"
}

variable "instance_type" {
  description = "Instance type"
  default = "t2.micro"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "/home/ubuntu/.ssh/id_rsa.pub"
}

variable "bootstrap_path" {
  description = "Script to install Docker Engine"
  default = "install-docker.sh"
}

variable "aws_key_pair" {
 default = "ssh"
}

