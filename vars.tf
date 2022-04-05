variable "location" {
  type    = string
  default = "northeurope"
}

variable "prefix" {
  type    = string
  default = "geofriends"
}

variable "ssh-source-address" {
  type    = string
  default = "*"
}

variable "ssh-destination-address" {
  type    = string
  default = "*"
}

variable "web-source-address" {
  type    = string
  default = "*"
}

variable "web-destination-address" {
  type    = string
  default = "*"
}

variable "failover_location" {
  type    = string
  default = "swedencentral"
}

variable "vnet_cidr_range" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_prefixes" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}