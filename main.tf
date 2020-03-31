resource "helm_release" "consul" {
  chart = path.module
  name  = "consul"
  namespace = var.namespace
  set {
    name  = "fullnameOverride"
    value = "consul-${var.namespace}"
  }
  set {
    name  = "tests.enabled"
    value = "false"
  }
  set {
    name  = "ui.enabled"
    value = "true"
  }
  set{
    name  = "client.enabled"
    value = "false"
  }
  set {
    name  = "server.affinity"
    value = ""
  }
  set {
    name  = "server.connect"
    value = "false"
  }
  set {
    name  = "server.storage"
    value = var.storage
  }
  set {
    name  = "server.bootstrapExpect"
    value = "2"
  }
  set {
    name = "global.image"
    value = var.image
  }
  set {
    name  = "server.storageClass"
    value = var.storageClass
  }
  set {
    name  = "global.url_tail"
    value = var.url_tail
  }
}
