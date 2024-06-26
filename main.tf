module "ec2" {
source               = "./modules/ec2"
  count                = length(var.ec2_data)    
  ec2_data             = var.ec2_data[count.index]
  tags                 = var.default_tags
  sg_names             = var.sg_names
}

module "security_groups" {
  source        = "./modules/security_groups"
  default_tags  = var.default_tags
  security_groups = var.sg_data
}

output "security_group_ids" {
  value = module.security_groups.security_group_ids
}