# Bastion Server

resource "scaleway_instance_ip" "bastion" {
  project_id = var.scaleway_project_id 
}

resource "scaleway_instance_server" "bastion" {
  name = "bastion"
  type = "DEV1-S"
  image = var.os_image
  project_id = var.scaleway_project_id
  
  # Attach a public IP
  ip_id      = scaleway_instance_ip.bastion.id

#  connection {
#    type        = "ssh"
#    user        = "root"
#    private_key = "${file(var.ssh_key)}"
#    host = scaleway_instance_ip.bastion.address
#  }
  
#  provisioner "file" {
#    source      = "install-config.yaml"
#    destination = "/tmp/install-config.yaml"
#  }

  # Wait for the server to be ready
#  provisioner "remote-exec" {
#   inline = [
#      "sleep 30s",
#      "sudo dnf update -y && sudo dnf install -y httpd wget tar",
#      "wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.12.6/openshift-client-linux-4.12.6.tar.gz -O /tmp/openshift-cli.tar.gz",
#      "tar -xzf /tmp/openshift-cli.tar.gz -C /usr/local/sbin",
#      "wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.12.6/openshift-install-linux-4.12.6.tar.gz -O /tmp/openshift-installer.tar.gz",
#      "tar -xzf /tmp/openshift-installer.tar.gz -C /usr/local/sbin",
#      "wget http://mirror.openshift.com/pub/openshift-v4/x86_64/dependencies/rhcos/4.12/latest/rhcos-metal.x86_64.raw.gz -O /var/www/html/rhcos.raw.gz",
#      "mkdir $HOME/ocpscaleway && cp /tmp/install-config.yaml $HOME/ocpscaleway",
#      "openshift-install create manifests --dir $HOME/ocpscaleway",
#      "sed -i \"s/mastersSchedulable: true/mastersSchedulable: false/g\" $HOME/ocpscaleway/manifests/cluster-scheduler-02-config.yml",
#      "openshift-install create ignition-configs --dir $HOME/ocpscaleway",
#      "cp -rf $HOME/ocpscaleway/* /var/www/html/",
#      "sudo chmod -R 755 /var/www/html",
#      "sudo systemctl restart httpd",
#    ]
#  }
}

