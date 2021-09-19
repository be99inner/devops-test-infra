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
