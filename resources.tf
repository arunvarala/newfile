provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region = "${var.AWS_REGION}"
}

resource "aws_instance" "master" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.aws_key_pair}"
  user_data = "${file("${var.bootstrap_path}")}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  tags {
    Name = "temp-master"
  }
}

resource "aws_instance" "worker1" {
  ami  =  "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.aws_key_pair}"
  user_data = "${file("${var.bootstrap_path}")}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  tags {
    Name = "temp-worker 1"
  }
}

resource "aws_instance" "worker2" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.aws_key_pair}"
  user_data = "${file("${var.bootstrap_path}")}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  tags {
    Name = "temp-worker 2"
  }
}

