output "load_balancer_hostname"{
    value   = kubernetes_service.app.status.0.load_balancer.0.ingress.0.hostname
    description = "Hostanme fo the ELB created by k8s svc"
}
