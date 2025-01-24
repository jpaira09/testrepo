module "prism_mw_vpc" {
  source = "../../Module/vpc" 
  vpc_name = var.VPC_NAME
  vpc_map = {
    vpc_cidr          = "10.1.0.0/16"
    public_subnet_cidrs  = ["10.1.0.0/20", "10.1.16.0/20"]
    private_subnet_cidrs = ["10.1.32.0/20", "10.1.48.0/20"]
  }
  tags = var.common_tags
}
