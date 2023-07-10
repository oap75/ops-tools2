variable "subsocial_production_token" {
  description = "The subsocial production token of digitalocean"
  type        = string
  sensitive   = true
}

variable "namespace_names" {
  type    = list(string)
  default = ["monitoring", "sub-back", "sub-id", "sub-front", "argocd", "botkube", "doc", "faucet", "ipfs", "nginx", "post-ever", "sealed-secret", "sub-nodes"]
}

variable "sealed_crt" {
  description = "The subsocial production sealed secrets pub key"
  type        = string
  sensitive   = true
}

variable "sealed_key" {
  description = "The subsocial production sealed secrets priv key"
  type        = string
  sensitive   = true
}
