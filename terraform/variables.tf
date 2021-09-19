variable "region" {
  description = "GCP region"
  type        = string
  default     = "asia-southeast1"
}

variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "openvpn_region" {
  description = "Openvpn Server region"
  type        = string
  default     = "asia-southeast1"
}

variable "openvpn_zone" {
  description = "Openvpn Server zone"
  type        = string
  default     = "asia-southeast1-b"
}

variable "openvpn_ssh_user" {
  description = "OpenVPN ssh user"
  type        = string
  default     = "debian"
}

variable "openvpn_ssh_public_key" {
  description = "OpenVPN public key for ssh"
  type        = string
}

variable "instance_cidr" {
  description = "Instance network cidr"
  type        = string
}

variable "gke_region" {
  description = " The region to host the cluster"
  type        = string
}

variable "gke_zones" {
  description = " The zone to host the cluster"
  type        = list(string)
}

variable "gke_cidr" {
  description = "GKE CIDR for cluster"
  type        = string
}

variable "gke_master_cidr" {
  description = "GKE masters network cidr"
  type        = string
}

variable "gke_svc_cidr" {
  description = "GKE services network cidr"
  type        = string
}

variable "gke_pods_cidr" {
  description = "GKE pods network cidr"
  type        = string
}
