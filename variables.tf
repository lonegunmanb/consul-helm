variable "module_depends_on" {
  type = any
  default = ""
}
variable namespace {
  type    = string
  default = "default"
}
variable "image" {
  type = string
  default = "consul:1.7.1"
}
variable "storageClass" {
  type = string
  default = ""
}
variable "storage" {
  type = string
  default = "20Gi"
}

variable "enable_public_ui" {
  type = bool
  default = false
}
variable "consul_ui_url" {
  type = string
  default = "consul.local"
}
variable "server_request_memory" {
  type = string
  default = "128Mi"
}

variable "server_request_cpu" {
  type = string
  default = "250m"
}

variable "server_limit_memory" {
  type = string
  default = "256Mi"
}

variable "server_limit_cpu" {
  type = string
  default = "500m"
}

variable "url_tail" {
  type = string
  default = ".$${NAMESPACE}.svc"
}
