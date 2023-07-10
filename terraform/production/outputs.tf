output "PRODUCTION_VPC_ID" {
  value       = digitalocean_vpc.production_vpc.id
  description = "Use this ID to attach any resources to the production VPC"
}

output "PRODUCTION_KUBERNETES_CLUSTER_NAME" {
  value = digitalocean_kubernetes_cluster.production_cluster.name
}
