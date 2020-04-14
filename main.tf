data "template_file" "server_resource" {
  template = file("${path.module}/pod_resource")
  vars     = {
    request_memory = var.server_request_memory
    request_cpu    = var.server_request_cpu
    limits_memory  = var.server_limit_memory
    limits_cpu     = var.server_limit_cpu
  }
}

locals {
  consul_full_name = "consul-${var.namespace}"
}

resource "helm_release" "consul" {
  depends_on = [var.module_depends_on]
  chart     = path.module
  name      = "consul"
  namespace = var.namespace
  set {
    name  = "fullnameOverride"
    value = local.consul_full_name
  }
  set {
    name  = "global.url_tail"
    value = var.url_tail
  }
  set {
    name  = "tests.enabled"
    value = "false"
  }
  set {
    name  = "ui.enabled"
    value = "true"
  }
  set {
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
    name  = "global.image"
    value = var.image
  }
  set {
    name  = "server.storageClass"
    value = var.storageClass
  }
  set {
    name  = "server.resources"
    value = data.template_file.server_resource.rendered
  }
}

resource "kubernetes_ingress" "consul_ui_ingress" {
  count      = var.enable_public_ui ? 1 : 0
  depends_on = [helm_release.consul]
  metadata {
    name      = "consul-ui-${var.namespace}"
    namespace = var.namespace
  }
  spec {
    rule {
      host = var.consul_ui_url
      http {
        path {
          path = "/"
          backend {
            service_name = "${local.consul_full_name}-ui"
            service_port = "80"
          }
        }
      }
    }
  }
}

output "consul_server_svc" {
  depends_on = [helm_release.consul]
  value = "${local.consul_full_name}-server.${var.namespace}"
}

output "consul_server_svc_http_port" {
  depends_on = [helm_release.consul]
  value = 8500
}

output "consul_server_svc_port" {
  depends_on = [helm_release.consul]
  value = 8300
}
