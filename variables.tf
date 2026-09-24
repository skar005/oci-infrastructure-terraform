variable "compartment_ocid" {
  description = "The OCID of the compartment to create resources in"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key to allow login to the instance"
  type        = string
}
