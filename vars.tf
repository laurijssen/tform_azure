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

