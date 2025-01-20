variable "common_tags" {
  description = "Tags to assign to resources"
  type        = map(string)
  default = {
    Environment = "Dev"
    Terraform   = "True"
  }
}

variable "tmap_bucket" {
  description = "bucket for TMAP team"
  type = string
  default = "prism-tmap-dev"
}

variable "region" {
  type = string
}
