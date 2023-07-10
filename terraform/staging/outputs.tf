output "STAGING_VPC_ID" {
  value       = digitalocean_vpc.staging_vpc.id
  description = "Use this ID to attach any resources to the staging VPC"
}

output "STAGING_KUBERNETES_CLUSTER_NAME" {
  value = digitalocean_kubernetes_cluster.staging_cluster.name
}
