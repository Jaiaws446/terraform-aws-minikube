module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "workstation"
  ami = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
#   key_name               = "user1"
#   monitoring             = true
  vpc_security_group_ids = [aws_security_group.allow_minikube.id]
  subnet_id              = "subnet-07df07417e4f855bb" #replace with your default subnet id
  user_data = file("docker.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


resource "aws_security_group" "allow_minikube" {
  name        = "allow_minikube"
  description = "Created for minikube"

  tags = {
    Name = "allow_minikube"
  }

    ingress {
    description = "all ports"    
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


   egress {
    description = "all ports"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
}

data "aws_ami" "centos8"{
    owners = ["973714476881"]
    most_recent      = true

    filter {
        name   = "name"
        values = ["Centos-8-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}