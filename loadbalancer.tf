locals {
  master_ips = concat([ for instance in scaleway_instance_ip.master : instance.address ])
}

resource "scaleway_lb_ip" "apps" {
  project_id = var.scaleway_project_id

}

# Create apps Create a load balancer
resource "scaleway_lb" "apps_openshift_lb" {
  name = "apps_openshift_lb"
  project_id = var.scaleway_project_id
  tags = var.lb_tags
  type   = "LB-S"
  ip_id  = scaleway_lb_ip.apps.id
}

# Create a frontend port 80
resource "scaleway_lb_frontend" "apps_openshift_frontend_80" {
  name = "apps_openshift_frontend_80"
  lb_id = scaleway_lb.apps_openshift_lb.id
  backend_id   = scaleway_lb_backend.apps_openshift_backend_80.id  
  inbound_port = 80
}

# Create a backend port 80
resource "scaleway_lb_backend" "apps_openshift_backend_80" {
  name = "apps_openshift_backend_80"
  lb_id = scaleway_lb.apps_openshift_lb.id
  forward_port = 80
  forward_protocol = "tcp"
  server_ips = local.master_ips
}

# Create a frontend port 443
resource "scaleway_lb_frontend" "apps_openshift_frontend_443" {
  name = "apps_openshift_frontend_443"
  lb_id = scaleway_lb.apps_openshift_lb.id
  backend_id   = scaleway_lb_backend.apps_openshift_backend_443.id
  inbound_port = 443

}

# Create a backend port 443
resource "scaleway_lb_backend" "apps_openshift_backend_443" {
  name = "apps_openshift_backend_443"
  lb_id = scaleway_lb.apps_openshift_lb.id
  forward_port = 443
  forward_protocol = "tcp"
  server_ips = local.master_ips
}


resource "scaleway_lb_ip" "api" {
  project_id = var.scaleway_project_id
}


# Create api Create a load balancer
resource "scaleway_lb" "api_openshift_lb" {
  name = "api_openshift_lb"
  project_id = var.scaleway_project_id
  tags = var.lb_tags
  type   = "LB-S"
  ip_id  = scaleway_lb_ip.api.id
}

# Create a frontend port 6443
resource "scaleway_lb_frontend" "apps_openshift_frontend_6443" {
  name = "api_openshift_frontend_6443"
  lb_id = scaleway_lb.api_openshift_lb.id
  backend_id   = scaleway_lb_backend.api_openshift_backend_6443.id
  inbound_port = 6443
}

# Create a backend port 6443
resource "scaleway_lb_backend" "api_openshift_backend_6443" {
  name = "api_openshift_backend_6443"
  lb_id = scaleway_lb.api_openshift_lb.id
  forward_port = 6443
  forward_protocol = "tcp"
  server_ips = local.master_ips
}

# Create a frontend port 22623
resource "scaleway_lb_frontend" "apps_openshift_frontend_22623" {
  name = "api_openshift_frontend_22623"
  lb_id = scaleway_lb.api_openshift_lb.id
  backend_id   = scaleway_lb_backend.api_openshift_backend_22623.id
  inbound_port = 22623
}

# Create a backend port 22623
resource "scaleway_lb_backend" "api_openshift_backend_22623" {
  name = "api_openshift_backend_22623"
  lb_id = scaleway_lb.api_openshift_lb.id
  forward_port = 22623
  forward_protocol = "tcp"
  server_ips = local.master_ips
}


