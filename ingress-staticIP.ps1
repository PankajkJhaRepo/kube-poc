az login --use-device-code
az aks show --resource-group KDI_Galore_DevTestRG --name ts-aks-galore-devtest --query nodeResourceGroup -o tsv

# Static IP 
# For Standard Loadbalancer
az network public-ip create --resource-group MC_KDI_Galore_DevTestRG_ts-aks-galore-devtest_westeurope --name ts-aks-galore-devtest-ip --sku Standard --allocation-method static --query publicIp.ipAddress -o tsv
# For Basic Loadbalancer
az network public-ip create --resource-group MC_experimental-rg_ts-aks-experimental_westus --name ts-aks-experimentalPublicIP --sku Basic --allocation-method static --query publicIp.ipAddress -o tsv

13.64.193.67

# Static IP with FQDN (Dynamic not allowed)
az network public-ip create --resource-group experimental-rg --name ts-aks-galore-devtest-ip --sku Standard --allocation-method static --dns-name exp-tsdb --query publicIp.ipAddress -o tsv

az network public-ip create --help


az network public-ip delete --resource-group MC_experimental-rg_ts-aks-experimental_westus --name ts-aks-experimentalPublicIP 
