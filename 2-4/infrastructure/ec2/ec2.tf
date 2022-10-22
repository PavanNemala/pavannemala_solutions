/*
AWS EC2 resource to create ec2 instance with attached security group
*/

resource "aws_instance" "this" {
  count                 = var.count
  ami                    = var.ami
  instance_type          = var.instance_type
  user_data              = var.user_data
  availability_zone      = var.availability_zone
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.vpc_security_group_ids]

  monitoring           = var.monitoring

  tags = merge(
          {
            Name       = "${var.environment_tag}-ec2"
            environment = var.environment_tag
          },
            var.network_additional_tags
  )
}
