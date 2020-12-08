az login --use-device-code
az account set --subscription f73b5c50-56a7-41b3-9024-e2a988b13bfb

az aks get-credentials --resource-group KDI_Galore_DevTestRG --name ts-aks-galore-devtest
az aks nodepool add --resource-group KDI_Galore_DevTestRG --cluster-name ts-aks-perftest --name pool1 --node-count 1 --mode System --node-vm-size Standard_DS3_v2 --kubernetes-version 1.16.15

az aks nodepool add --help

