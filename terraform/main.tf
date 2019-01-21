provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "app" {
  name         = "reddit-app-${count.index}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]
  count=2

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  metadata {
    ssh-keys = "zateevas:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    user        = "zateevas"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}

resource "google_compute_project_metadata" "ssh_keys" {
	metadata {
	ssh-keys = <<EOF
appuser1:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcUtx4Rtv2GmFf09IcpeKhJpiA9RmD0xGj37lCc/KePEaJZwjfx2o5XrRsBErf9YKJVFY2bwtKFSxqjeIKwGoFG+WLbInnxHvh6iFm597a3tUwp89EOu13g3JBOsPVQ9J6J7tD91QK0+8pOrqwThu4AO+WpdIwjBUqagStbRWj2PMdu/x/5n0a1eY9j1ZeRw1hM9PL4ByiqpBTJViM5T/eRZA/Klu0bSkxAtvd/f7wU9Ha3xP0ill/1G+cOGuqXGT0FhQ0qbUZyKer3K8wMIP4FRagnVWm+GLonGjcW5MqOIUCuilONv7X8BXNgGnPJxmvYlD1zbLUWOAxTZy+O5ID zateevas@localhost.localdomain
appuser2:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcUtx4Rtv2GmFf09IcpeKhJpiA9RmD0xGj37lCc/KePEaJZwjfx2o5XrRsBErf9YKJVFY2bwtKFSxqjeIKwGoFG+WLbInnxHvh6iFm597a3tUwp89EOu13g3JBOsPVQ9J6J7tD91QK0+8pOrqwThu4AO+WpdIwjBUqagStbRWj2PMdu/x/5n0a1eY9j1ZeRw1hM9PL4ByiqpBTJViM5T/eRZA/Klu0bSkxAtvd/f7wU9Ha3xP0ill/1G+cOGuqXGT0FhQ0qbUZyKer3K8wMIP4FRagnVWm+GLonGjcW5MqOIUCuilONv7X8BXNgGnPJxmvYlD1zbLUWOAxTZy+O5ID zateevas@localhost.localdomain
appuser3:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcUtx4Rtv2GmFf09IcpeKhJpiA9RmD0xGj37lCc/KePEaJZwjfx2o5XrRsBErf9YKJVFY2bwtKFSxqjeIKwGoFG+WLbInnxHvh6iFm597a3tUwp89EOu13g3JBOsPVQ9J6J7tD91QK0+8pOrqwThu4AO+WpdIwjBUqagStbRWj2PMdu/x/5n0a1eY9j1ZeRw1hM9PL4ByiqpBTJViM5T/eRZA/Klu0bSkxAtvd/f7wU9Ha3xP0ill/1G+cOGuqXGT0FhQ0qbUZyKer3K8wMIP4FRagnVWm+GLonGjcW5MqOIUCuilONv7X8BXNgGnPJxmvYlD1zbLUWOAxTZy+O5ID zateevas@localhost.localdomain
EOF
}
}
