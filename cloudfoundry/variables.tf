
variable "region" {
  description = "The region to deploy to (e.g. eu01)."
  type        = string
  default     = "eu01"
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
  type        = string
  description = "Email of the Organisation Admin. Your main human user."
}

variable "org_id" {
  type        = string
  description = "The guid Id of the Cloudfoundry organization."
}

variable "project_id" {
  type        = string
  description = "The guid Id of the project that the Cloudfoundry organization will be created in."
}

variable "username" {
  type        = string
  description = "Cloudfoundry system account"
}

variable "password" {
  type        = string
  description = "Cloudfoundry system account password"
}
