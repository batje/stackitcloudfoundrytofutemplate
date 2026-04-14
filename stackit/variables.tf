
variable "region" {
  description = "The region to deploy to (e.g. eu01)."
  type        = string
  default     = "eu01"
}

variable "parent_container_id" {
  description = "The guid Id of the parent container that the Cloudfoundry project will be created in."
  type        = string
}

variable "environment" {
  description = "The name of the environment."
  type        = string
  default     = "Test"
}

variable "clientname" {
  description = "The client name. Used to select the correct variable file."
  type        = string
  default     = "Example"
}

variable "admin_email" {
  type    = string
  default = "root@example.com"
}
