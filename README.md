# azure-eks-iac
Azure EKS using Terraform

This repository contains Infrastructure as Code (IaC) for setting up and managing Azure Kubernetes Service (AKS) using Terraform.

## Objectives
- To provide a scalable and maintainable AKS cluster setup.
- To automate the deployment and management of AKS resources.
- To ensure best practices and security standards are followed.

## Prerequisites
- Terraform installed on your local machine.
- Azure CLI installed and configured.
- An Azure subscription.

## Usage
1. Clone the repository.
2. Navigate to the project directory.
3. Initialize Terraform: `terraform init`
4. Plan the deployment: `terraform plan`
5. Apply the configuration: `terraform apply`

## Configuration
The main configuration is defined in the `main.tf` file. Below are some key configurations:

- **Kubernetes Cluster**:
    - Name: `${var.prefix}-k8s`
    - Location: `var.location`
    - Resource Group: `var.resource_group_name`
    - Kubernetes Version: `var.kube_version`
    - Node Pool:
        - Name: `default`
        - Node Count: `var.node_count`
        - VM Size: `var.node_size`
        - OS Disk Size: `var.disk_size`
    - Role-Based Access Control: Enabled
    - OIDC Issuer: Enabled
    - Workload Identity: Enabled
    - Identity Type: `SystemAssigned`
    - Network Plugin: `kubenet`
    - Load Balancer SKU: `standard`
    - Service Mesh: Istio
    - Workload Autoscaler: Vertical Pod Autoscaler Enabled

## Variables
The variables used in the configuration are defined in the `variables.tf` file. Some important variables include:
- `location`: Default is `eastus`
- `prefix`: Default is `mlops-test`
- `kube_version`: Default is `1.31`
- `node_count`: Default is `2`
- `node_size`: Default is `Standard_D2s_v3`
- `disk_size`: Default is `30`
- `istio_version`: Default is `asm-1-23`
- `tenant_id`, `subscription_id`, `resource_group_name`, `client_id`, `client_secret`: These should be set according to your Azure subscription details.
- `tags`: Default tags include team, usage, and environment.
