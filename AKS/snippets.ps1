az login
# enterprize developer subscription:
az login --tenant masterx.onmicrosoft.comkube
az aks get-credentials --resource-group RG_Test1_AKS --name Kube_Cluster_Test1

kubectl get nodes
kubectl get pods

// tutorial for creating image
docker-compose up -d
docker images 
docker ps
docker-compose down

// upload to Azure Container Registry ACR
az acr login --name ContainerRegistryTest1
az acr list --resource-group rg_test1_aks --query "[].{acrLoginServer:loginServer}" --output table
docker tag azure-vote-front containerregistrytest1.azurecr.io/azure-vote-front:v1
docker images
docker push containerregistrytest1.azurecr.io/azure-vote-front:v1
az acr list --resource-group rg_test1_aks --output table

// run on kubernetes
// node: image ref is modified in yml file to my acr 
kubectl apply -f azure-vote-all-in-one-redis.yaml
kubectl get service azure-vote-front --watch


// aks dashboard
kubectl delete clusterrolebinding kubernetes-dashboard
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard --user=clusterUser
az aks browse --resource-group rg_test1_aks --name Kube_Cluster_Test1

// storage
kubectl get sc // sc: storage classes
kubectl apply -f azure-premium.yaml
kubectl apply -f azure-pvc-disk.yaml
