// config provider to use access token from your accoun
// withput passing credential to variables
// but you may need to create or using variables credential instead when run
// on terraform cloud
provider "kubernetes" {
  host                   = "https://${module.interview_gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.interview_gke.ca_certificate)
}
