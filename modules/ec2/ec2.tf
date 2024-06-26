resource "aws_instance" "ec2_instance" {
  ami           = var.ec2_vars.ami_id != "" ? var.ec2_vars.ami_id : coalesce(data.aws_ami.default_ami.id, local.default_ami_id)
  instance_type = var.ec2_vars.instance_type != "" ? var.ec2_vars.instance_type : local.default_instance_type
  key_name      = var.ec2_vars.key_name
  monitoring    = var.ec2_vars.ec2_metrics

  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
    // Primary network interface
  network_interface {
    network_interface_id = aws_network_interface.primary.id
    device_index         = 0
  }
    user_data = templatefile("${path.module}/userdata/userdata.sh.tpl", {
    volumes = var.ec2_vars.ebs_volumes
  })

  tags = merge(var.tags, {"Name" = var.ec2_vars.name})
}


resource "aws_network_interface" "primary" {
  subnet_id = var.ec2_vars.subnet_id

  tags = merge(var.tags, {
    "Name" = var.ec2_vars.name
  })
}