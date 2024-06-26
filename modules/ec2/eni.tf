resource "aws_network_interface" "eni" {
  for_each = { for idx, eni in var.ec2_vars.eni : idx => eni }

  subnet_id       = each.value.subnet_id
  security_groups = concat(each.value.security_groups, flatten([for sg in aws_security_group.sg : sg.id]))

  tags = merge(var.tags, {
    Name = each.value.name
  })
}

resource "aws_network_interface_attachment" "eni_attach" {
  for_each = { for idx, eni in var.ec2_vars.eni : idx => eni }

  instance_id           = aws_instance.ec2_instance.id
  network_interface_id  = aws_network_interface.eni[each.key].id
  device_index          = each.key == 0 ? 1 : each.key + 1
}
