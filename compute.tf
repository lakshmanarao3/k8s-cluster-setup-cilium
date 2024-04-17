#external ip 
resource "google_compute_address" "external_ip" {
  count        = 3
  name         = "my-external-ip-${count.index}"
  address_type = "EXTERNAL"
}
#create nodes
resource "google_compute_instance" "demo-instance" {
  count        = 3
  name         = count.index == 0 ? "masternode" : count.index == 1 ? "workernode1" : "workernode2" 
  machine_type = count.index ==0 ? "custom-4-10240" : "custom-2-8192"
  zone         = var.instance_zone
  network_interface {
    network    = google_compute_network.demo-vpc.self_link
    subnetwork = google_compute_subnetwork.k8s-infra.self_link
    access_config {
      network_tier = "PREMIUM"
      nat_ip       = google_compute_address.external_ip[count.index].address
    }
  }
  boot_disk {
    initialize_params {
      image = var.boot_disk_image
      size  = var.boot_disk_size
    }
  }
  metadata = {
    ssh-keys = ""
  }
}