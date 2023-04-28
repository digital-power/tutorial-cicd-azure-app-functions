variable "azure_subs_id" {
  type        = string
  default     = "ef0661c5-0e9a-4467-ba85-e57a8816570d"
  description = "Subscription ID"
}

variable "default_prefix" {
  type        = string
  default     = "dip" # Up to 10 alphanumerical characters
  description = "Prefix used to name the resources and applications"
}

variable "random_id" {
  type        = string
  default     = "14as69" # up to 6 alphanumerical characters. Preferably starts and ends with a number.
  description = "Random alphanumerical value to generate unique names for different components within Azure"
}

variable "owner" {
  type        = string
  default     = "Oscar Mike"
  description = "Name of the owner"
}

variable "dev_tag" {
  type        = string
  default     = "dev"
  description = "Type of environment. Development"
}

variable "prd_tag" {
  type        = string
  default     = "prd" # Preferably "prd" | "dev" | "tst". Up to 3 characters
  description = "Type of environment. Production"
}

variable "location" {
  type        = string
  default     = "West Europe"
  description = "Location where the resources will be deployed"
}
