variable "image" {
  default = "packer-ubuntu-16.04-hwe"
}

variable "flavor" {
  default = "m1.small"
}

variable "ssh_key_file" {
  default = "~/.ssh/id_rsa"
}

variable "ssh_user_name" {
  default = "ubuntu"
}

variable "pool" {
  default = "public1"
}

variable "volume_size" {
  type    = "number"
  default = 1
}
