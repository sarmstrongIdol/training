#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-4809fd31
#
# Your subnet ID is:
#
#     subnet-f0e85097
#
# Your security group ID is:
#
#     sg-b2a021ca
#
# Your Identity is:
#
#     Idol-training-lynx
#

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-west-1"
}

terraform {
  backend "atlas" {
    name    = "stuartarmstrong/training"
  }
}

provider "aws" {
  #  access_key = "AKIAIJGYTLVZVXWOCZ2A"  #  secret_key = "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"

  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-4809fd31"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-f0e85097"
  vpc_security_group_ids = ["sg-b2a021ca"]
  count                  = "2"

  tags {
    "Identity" = "Idol-training-lynx"
    "Name"     = "Stuart"
    "Company"  = "theidol.com"
    "Index"    = "${count.index}"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
