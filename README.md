# Ansible Role: Kubernetes Cluster Deployment

This Ansible role automates the deployment of a Kubernetes cluster on Ubuntu machines. It installs required packages, sets up container runtime, initializes the master node, installs networking components (Calico), and joins worker nodes to the cluster.

## Requirements

- Ansible installed on the control machine.

## Role Variables

- `kube_version`: Specifies the version of Kubernetes to install.

## Dependencies

None.

## Example Playbook

```yaml
- name: Deploy Kubernetes Cluster
  hosts: all
  roles:
    - { role: kubernetes-cluster, tags: kubernetes }

