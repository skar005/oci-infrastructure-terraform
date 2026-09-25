# OCI Infrastructure (Terraform)

Infrastructure as Code definitions to build a complete networking and compute environment on Oracle Cloud Infrastructure (OCI), built using simple commands rather than console configuration.

## Function

- A Virtual Cloud Network (VCN) with a public subnet
- An internet gateway and route table for public internet access
- A security list allowing inbound SSH (22), HTTP (80), and the app's port (8080)
- A compute instance (Ampere ARM, Always Free eligible) running Ubuntu 24.04, with a public IP and SSH access configured via a provided public key

## Purpose

I originally set this up manually through Oracle's web console, which was slow and prone to errors. Rewriting it as Terraform allows the environment to be created, verified, and destroyed with simple commands.

## Usage

```bash
terraform init
terraform plan   # preview what will be created
terraform apply  # provision the infrastructure
```

You'll need a `terraform.tfvars` file (not committed) with:

```hcl
compartment_ocid = "your_tenancy_or_compartment_ocid"
ssh_public_key   = "your_ssh_public_key"
```

And an OCI API config at `~/.oci/config` with valid credentials.

To remove:
```bash
terraform destroy
```

## Improvements

- Move state to a remote backend (e.g. OCI Object Storage) instead of local state files, so it's safe for team use
- Parameterise the region and instance shape instead of hardcoding them
- Split into reusable modules if this grows to manage multiple environments
