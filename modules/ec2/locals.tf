locals {
  instance_type = {
    x86_64 = "t3.medium"
    arm64  = "t4g.medium"
  }
}

locals {
  default_ami_id       = "ami-0195204d5dce06d99"  
  default_instance_type = "t3.medium"            
}