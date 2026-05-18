resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = kubernetes_namespace.argocd.metadata[0].name
  create_namespace = false

  version = "7.7.16"

  timeout = 600
  wait    = true

  values = [
    yamlencode({
      configs = {
        params = {
          "server.insecure" = "true"
        }
      }

      server = {
        service = {
          type = "ClusterIP"
        }
      }
    })
  ]
}