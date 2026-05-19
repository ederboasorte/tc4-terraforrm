resource "kubernetes_namespace" "observability" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  namespace  = var.namespace
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  timeout          = 1200
  wait             = true
  atomic           = false
  cleanup_on_fail  = true
  create_namespace = false

  values = [
    templatefile("${path.module}/values/kube-prometheus-stack.yaml", {
      grafana_admin_password = var.grafana_admin_password
    })
  ]

  depends_on = [
    kubernetes_namespace.observability
  ]
}

resource "helm_release" "loki" {
  name       = "loki"
  namespace  = var.namespace
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"

  timeout          = 1200
  wait             = true
  atomic           = false
  cleanup_on_fail  = true
  create_namespace = false


  values = [
    file("${path.module}/values/loki.yaml")
  ]

  depends_on = [
    kubernetes_namespace.observability
  ]
}

resource "helm_release" "jaeger" {
  name       = "jaeger"
  namespace  = var.namespace
  repository = "https://jaegertracing.github.io/helm-charts"
  chart      = "jaeger"

  values = [
    file("${path.module}/values/jaeger.yaml")
  ]

  depends_on = [
    kubernetes_namespace.observability
  ]
}

resource "helm_release" "otel" {
  name       = "otel-collector"
  namespace  = var.namespace
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart      = "opentelemetry-collector"

  values = [
    file("${path.module}/values/opentelemetry.yaml")
  ]

  depends_on = [
    helm_release.kube_prometheus_stack,
    helm_release.loki,
    helm_release.jaeger
  ]
}