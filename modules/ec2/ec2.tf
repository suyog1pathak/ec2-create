resource "aws_instance" "ec2_instance" {
  ami           = var.ec2_data.ami_id != "" ? var.ec2_data.ami_id : coalesce(data.aws_ami.default_ami.id, local.default_ami_id)
  instance_type = var.ec2_data.instance_type != "" ? var.ec2_data.instance_type : local.default_instance_type
  key_name      = var.ec2_data.key_name
  monitoring    = var.ec2_data.ec2_metrics

  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
    // Primary network interface
  network_interface {
    network_interface_id = aws_network_interface.primary.id
    device_index         = 0
  }
    user_data = templatefile("${path.module}/userdata/userdata.sh.tpl", {
    volumes = var.ec2_data.ebs_volumes
  })

  tags = merge(var.tags, {"Name" = var.ec2_data.name})
}


resource "aws_network_interface" "primary" {
  subnet_id = var.ec2_data.subnet_id

  tags = merge(var.tags, {
    "Name" = var.ec2_data.name
  })
}