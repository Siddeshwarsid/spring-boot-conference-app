Write-Host "Adding Helm repo for postgresql chart" -ForegroundColor Yellow
helm repo add azure-marketplace https://marketplace.azurecr.io/helm/v1/repo

helm repo update

Write-Host "Installing / upgrading postgresql using Helm chart" -ForegroundColor Yellow
helm upgrade --install postgresql azure-marketplace/postgresql `
--set service.type=LoadBalancer `
--set postgresqlPassword=June@2021