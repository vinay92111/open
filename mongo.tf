provider "google" {
  
  credentials = file("cred.json")
  project = "alpha-317509"
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_compute_instance" "mongo-server-1" {
 # depends_on   = [google_compute_address.mongo_private_address1]
  name         = "mongo-server-1"
  zone         = "us-central1-a"
  machine_type = "n1-standard-1"

 # tags = [var.mongo_firewall]

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-lts"
      size  = "30"

    }
  }
network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

}
