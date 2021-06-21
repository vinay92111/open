provider "google" {

  credentials = file("cred.json")
  project = "alpha-317509"
  region  = "us-central1"
  zone    = "us-central1-a"
}
resource "google_container_cluster" "my_cluster" {
  name     = "my-gke-cluster"
  location = "us-central1"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.my_cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-micro"

    # Google recommends custom service accounts that have cloud-platform scope a
   #nd permissions granted via IAM Roles.
   # service_account = google_service_account.default.email
   # oauth_scopes    = [
    #  "https://www.googleapis.com/auth/cloud-platform"
   # ]
  }
}
