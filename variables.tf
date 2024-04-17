variable "project_id" {
  description = "GCP project id"
  type=string
  default = "project-id"
}

variable "region" {
  description = "region where the services will be deployed"
  type=string
  default = "us-central1"
} 

variable "instance_zone" {
  description = "The zone for the instances"
  type        = string
  default     = "us-central1-c"
}

variable "boot_disk_image" {
  description = "The image for the boot disk"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "boot_disk_size" {
  description = "The size of the boot disk (in GB)"
  type        = number
  default     = 20
}