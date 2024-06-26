data "aws_ami" "default_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = [var.ec2_data.architecture]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "description"
    values = ["Amazon Linux 2 LTS Arm64 Kernel 5.10 AMI 2.0.20240620.0 arm64 HVM gp2", "Amazon Linux 2 Kernel 5.10 AMI 2.0.20240620.0 x86_64 HVM gp2"]
  }

}