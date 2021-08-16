# Ubuntu image
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "airflow" {
  ami           = data.aws_ami.ubuntu.id
  # instance_type = "t2.micro"
  instance_type = "t3.medium"
  key_name                    = var.key_pair_name
  associate_public_ip_address = true
  # security_groups             = [aws_security_group.airflow_sg.id]
  vpc_security_group_ids      = [aws_security_group.airflow_sg.id]
  subnet_id                   = var.airflow_subnet_id

  tags = {
    COURSE = "IGTI-EDC",
    TERRAFORM = "TRUE"
  }

  provisioner "file" {
    source      = "../scripts/server-bootstrap.sh"
    destination = "/tmp/server-bootstrap.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.aws_key_pair
      host        = "${self.public_dns}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/server-bootstrap.sh",
      "sudo /tmp/server-bootstrap.sh",
    ]
    

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.aws_key_pair
      host        = "${self.public_dns}"
    }
  }


}

# Security group to allow acces to instance
resource "aws_security_group" "airflow_sg" {
  name        = "airflow_sg"
  description = "Allow traffic on port 8080 for airflow"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Webserver interface"
    from_port        = 80
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Flower interface"
    from_port        = 5555
    to_port          = 5555
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    COURSE = "IGTI-EDC",
    TERRAFORM = "TRUE"
  }
}