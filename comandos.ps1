az acr login --name acrlab007jvieira

docker push acrlab007jvieira.azurecr.io/bff-rent-a-car-local:latest

az containerapp env create --name bff-rent-a-car-local --resource-group LAB007 --location eastus2

az containerapp env create --name bff-rent-a-car-local --resource-group LAB007 --location eastus