# Create an ARM Amazon Linux 2 AMI
packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

# base to use
# where to save
source "amazon-ebs" "cocktails" {
    ami_name = "cocktails-app-${local.timestamp}"
    
    # source_ami_filter {
    #   filters = {
    #     name = "amzn2-ami-hvm-2.*.1-x86_64-gp2" # AL2
    #     root-device-type = "ebs"
    #     virtualization-type = "hvm"
    #   }

    # most_recent = true
    # owners = ["amazon"]
    # }

    source_ami = "ami-024c58b8d1b5e7c59" # CIS Amazon Linux 2 Benchmark - Level 2
    
    instance_type = "t2.micro"
    region = "us-west-2"
    ssh_username = "ec2-user"
}

# everything once on instance
build {
    sources = [
        "source.amazon-ebs.cocktails"
        ]

    provisioner "file" {
        source = "../cocktails.zip"
        destination = "/home/ec2-user/cocktails.zip"
    }

    provisioner "file" {
        source = "../cocktails.zip"
        destination = "/var/tmp/cocktails.service"
    }

    provisioner "shell" {
        remote_folder = "/var/tmp"
        script = "./app.sh"
    }
}