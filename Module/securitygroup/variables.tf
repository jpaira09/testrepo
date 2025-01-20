variable "sg_name" {
  type = string
}

variable "vpc_id" {}

# Define list of ports to allow for ingress
variable "allowed_ports" {
  type    = list(number)
  default = [443, 80]
}

variable "ipv4_range" {
  type = string
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
  default     = {}
}