output "grafana_url" {
  value = "kubectl port-forward svc/kube-prometheus-stack-grafana 3000:80 -n observability"
}

output "otel_endpoint" {
  value = "http://otel-collector-opentelemetry-collector.observability:4318"
}