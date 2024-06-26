resource "aws_ebs_volume" "ebs" {
  for_each = { for idx, vol in var.ec2_data.ebs_volumes : idx => vol }

  availability_zone = var.ec2_data.az
  size              = each.value.size
  type              = each.value.type
  tags = merge(var.tags, { Name = each.value.name })
}

resource "aws_volume_attachment" "ebs_attach" {
  for_each = { for idx, vol in var.ec2_data.ebs_volumes : idx => vol }

  device_name = each.value.device_name
  volume_id   = aws_ebs_volume.ebs[each.key].id
  instance_id = aws_instance.ec2_instance.id
}