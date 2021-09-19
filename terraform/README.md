# Terraform Blueprint

Terraform Blueprint for Interview.

Run format you code with terraform cli.

```bash
terraform fmt -recursive
```

validate your terraform with terraform cli.

```bash
terraform validate
```

plan and apply your infrastructure with terraform cli

```bash
# plan
terraform plan -var-file=gcp.tfvars

# apply
terraform apply -var-file=gcp.tfvars
```

## CAUTION

I will not commit a state and variables this repo.
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 3.84.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_interview_gke"></a> [interview\_gke](#module\_interview\_gke) | terraform-google-modules/kubernetes-engine/google//modules/private-cluster | 16.1.0 |

## Resources

| Name | Type |
|------|------|
| [google_compute_address.openvpn](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_firewall.openvpn](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.openvpn](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_network.interview](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_router.interview_router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.interview_nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.gke](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_compute_subnetwork.instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gke_cidr"></a> [gke\_cidr](#input\_gke\_cidr) | GKE CIDR for cluster | `string` | n/a | yes |
| <a name="input_gke_master_cidr"></a> [gke\_master\_cidr](#input\_gke\_master\_cidr) | GKE masters network cidr | `string` | n/a | yes |
| <a name="input_gke_pods_cidr"></a> [gke\_pods\_cidr](#input\_gke\_pods\_cidr) | GKE pods network cidr | `string` | n/a | yes |
| <a name="input_gke_region"></a> [gke\_region](#input\_gke\_region) | The region to host the cluster | `string` | n/a | yes |
| <a name="input_gke_svc_cidr"></a> [gke\_svc\_cidr](#input\_gke\_svc\_cidr) | GKE services network cidr | `string` | n/a | yes |
| <a name="input_gke_zones"></a> [gke\_zones](#input\_gke\_zones) | The zone to host the cluster | `list(string)` | n/a | yes |
| <a name="input_instance_cidr"></a> [instance\_cidr](#input\_instance\_cidr) | Instance network cidr | `string` | n/a | yes |
| <a name="input_openvpn_region"></a> [openvpn\_region](#input\_openvpn\_region) | Openvpn Server region | `string` | `"asia-southeast1"` | no |
| <a name="input_openvpn_ssh_public_key"></a> [openvpn\_ssh\_public\_key](#input\_openvpn\_ssh\_public\_key) | OpenVPN public key for ssh | `string` | n/a | yes |
| <a name="input_openvpn_ssh_user"></a> [openvpn\_ssh\_user](#input\_openvpn\_ssh\_user) | OpenVPN ssh user | `string` | `"debian"` | no |
| <a name="input_openvpn_zone"></a> [openvpn\_zone](#input\_openvpn\_zone) | Openvpn Server zone | `string` | `"asia-southeast1-b"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project id | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | `"asia-southeast1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gke_name"></a> [gke\_name](#output\_gke\_name) | GKE cluster name |
| <a name="output_openvpn_ip_address"></a> [openvpn\_ip\_address](#output\_openvpn\_ip\_address) | OpenVPN IP address |
| <a name="output_openvpn_ssh_user"></a> [openvpn\_ssh\_user](#output\_openvpn\_ssh\_user) | OpenVPN ssh user |
