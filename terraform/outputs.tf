output "openvpn_ssh_user" {
  description = "OpenVPN ssh user"
  value       = var.openvpn_ssh_user
}

output "openvpn_ip_address" {
  description = "OpenVPN IP address"
  value       = google_compute_address.openvpn.address
}

output "gke_name" {
  description = "GKE cluster name"
  value       = module.interview_gke.name
}
