variable namespace {
  type    = "string"
  default = "default"
}
variable "image" {
  type = "string"
  default = "consul:1.7.1"
}
variable "storageClass" {
  type = "string"
  default = ""
}
variable "url_tail" {
  type = "string"
  default = ".$${NAMESPACE}.svc"
}
variable "storage" {
  type = "string"
  default = "20Gi"
}
