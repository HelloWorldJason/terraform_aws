variable "region" {
type = string
default = "ap-southeast-1"
description = "AWS region"
}

variable "amis" {
type = map
default = {
ap-southeast-1 = "ami-01aa83ab14b00e516"
}
description = "AMI ID"
}

variable "instance_type" {
type = string
default = "t2.micro"
description = "EC2 instance type"
}

variable "public_key" {
type = string
default = "id_rsa.pub"
description = "SSH public key"
}

variable "ss_password" {
    type = string
    description = "ssh public key"
}