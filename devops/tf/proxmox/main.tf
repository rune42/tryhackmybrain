resource "proxmox_virtual_environment_vm" "my_vm" {
  name        = var.vm_name
  description = "Managed by Terraform"
  node_name   = var.proxmox_node

  # Name of your base template (created previously in Proxmox)
  clone {
    vm_name = var.template_name
    full    = true
  }

  agent {
    enabled = true
  }

  cpu {
    cores   = 2
    sockets = 1
  }

  memory {
    dedicated = 2048
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    iothread     = true
  }

  network_device {
    bridge = "vmbr0"
  }

  # Cloud-Init configuration for injecting IP, users, and SSH keys
  initialization {
    ip_config {
      ipv4 {
        address = "dhcp" # Or set a static IP like "192.168.1.50/24"
      }
    }

    user_account {
      username = "ubuntu"
      keys     = [var.ssh_public_key]
    }
  }
}
