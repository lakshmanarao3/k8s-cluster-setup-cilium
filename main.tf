terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>5.0"
    }
  }
}
provider "google" {
  project = "k8s-practice-v1"
  region  = "us-central1"
}

resource "google_compute_network" "demo-vpc" {
  name                    = "demo-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet-worker" {
  name          = "subnet-workernode"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.demo-vpc.self_link
}

resource "google_compute_subnetwork" "subnet-master" {
  name = "subnet-masternode"
  region = "us-west1"
  ip_cidr_range = "10.0.2.0/24"
  network = google_compute_network.demo-vpc.self_link
}

resource "google_compute_firewall" "demo-firewall" {
  name    = "demo-fw"
  network = google_compute_network.demo-vpc.self_link
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports = ["80", "443", "8080", "9090", "3000", "9100", "8000", "8001", "9000", "2379", "2380", "6443", "10250",
    "10251", "10252", "10255"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "ssh" {
  name    = "ssh"
  network = google_compute_network.demo-vpc.self_link
  allow {
    protocol = "tcp"
    ports    = ["22"]

  }
  source_ranges = ["0.0.0.0/0"]
}

# locals {
#   my_public_ip = "35.146.200.1/32"
# }