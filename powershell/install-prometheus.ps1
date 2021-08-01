#reference youtube video https://www.youtube.com/watch?v=XrGN2UvVPv0

Write-Host "Adding Helm repo for prometheus-community chart" -ForegroundColor Yellow
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

Write-Host "Installing / upgrading prometheus using Helm chart" -ForegroundColor Yellow
helm upgrade --install prometheus `
prometheus-community/kube-prometheus-stack  `
--values prometheus_values.yaml `
--create-namespace `
--wait `
--namespace monitoring

# --set kubelet.serviceMonitor.https=true


Write-Host "Display pods..." -ForegroundColor Yellow
kubectl --namespace monitoring `
get pods `
--selector "release=prometheus"

# helm uninstall prometheus --namespace monitoring

# kubectl port-forward prometheus-prometheus-kube-prometheus-prometheus-0 `
# 9090 `
# --namespace monitoring
#
# kubectl port-forward prometheus-grafana-7b764c9d78-xjtr5 `
# 3000 `
# --namespace monitoring

# prometheus-kube-prometheus-prometheus.monitoring.svc.cluster.local:9090

# Bitnami charts
# helm repo add azure-marketplace https://marketplace.azurecr.io/helm/v1/repo
#
# helm repo update
#
# helm upgrade --install prometheus `
# azure-marketplace/kube-prometheus  `
# --create-namespace `
# --wait `
# --namespace monitoring
#
# helm repo add bitnami https://charts.bitnami.com/bitnami
#
# helm repo update
#
#  helm upgrade --install grafana bitnami/grafana `
#  --set admin.user=admin `
#  --set metrics.enabled=true `
#  --set metrics.serviceMonitor.enabled=true `
#  --create-namespace `
#  --wait `
#  --namespace monitoring
#
#  Prometheus url
#  prometheus-kube-prometheus-prometheus.monitoring.svc.cluster.local
#
#  prometheus port 9090
#
#
#  kubectl port-forward --namespace monitoring svc/prometheus-kube-prometheus-prometheus 9090:9090
#
# alter manager port 9093
#  prometheus-kube-prometheus-alertmanager.monitoring.svc.cluster.local
#
#  kubectl port-forward --namespace monitoring svc/prometheus-kube-prometheus-alertmanager 9093:9093
#
#  grafana port 3000
#   kubectl --namespace monitoring port-forward svc/prometheus-grafana 80:80
#
#    echo "User: admin"
#       echo "Password: $(kubectl get secret grafana-admin --namespace monitoring -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 --decode)"
#
#       kubectl get secret prometheus-grafana --namespace monitoring -o jsonpath="{.data.admin-password}"

# Working version of Springboot application dashboard
#https://grafana.com/grafana/dashboards/11955

#monitoring spring prometheus grafana
#https://ordina-jworks.github.io/monitoring/2020/11/16/monitoring-spring-prometheus-grafana.html