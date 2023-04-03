terraform {
  # Declare the Scaleway provider and its version
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
      version = "2.0.0" # Update this to the latest version available
    }
  }
}


provider "scaleway" {
  # Set your Scaleway credentials
  access_key = var.scaleway_access_key
  secret_key = var.scaleway_secret_key
}

