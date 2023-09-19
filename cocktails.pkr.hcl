# provider
packer {
    required_plugins {
        amazon = {
            version = ">= 1.0.0"
            source = "github.com/hashicorp/amazon"
        }
    }
}

# base to use
# where to save
source "amazon-ebs" "cocktails" {
    ami_name = "cocktails-app"
    source_ami = "ami-00c6177f250e07ec1"
    instance_type "t2.micro"
    region = "us-west-2"
    ssh_username = "ec2-user"
}

# everything once on instance
build {
    sources = [
        "source.amazon-ebs.cocktails"
        ]

    provisioner "shell" {
        script = "./app,sh"
    }
# installations
# configurations
# files to copy 
}