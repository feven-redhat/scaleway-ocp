Create the cluster

terraform apply -var pull_secret=/home/feven/.pull-secret -var scaleway_access_key=SCW3T2MNVXH1ZS35FZEK -var scaleway_organization_id=210d20c5-33f5-4b5f-9f58-4be397df3160 -var scaleway_secret_key=6613d860-1204-4c94-bdb6-339e489aba37 -var scaleway_project=openshift -var ssh_key=/home/feven/.ssh/scaleway

You need to edit record dns according to your base domain 

api.<cluster_name>.<base_domain>.  6443
api-int.<cluster_name>.<base_domain>. 22623

*.apps.<cluster_name>.<base_domain>. 443 80 






Clean all

terraform destroy -var pull_secret=/home/feven/.pull-secret -var scaleway_access_key=SCW3T2MNVXH1ZS35FZEK -var scaleway_organization_id=210d20c5-33f5-4b5f-9f58-4be397df3160 -var scaleway_secret_key=6613d860-1204-4c94-bdb6-339e489aba37 -var scaleway_project=openshift -var ssh_key=/home/feven/.ssh/scaleway
