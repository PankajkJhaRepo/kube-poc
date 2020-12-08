# install helm on windows
choco install kubernetes-helm

# install helm on linux
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

# authenticate kubernetes cluster
az aks get-credentials --resource-group KDI_Galore_DevTestRG --name ts-aks-perftest

# add repo
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# create namespace
kubectl create namespace ingress-basic
kubectl create namespace timescale-releases

#install
helm install nginx-ingress -f .\infra\internal-ingress.yml ./ingress-chart/ --namespace ingress-basic --create-namespace --set controller.replicaCount=2 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

#helm install nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-basic -f .\infra\tcp-ports.yaml --set tcp.5432="galore/galore-chart-timescale:5432" --set controller.replicaCount=2 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux
#helm install nginx-ingress -f .\infra\internal-ingress.yml ./ingress-chart/ --namespace ingress-basic --set controller.service.loadBalancerIP="51.105.174.181" --set controller.replicaCount=2 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux
#--set controller.service.annotations."service\.beta\.kubernetes\.io/azure-dns-label-name"="experimentalAKS"


#helm install nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-basic -f .\infra\tcp-ports.yaml --set controller.replicaCount=2 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux


#helm uninstall nginx-ingress --namespace ingress-basic
# storage class for tenants
kubectl create -f .\infra\storage.yaml

# helm list --namespace ingress-basic
# helm uninstall nginx-ingress --namespace ingress-basic
#kubectl get service --namespace ingress-basic
kubectl describe service nginx-ingress-ingress-nginx-controller --namespace ingress-basic
# helm history nginx-ingress --namespace ingress-basic

helm install nginx-ingress -f ./ingress-chart/values.yaml ./ingress-chart/ -n ingress-basic  --set controller.replicaCount=2 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

helm upgrade nginx-ingress  -f ./helm-chart/tcp-ports.yaml ./ingress-chart/ -n ingress-basic --set controller.replicaCount=2 


