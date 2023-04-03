## Bootstrap

resource "scaleway_instance_ip" "bootstrap" {
  project_id = var.scaleway_project_id

}

resource "scaleway_instance_server" "bootstrap" {
  name = "bootstrap"
  image = var.os_image
  type = "GP1-XS"
  project_id = var.scaleway_project_id
  boot_type = "rescue"

  root_volume {
    size_in_gb = 40
  }

# Attach a public IP
  ip_id      = scaleway_instance_ip.bootstrap.id

  connection {
    type        = "ssh"
    user        = "root"
    private_key = "${file(var.ssh_key)}"
    host = scaleway_instance_ip.bootstrap.address
  }

  provisioner "file" {
    source      = "scaleway-config.yaml"
    destination = "/tmp/config.yaml"
  }
}


## Master

resource "scaleway_instance_ip" "master" {
  count = var.master_count
  project_id = var.scaleway_project_id
}

resource "scaleway_instance_server" "master" {
  count = var.master_count
  name = "master-${count.index + 1}"
  image = var.os_image
  type = "GP1-XS"
  boot_type="rescue"
  project_id = "77679642-0964-4b8c-96f0-bd75f4c67126"

# Attach a public IP
  ip_id      = "${element(scaleway_instance_ip.master.*.id, count.index)}"

  root_volume {
    size_in_gb = 40
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = "${file(var.ssh_key)}"
    host = "${element(scaleway_instance_ip.master.*.address, count.index)}"
  }


  provisioner "file" {
    source      = "scaleway-config.yaml"
    destination = "/tmp/config.yaml"
  }
}

## worker

resource "scaleway_instance_ip" "worker" {
  count = var.worker_count
  project_id = var.scaleway_project_id
}

resource "scaleway_instance_server" "worker" {
  count = var.worker_count
  name = "worker-${count.index + 1}"
  image = var.os_image
  type = "GP1-XS"
  boot_type="rescue"
  project_id = "77679642-0964-4b8c-96f0-bd75f4c67126"

# Attach a public IP
  ip_id      = "${element(scaleway_instance_ip.worker.*.id, count.index)}"

    connection {
    type        = "ssh"
    user        = "root"
    private_key = "${file(var.ssh_key)}"
    host = "${element(scaleway_instance_ip.worker.*.address, count.index)}"
  }

  root_volume {
    size_in_gb = 40
  }

  provisioner "file" {
    source      = "scaleway-config.yaml"
    destination = "/tmp/config.yaml"
  }
}
