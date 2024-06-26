resource "aws_security_group" "sg" {
  count = length(var.sg_names)

  vpc_id = var.ec2_data.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {"Name" = var.sg_names[count.index]})
}
