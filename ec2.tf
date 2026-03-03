resource "aws_instance" "lab2-laz_server" {
  ami                    = "ami-0f3caa1cf4417e51b" #Amazon Linux 2 AMI
  instance_type          = "t3.micro"
  key_name               = "Terraform"
  vpc_security_group_ids = [aws_security_group.lab2-laz_sg.id]
  iam_instance_profile   = "EC2-ECR-ROLE-READ-ONLY"
  user_data = file("init_s2.sh")
  tags = {
    Name        = "lab2-laz"
    Provisioned = "Terraform"
    Cliente     = "Marcio"
  }
}

## Security Group
resource "aws_security_group" "lab2-laz_sg" {
  name   = "lab2-laz-sg"
  vpc_id = "vpc-03ea5f1009eaded2a"
  tags = {
    Name        = "lab2-laz-sg"
    Provisioned = "Terraform"
    Cliente     = "Marcio"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.lab2-laz_sg.id
  cidr_ipv4         = "201.71.38.149/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.lab2-laz_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.lab2-laz_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.lab2-laz_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

