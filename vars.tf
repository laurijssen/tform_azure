variable "location" {
  type    = string
  default = "westeurope"
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