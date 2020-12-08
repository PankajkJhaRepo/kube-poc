az login --use-device-code
az account set --subscription f73b5c50-56a7-41b3-9024-e2a988b13bfb

#az aks get-credentials --resource-group KDI_Galore_DevTestRG --name ts-aks-galoredevtest-alternate
az aks get-credentials --resource-group KDI_Galore_DevTestRG --name galore-kube-network-test

kubectl config use-context galore-kube-network-test
helm list -n timescale-releases 

helm install nginx-ingress -f .\infra\internal-ingress.yml ./ingress-chart/ --namespace ingress-basic --create-namespace --set controller.replicaCount=2 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux
helm uninstall nginx-ingress --namespace ingress-basic
helm uninstall galore -n timescale-releases
kubectl get service --namespace ingress-basic

52.137.31.14
10.240.0.0/16.

kubectl get service --namespace ingress-basic
kubectl describe service nginx-ingress-ingress-nginx-controller --namespace ingress-basic

NODE_GROUP=$(az aks show --resource-group $KUBE_GROUP --name $KUBE_NAME --query nodeResourceGroup -o tsv)
az aks create