terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>5.0"
    }
  }
}
provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "demo-vpc" {
  name                    = "demo-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "k8s-infra" {
  name = "subnet-k8s-infra"
  ip_cidr_range = "172.16.0.0/24"
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
    ports = ["80", "443", "8080", "9090", "3000-32767", "9100", "8000", "8001","8443", "9000", "2379", "2380", "6443", "10250",
    "10259","10257"]
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
