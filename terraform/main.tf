resource "aws_security_group" "strapi_sg" {
  name        = "aryak-strapi_sg"
  description = "Allow HTTP, Strapi port and SSH"

  ingress {
    description = "Allow Strapi port"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")

  vars = {
    image_tag = var.image_tag
  }
}

resource "aws_instance" "strapi_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                   = var.key_name
  vpc_security_group_ids     = [aws_security_group.strapi_sg.id]
  associate_public_ip_address = true
  user_data                   = data.template_file.user_data.rendered

  tags = {
    Name = "StrapiAppServer"
  }
}

