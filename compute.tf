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
    ssh-keys = "lakshmana:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDUwlv5ori5D5uocQB47IF1a4TBTwaj/0Fx7QfGlQFM4qpTbv0BiGZI5KUhYE20G1/pkaeyzgtS5CD5h2qwwel8hlY5dtOf0kTrMqH17yBQQ7bRyL9DIDuPzTRroGgXZlPb/CAKhFFgya+2pNZBRvChi/471ndNCyA5ZOY9e/fHhcqg6jqxYY8Y0bnTREU5Zu0icsoVjRBkpFQQvnzkq00cE84zqBlXkVKqj6snTfULveuomvAGSTIxGNZaSrrBXyHixHLJT0HnGCEsOp2xJZZZlKl94THp7GhMSQgLW0di1ppcY87X8/k2cd4I30FS3cYH0zkB4A0HYsF82Bc9AVx01alTIcxVGCDSsafQM5FrhjOUP4DoCI9cigODXbqQp8fYe++w8xaJyCgGYL35Kzh1yMC5tQOPdLU43udR8z8F+LInL6QQy7KcVKjOkWym+1NZQSJhe5SmCR9L2r0de65ug0bjVVv2PITFG94auE4yxPItGd0xS/vNXIfXgLkdhJrfWzAIvzR/8L4PjNKofyalvCMLUWElbfDda3E0XqFuTSa5gl2Rhxf9jSq6ufOt/DX9J7Z3M8jatDaqXI7N7XQjQDYTr1vHeGcOG2/1MiTU6z0svzy5C8seTyV4t9EXDgMoiS7fBNT8vIj+2URtisatvB7p3wiMg9X56dHjBoXOhw== lakshmanarao"
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
    ssh-keys = "lakshmana:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDUwlv5ori5D5uocQB47IF1a4TBTwaj/0Fx7QfGlQFM4qpTbv0BiGZI5KUhYE20G1/pkaeyzgtS5CD5h2qwwel8hlY5dtOf0kTrMqH17yBQQ7bRyL9DIDuPzTRroGgXZlPb/CAKhFFgya+2pNZBRvChi/471ndNCyA5ZOY9e/fHhcqg6jqxYY8Y0bnTREU5Zu0icsoVjRBkpFQQvnzkq00cE84zqBlXkVKqj6snTfULveuomvAGSTIxGNZaSrrBXyHixHLJT0HnGCEsOp2xJZZZlKl94THp7GhMSQgLW0di1ppcY87X8/k2cd4I30FS3cYH0zkB4A0HYsF82Bc9AVx01alTIcxVGCDSsafQM5FrhjOUP4DoCI9cigODXbqQp8fYe++w8xaJyCgGYL35Kzh1yMC5tQOPdLU43udR8z8F+LInL6QQy7KcVKjOkWym+1NZQSJhe5SmCR9L2r0de65ug0bjVVv2PITFG94auE4yxPItGd0xS/vNXIfXgLkdhJrfWzAIvzR/8L4PjNKofyalvCMLUWElbfDda3E0XqFuTSa5gl2Rhxf9jSq6ufOt/DX9J7Z3M8jatDaqXI7N7XQjQDYTr1vHeGcOG2/1MiTU6z0svzy5C8seTyV4t9EXDgMoiS7fBNT8vIj+2URtisatvB7p3wiMg9X56dHjBoXOhw== lakshmanarao"
  }
}
