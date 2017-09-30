variable "AWS_ACCESS_KEY" {
default = "AKIAIP7W2U5WLWHR5X3Q"
}

variable "AWS_SECRET_KEY" {
default = "9bc6EbxJCWnCYuPe0qHR09pjNIDhcq/5meHP6yHU"
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

