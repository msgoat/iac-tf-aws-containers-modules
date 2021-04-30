# Terraform Module application/route

Creates a route for the given application via the given loadbalancer to the given AWS EKS cluster:

* adds a listener rule to the given application loadbalancer
* adds a DNS A record for the given application to the given public DNS zone
