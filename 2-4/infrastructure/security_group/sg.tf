/*
AWS VPC resource  to create VPC with the cidr block provided
to address dns queries from the instances in VPC, dns_support is enabled
Hostnames for instances are enabled
*/
resource "aws_security_group" "allow_ssh" {
  name        = "${var.environment_tag}-sg"
  description = "Allow sshinbound traffic on port 22"
  vpc_id      = var.vpc_id

  ingress {
    description      = "SSH FOR EC2"
    from_port        = var.port
    to_port          = var.port
    protocol         = "ssh"
    cidr_blocks      = [var.cidr_vpc]
  }

  egress {
    description      = "OUTBOUND RULE"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = merge(
          {
            Name       = "${var.environment_tag}-sg"
            environment = var.environment_tag
          },
          var.network_additional_tags
  )
}