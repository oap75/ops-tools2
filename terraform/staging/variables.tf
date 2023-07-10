variable "subsocial_staging_token" {
  description = "The subsocial staging token of digitalocean"
  type        = string
  sensitive   = true
}

variable "namespace_names" {
  type    = list(string)
  default = ["monitoring", "sub-back", "sub-id", "sub-front", "argocd", "botkube", "doc", "faucet", "ipfs", "nginx", "post-ever", "sealed-secret", "sub-nodes"]
}

variable "sealed_crt" {
  description = "The subsocial staging sealed secrets pub key"
  type        = string
  sensitive   = true
}

variable "sealed_key" {
  description = "The subsocial staging sealed secrets priv key"
  type        = string
  sensitive   = true
}
