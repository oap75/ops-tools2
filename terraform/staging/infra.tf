resource "digitalocean_vpc" "staging_vpc" {
  name     = "staging-vpc"
  region   = "ams3"
  ip_range = "10.0.0.0/16"
}

resource "digitalocean_kubernetes_cluster" "staging_cluster" {
  name          = "staging-cluster"
  tags          = ["infra-staging"]
  region        = "ams3"
  version       = "1.26.5-do.0"
  vpc_uuid      = digitalocean_vpc.staging_vpc.id
  auto_upgrade  = false
  surge_upgrade = true

  node_pool {
    name       = "autoscale-staging-pool"
    size       = "s-2vcpu-4gb"
    auto_scale = true
    min_nodes  = 2
    max_nodes  = 7
    labels = {
      node_type = "small"
    }
  }
}

provider "kubernetes" {
  host  = digitalocean_kubernetes_cluster.staging_cluster.endpoint
  token = digitalocean_kubernetes_cluster.staging_cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.staging_cluster.kube_config[0].cluster_ca_certificate
  )
}

provider "kubectl" {
  host  = digitalocean_kubernetes_cluster.staging_cluster.endpoint
  token = digitalocean_kubernetes_cluster.staging_cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.staging_cluster.kube_config[0].cluster_ca_certificate
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
