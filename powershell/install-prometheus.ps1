Write-Host "Adding Helm repo for prometheus-community chart" -ForegroundColor Yellow
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

# Write-Host "Creating monitoring namespace" -ForegroundColor Yellow
# kubectl create namespace monitoring

Write-Host "Installing prometheus using Helm chart" -ForegroundColor Yellow
helm install prometheus `
prometheus-community/kube-prometheus-stack  `
--create-namespace `
--wait `
--namespace monitoring

Write-Host "Display pods..." -ForegroundColor Yellow
kubectl --namespace monitoring `
get pods `
--selector "release=prometheus"

# helm uninstall prometheus --namespace monitoring