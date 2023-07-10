resource "digitalocean_vpc" "production_vpc" {
  name     = "production-vpc"
  region   = "ams3"
  ip_range = "10.0.0.0/16"
}

resource "digitalocean_kubernetes_cluster" "production_cluster" {
  name          = "production-cluster"
  tags          = ["infra-production"]
  region        = "ams3"
  version       = "1.26.5-do.0"
  vpc_uuid      = digitalocean_vpc.production_vpc.id
  auto_upgrade  = false
  surge_upgrade = true

  node_pool {
    name       = "autoscale-production-mini-pool"
    size       = "c-2"
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 4
    labels = {
      node_type = "small"
    }
  }
}

resource "digitalocean_kubernetes_node_pool" "autoscale-production-medium-pool" {
  cluster_id = digitalocean_kubernetes_cluster.production_cluster.id

  name       = "autoscale-production-medium-pool"
  size       = "s-4vcpu-8gb"
  auto_scale = true
  min_nodes  = 2
  max_nodes  = 5
  labels = {
    node_type = "medium"
  }
}

resource "digitalocean_kubernetes_node_pool" "autoscale-production-large-pool" {
  cluster_id = digitalocean_kubernetes_cluster.production_cluster.id

  name       = "autoscale-production-large-pool"
  size       = "g-4vcpu-16gb"
  auto_scale = true
  min_nodes  = 1
  max_nodes  = 2
  labels = {
    node_type = "large"
  }
}

provider "kubernetes" {
  host  = digitalocean_kubernetes_cluster.production_cluster.endpoint
  token = digitalocean_kubernetes_cluster.production_cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.production_cluster.kube_config[0].cluster_ca_certificate
  )
}

provider "kubectl" {
  host  = digitalocean_kubernetes_cluster.production_cluster.endpoint
  token = digitalocean_kubernetes_cluster.production_cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.production_cluster.kube_config[0].cluster_ca_certificate
  )
  load_config_file = false
}


resource "kubernetes_namespace" "namespaces" {
  count = length(var.namespace_names)

  metadata {
    name = var.namespace_names[count.index]
  }
}

resource "kubernetes_secret" "sealed-secrets-key" {
  metadata {
    name      = "sealed-secrets-key"
    namespace = "sealed-secret"
    labels = {
      "sealedsecrets.bitnami.com/sealed-secrets-key" = "active"
    }
  }

  data = {
    "tls.crt" = var.sealed_crt
    "tls.key" = var.sealed_key
  }

  type = "kubernetes.io/tls"
  depends_on = [kubernetes_namespace.namespaces]
}
