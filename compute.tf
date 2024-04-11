#external ip for worker nodes
resource "google_compute_address" "external_ip" {
  count        = 3
  name         = "my-external-ip-${count.index}"
  address_type = "EXTERNAL"
}
#create worker nodes
resource "google_compute_instance" "demo-instance" {
  count        = 3
  name         = count.index == 0 ? "workernode1" : count.index == 1 ? "workernode2" :  "workernode3"
  machine_type = "custom-2-8192"
  zone         = "us-central1-c"
  network_interface {
    network    = google_compute_network.demo-vpc.self_link
    subnetwork = google_compute_subnetwork.subnet-worker.self_link
    access_config {
      network_tier = "PREMIUM"
      nat_ip       = google_compute_address.external_ip[count.index].address
    }
  }
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 20
    }
  }
  metadata = {
    ssh-keys = ""
  }
}
# external ip for masternode
resource "google_compute_address" "master_external_ip" {
  name         = "masternode-external-ip"
  address_type = "EXTERNAL"
  region = "us-west1"
}
# create masternode
resource "google_compute_instance" "master-instance" {
  name         =  "masternode" 
  machine_type =  "custom-6-10240" 
  zone         = "us-west1-b"
  network_interface {
    network    = google_compute_network.demo-vpc.self_link
    subnetwork = google_compute_subnetwork.subnet-master.self_link
    access_config {
      network_tier = "PREMIUM"
      nat_ip       = google_compute_address.master_external_ip.address
    }
  }
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 30
    }
  }
  metadata = {
    ssh-keys = ""
  }
}
