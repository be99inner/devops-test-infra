resource "google_compute_network" "interview" {
  name                    = "interview-network"
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "instance" {
  name          = "instance-network"
  ip_cidr_range = var.instance_cidr
  region        = var.region
  network       = google_compute_network.interview.id
  project       = var.project_id
}

resource "google_compute_subnetwork" "gke" {
  name          = "gke-network"
  ip_cidr_range = var.gke_cidr
  region        = var.region
  network       = google_compute_network.interview.id
  project       = var.project_id

  secondary_ip_range {
    range_name    = "gke-master-subnet"
    ip_cidr_range = var.gke_master_cidr
  }

  secondary_ip_range {
    range_name    = "gke-svc-subnet"
    ip_cidr_range = var.gke_svc_cidr
  }

  secondary_ip_range {
    range_name    = "gke-pod-subnet"
    ip_cidr_range = var.gke_pods_cidr
  }
}


resource "google_compute_router" "interview_router" {
  name    = "interview-router"
  region  = var.region
  network = google_compute_network.interview.id
  project = var.project_id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "interview_nat" {
  name                               = "interview-router-nat"
  router                             = google_compute_router.interview_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  project                            = var.project_id

  // disable log for interview env
  log_config {
    enable = false
    filter = "ERRORS_ONLY"
  }
}

// vpn server
resource "google_compute_address" "openvpn" {
  name         = "openvpn-server"
  address_type = "EXTERNAL"
  network_tier = "STANDARD"
  region       = var.openvpn_region
  project      = var.project_id
}

resource "google_compute_firewall" "openvpn" {
  name    = "openvpn-server"
  network = google_compute_network.interview.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "udp"
    ports    = ["1194"]
  }

  target_tags = ["openvpn"]
}

resource "google_compute_instance" "openvpn" {
  name         = "openvpn"
  machine_type = "f1-micro"
  zone         = var.openvpn_zone
  project      = var.project_id

  tags = ["openvpn"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network            = google_compute_network.interview.name
    subnetwork         = google_compute_subnetwork.instance.name
    subnetwork_project = var.project_id
    access_config {
      network_tier = "STANDARD"
      nat_ip       = google_compute_address.openvpn.address
    }
  }

  metadata = {
    ssh-keys = "${var.openvpn_ssh_user}:${var.openvpn_ssh_public_key}"
  }
}

// use some resources commnutiy module
module "interview_gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "16.1.0"

  name                    = "oozou-interview-cluster"
  project_id              = var.project_id
  regional                = false
  zones                   = var.gke_zones
  region                  = var.gke_region
  network                 = google_compute_network.interview.name
  subnetwork              = google_compute_subnetwork.gke.name
  ip_range_pods           = "gke-pod-subnet"
  ip_range_services       = "gke-svc-subnet"
  create_service_account  = true
  enable_private_endpoint = true
  master_ipv4_cidr_block  = "gke-master-subnet"
  grant_registry_access   = true

  master_authorized_networks = [
    {
      cidr_block   = var.instance_cidr
      display_name = "instance-network"
    }
  ]

  node_pools = [
    {
      name               = "default-interview-node-pool"
      machine_type       = "e2-small"
      min_count          = 1
      max_count          = 3
      local_ssd_count    = 0
      disk_size_gb       = 80
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = true
      initial_node_count = 2
    }
  ]

  depends_on = [
    google_compute_subnetwork.gke
  ]
}
