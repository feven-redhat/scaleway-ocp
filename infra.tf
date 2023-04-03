## Master

resource "scaleway_instance_ip" "bootstrap" {
  count = var.master_count
  project_id = var.scaleway_project_id
}

resource "scaleway_instance_server" "bootstrap" {
  count = 1
  name = "bootstrap"
  image = var.os_image
  type = "DEV1-L"
  boot_type="rescue"
  project_id = "77679642-0964-4b8c-96f0-bd75f4c67126"

  #Attach a public IP
  ip_id      = "${element(scaleway_instance_ip.bootstrap.*.id, count.index)}"

  connection {
    type        = "ssh"
    user        = "root"
    private_key = "${file(var.ssh_key)}"
    host = "${element(scaleway_instance_ip.master.*.address, count.index)}"
  }

  root_volume {
    size_in_gb = 40
    delete_on_termination = false
  }


  provisioner "file" {
    source      = "scaleway-config.yaml"
    destination = "/tmp/config.yaml"
  }
}

resource "scaleway_instance_ip" "master" {
  count = var.master_count
  project_id = var.scaleway_project_id
}



resource "scaleway_instance_server" "master" {
  count = var.master_count
  name = "master-${count.index + 1}"
  image = var.os_image
  type = "DEV1-L"
  boot_type="rescue"
  project_id = "77679642-0964-4b8c-96f0-bd75f4c67126"

  #Attach a public IP
  ip_id      = "${element(scaleway_instance_ip.master.*.id, count.index)}"

  connection {
    type        = "ssh"
    user        = "root"
    private_key = "${file(var.ssh_key)}"
    host = "${element(scaleway_instance_ip.master.*.address, count.index)}"
  }

  root_volume {
    size_in_gb = 40
    delete_on_termination = false
  }


  provisioner "file" {
    source      = "scaleway-config.yaml"
    destination = "/tmp/config.yaml"
  }
}

## worker

#resource "scaleway_instance_ip" "worker" {
#  count = var.worker_count
#  project_id = var.scaleway_project_id
#}

#resource "scaleway_instance_server" "worker" {
#  count = var.worker_count
#  name = "worker-${count.index + 1}"
#  image = var.os_image
#  type = "GP1-XS"
#  boot_type="rescue"
#  project_id = "77679642-0964-4b8c-96f0-bd75f4c67126"

# Attach a public IP
#  ip_id      = "${element(scaleway_instance_ip.worker.*.id, count.index)}"

#    connection {
#    type        = "ssh"
#    user        = "root"
#    private_key = "${file(var.ssh_key)}"
#    host = "${element(scaleway_instance_ip.worker.*.address, count.index)}"
#  }

#  root_volume {
#    size_in_gb = 40
#  }

#  provisioner "file" {
#    source      = "scaleway-config.yaml"
#    destination = "/tmp/config.yaml"
#  }
#}
