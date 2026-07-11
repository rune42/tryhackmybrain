terraform {
  required_version = ">= 1.5.0"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.66.0"
    }
  }
}

provider "proxmox" {
  endpoint  = "https://${var.proxmox_host}:8006/api2/json"
  api_token = "${var.api_token_id}=${var.api_token_secret}"
  insecure  = true # Set to false if you have valid SSL certificates
}
