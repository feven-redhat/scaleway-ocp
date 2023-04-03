variable "scaleway_access_key" {
  description = "The access key for Scaleway"
}

variable "scaleway_secret_key" {
  description = "The secret key for Scaleway"
}

variable "scaleway_organization_id" {
  description = "The organization ID for Scaleway"
}

variable "scaleway_project_id" {
  description = "The project ID for Scaleway"
}

variable "master_count" {
  description = "The number of master instances"
  default = 3
}

variable "worker_count" {
  description = "The number of worker instances"
  default = 2
}

variable "os_image" {
  description = "The Scaleway image to use for the instances"
  default = "fedora-36"
}


variable "openshift_version" {
  description = "The version of OpenShift to install"
  default = "4.12"
}

variable "pull_secret" {
  description = "The OpenShift pull secret"
}

variable "ssh_key" {
  description = "The SSH key to use for the instances"
}

variable "region" {
  default     = "par1"
  description = "Values: par1 ams1"
}

# Define for loadbalancer variables
variable "lb_name" {
  default = "openshift-lb"
}

variable "lb_tags" {
  default = ["openshift"]
}

variable "frontend_name" {
  default = "openshift-frontend"
}

variable "backend_name" {
  default = "openshift-backend"
}

variable "target_group_name" {
  default = "openshift-target-group"
}

variable "target_group_tags" {
  default = ["openshift"]
}

variable "target_port" {
  default = 6443
}

