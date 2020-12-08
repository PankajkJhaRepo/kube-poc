kubectl config view
#kubectl config use-context docker-for-desktop
kubectl config use-context ts-aks-experimental

kubectl create clusterrolebinding cluster-admin --clusterrole=cluster-admin --user=$ACCOUNT

kubectl create namespace monitoring

kubectl create -f pro-clusterRole.yaml

kubectl create -f pro-config-map.yaml

kubectl create  -f prometheus-deployment.yaml 

kubectl get deployments --namespace=monitoring

kubectl get pods --namespace=monitoring

#kubectl port-forward prometheus-deployment-77cb49fb5d-zbzg4 8080:9090 -n monitoring
kubectl create -f prometheus-service.yaml --namespace=monitoring

kubectl get services --namespace=monitoring
# for 
# https://azure.microsoft.com/en-in/blog/per-disk-metrics-managed-disks/