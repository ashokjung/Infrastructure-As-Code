terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

variable "region" {
  default = "us-central1"
}

variable "location" {
  default = "us-central1-c"
}

variable "network_name" {
  default = "terraform-network-vpc"
}

variable "sub_network_name" {
  default = "terraform-subnetwork"
}

provider "google" {
  credentials = file("<credentialsfile>.json")
  project = "<PROJECT_ID>"
  region = var.region
  zone   = var.location
}

resource "google_compute_network" "default" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "name" {
  name                     = var.sub_network_name
  ip_cidr_range            = "10.27.0.0/24"
  network                  = google_compute_network.default.self_link
  region                   = var.region
  private_ip_google_access = true
}