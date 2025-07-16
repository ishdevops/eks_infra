resource "helm_release" "kyverno" {
  provider   = helm.eks
  name       = "kyverno"
  repository = "https://kyverno.github.io/kyverno/"
  chart      = "kyverno"
  namespace  = "kyverno"
  create_namespace = true
  version    = "3.1.4"
} 