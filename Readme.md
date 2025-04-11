# Azure Kubernetes Service (AKS) Best Practices with Terraform

This repository contains Terraform configurations to deploy an Azure Kubernetes Service (AKS) cluster following Microsoft's recommended best practices.

## Prerequisites

Before you begin, ensure you have the following:

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed and configured
- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0 or later)
- An Azure subscription
- Proper permissions to create resources in Azure
- [kubectl](https://kubernetes.io/docs/tasks/tools/) (optional, for cluster management)

## AKS Best Practices Implemented

This project implements the following AKS best practices:

- **Network Security**
    - Private AKS cluster deployment
    - Network policies enabled
    - Advanced networking with Azure CNI

- **Identity and Access Management**
    - Managed identity for AKS
    - Azure RBAC integration
    - Least privilege principles for service accounts

- **Scaling and Availability**
    - Multiple node pools
    - Cluster autoscaler enabled
    - Availability zones for high availability

- **Monitoring and Operations**
    - Azure Monitor for containers
    - Diagnostic settings configured
    - Log Analytics workspace integration

- **Security Hardening**
    - Regular node image updates
    - Pod security policies
    - Azure Policy integration

## Deployment Instructions

To deploy the AKS cluster:

1. Navigate to the project directory:
     ```bash
     cd ./Workload
     ```

2. Initialize Terraform:
     ```bash
     terraform init
     ```

3. Create a plan (optional):
     ```bash
     terraform plan -out main.tfplan
     ```

4. Apply the Terraform configuration:
     ```bash
     terraform apply main.tfplan
     ```
     
     Or directly apply:
     ```bash
     terraform apply --auto-approve
     ```

5. After deployment, configure kubectl to connect to your new cluster (the command with the updated values could be found in the outputs):
     ```bash
     az aks get-credentials --resource-group <resource-group-name> --name <cluster-name> 
     ```

## PowerShell Deployment Option

You can also deploy using the included PowerShell script:

1. Open PowerShell and navigate to the project directory:
    ```powershell
    cd .\Workload
    ```

2. Run the deployment script:
    ```powershell
    .\dep.ps1
    ```

3. The script will handle the Terraform initialization, planning, and deployment processes automatically.

4. You can pass parameters to customize the deployment:
    ```powershell
    .\dep.ps1 -ResourceGroupName "myAKSResourceGroup" -Location "eastus" -ClusterName "myAKSCluster"
    ```

## Cleanup

To destroy all resources when no longer needed:

```bash
terraform destroy --auto-approve
```

### For PowerShell
When using PowerShell, you need to destroy resources manually or create a separate cleanup script for resource removal.

## Configuration Customization

Modify the `variables.tf` and `terraform.tfvars` files to customize your deployment according to your requirements.