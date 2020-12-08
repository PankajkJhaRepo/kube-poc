$PSVersionTable.PSVersion

Install-Module -Name Az.Resources -AllowClobber -Scope CurrentUser

Connect-AzAccount
Set-AzContext -SubscriptionId 6b80f5aa-b6d1-430e-8772-759a8f1511f1

Remove-AzResourceGroup -Name experimental-rg -Force

New-AzResourceGroup -Name experimental-rg -Location westus -Tag @{ProjectNumber="experimental"} 

az aks delete --name ts-aks-experimental --resource-group experimental-rg -y

az aks create --name ts-aks-experimental --resource-group experimental-rg --node-count 1 --node-vm-size Standard_B2s --enable-addons monitoring --generate-ssh-keys

kubectl config delete-context ts-aks-experimental
kubectl config delete-cluster ts-aks-experimental
kubectl config unset users.clusterUser_experimental-rg_ts-aks-experimental 

az aks get-credentials --resource-group experimental-rg --name ts-aks-experimental
kubectl config use-context ts-aks-experimental


kubectl create -f .\kube-timescale-aks-with-storage.yaml

kubectl apply -f .\kube-timescale-aks-with-storage.yaml
# increasing storage is allowed 
# decreasing is not allowed returns following error
# The PersistentVolumeClaim "azure-managed-disk" is invalid: spec.resources.requests.storage: Forbidden: field can not be less than previous value

kubectl get pods --namespace=experimental-poc
kubectl get pvc --namespace=experimental-poc
kubectl get pv --namespace=experimental-poc
kubectl delete -f .\kube-timescale-aks-with-storage-autotune.yaml
kubectl create -f .\kube-timescale-aks-with-storage-autotune.yaml
kubectl delete pods timescale-0 --namespace=experimental-poc
kubectl logs timescale-0 --namespace experimental-poc
kubectl describe pod timescale-0 --namespace experimental-poc

kubectl delete -f .\kube-timescale-aks-with-storage.yaml
kubectl create -f .\kube-timescale-aks-with-storage.yaml