az login --use-device-code
az account set --subscription 42899ff3-029c-44f5-82a8-e7e0f9b9fab1

#az aks get-credentials --resource-group KDI_Galore_DevTestRG --name ts-aks-galoredevtest-alternate
az aks get-credentials --resource-group N19012_westeurope --name n09274-kube-galore-timescale

kubectl config use-context n09274-kube-galore-timescale
helm list -n timescale-releases 

helm install nginx-ingress -f .\infra\internal-ingress.yml ./ingress-chart/ --namespace ingress-basic --create-namespace --set controller.replicaCount=2 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux
kubectl create -f .\infra\storage.yaml

helm uninstall nginx-ingress --namespace ingress-basic
helm uninstall galore -n timescale-releases
helm uninstall galore -n timescale-releases
kubectl get service --namespace ingress-basic

10.105.14.226

kubectl get service --namespace ingress-basic
kubectl describe service nginx-ingress-ingress-nginx-controller --namespace ingress-basic

NODE_GROUP=$(az aks show --resource-group $KUBE_GROUP --name $KUBE_NAME --query nodeResourceGroup -o tsv)
az aks create