# GKE

1. Login your account to access my project.
2. Connect VPN
3. Get credential on Cluster.

```bash
# list cluster
gcloud containers cluster list

# get kubeconfig
gcloud containers get-credential <cluster-name>
```
