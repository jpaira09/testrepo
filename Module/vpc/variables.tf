variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_map" {
  type = object({
    vpc_cidr          = string
    public_subnet_cidrs  = list(string)
    private_subnet_cidrs = list(string)
  })
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
  default     = {}
}