az login --use-device-code
az account set --subscription f73b5c50-56a7-41b3-9024-e2a988b13bfb
#You need the Azure CLI version 2.2.0 or later installed
az --version
az upgrade
# system node 
# CriticalAddonsOnly=true:NoSchedule ( prevents user pod to be scheduled in system node)
az aks nodepool add --resource-group KDI_Galore_DevTestRG --cluster-name ts-aks-perftest --name custompool --node-count 1 --node-taints CriticalAddonsOnly=true:NoSchedule --mode System --node-vm-size Standard_DS3_v2
az aks nodepool add --resource-group KDI_Galore_DevTestRG --cluster-name ts-aks-perftest --name podnode1 --node-count 1 --node-vm-size Standard_DS3_v2 
# --mode User --os-type Linux

az aks nodepool add --help
az aks nodepool list -g KDI_Galore_DevTestRG --cluster-name ts-aks-perftest

