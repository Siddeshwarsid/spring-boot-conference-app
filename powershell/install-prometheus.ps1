Write-Host "Adding Helm repo for prometheus-community chart" -ForegroundColor Yellow
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

Write-Host "Installing / upgrading prometheus using Helm chart" -ForegroundColor Yellow
helm upgrade --install prometheus `
prometheus-community/kube-prometheus-stack  `
--create-namespace `
--wait `
--namespace monitoring


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
