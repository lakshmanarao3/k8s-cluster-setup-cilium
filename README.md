# Kubernetes Infrastructure Terraform Configuration

This Terraform configuration sets up a Kubernetes infrastructure on Google Cloud Platform (GCP). It automates the creation of necessary resources such as virtual private cloud (VPC), subnetworks, firewall rules, external IP addresses, and compute instances for master and worker nodes.

## Prerequisites
Before using this Terraform configuration, ensure you have the following:

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- A [Google Cloud Platform (GCP) account](https://cloud.google.com/) with appropriate permissions.
- A GCP project with billing enabled

## Usage
 Initialize Terraform:

    ```bash
    terraform init
    ```

 Plan your infrastructure:

    ```bash
    terraform plan
    ```

 Deploy your infrastructure:

    ```bash
    terraform apply -auto-approve
    ```

## IAM Role Configuration

The `compute-iam-role.yaml` file contains a YAML configuration defining an IAM role with permissions to manage compute resources. This role can be attached to a service account to grant necessary permissions.