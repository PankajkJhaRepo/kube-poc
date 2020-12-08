#kubectl config use-context docker-for-desktop
kubectl config use-context ts-aks-experimental
kubectl get ns 

# one ts service
kubectl delete -f .\kube-timescale-aks-with-storage.yaml
kubectl create -f .\kube-timescale-aks-with-storage.yaml
kubectl get pod --namespace=experimental-poc 
kubectl get services --namespace=experimental-poc
kubectl get pv --namespace=experimental-poc

# kubectl delete -f timescale-ingress1.yaml --namespace=experimental-poc

# 2nd ts service
kubectl delete -f .\kube-timescale-aks-with-storage-no-ns.yaml --namespace=exp-ts-existingdisk 
kubectl create -f .\kube-timescale-aks-with-storage-no-ns.yaml --namespace=exp-ts-existingdisk 
kubectl get services --namespace=exp-ts-existingdisk 
kubectl get pod --namespace=exp-ts-existingdisk
kubectl get pvc --namespace=exp-ts-existingdisk
kubectl get pv --namespace=exp-ts-existingdisk

kubectl create namespace ingress-timescale
# kubectl delete -f timescale-ingress.yaml
# kubectl apply -f timescale-ingress.yaml

# kubectl get Ingress --namespace=ingress-timescale

# install ingress controller 
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm install nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-timescale --set controller.replicaCount=1 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

kubectl --namespace ingress-timescale get services -o wide -w nginx-ingress-ingress-nginx-controller

kubectl get service --namespace=exp-ts-existingdisk 

helm uninstall nginx-ingress --namespace=ingress-timescale
####################
helm uninstall ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx/
helm install ingress-nginx ingress-nginx/ingress-nginx 
helm list

kubectl edit deployments ingress-nginx-controller
kubectl patch deployment myapp-deployment -p \
  '{"spec":{"template":{"spec":{"containers":[{"name":"myapp","image":"172.20.34.206:5000/myapp:img:3.0"}]}}}}'
continue from here
https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.35.0/deploy/static/provider/cloud/deploy.yaml
https://stackoverflow.com/questions/61430311/exposing-multiple-tcp-udp-services-using-a-single-loadbalancer-on-k8s

kubectl delete -f .\deploy.yaml
kubectl create -f .\deploy.yaml

kubectl patch configmap tcp-services -n kube-system --patch '{"data":{"5000":"galore/galore-chart-timescale:5432"}}'
##################

kubectl exec -it ingress-nginx-controller-86f4949664-xsrqz -- /nginx-ingress-controller --version

kubectl get all -n ingress-nginx
kubectl get service -n ingress-nginx
kubectl get pod -n ingress-nginx

kubectl get cm tcp-services -o yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.35.0/deploy/static/provider/cloud/deploy.yaml


kubectl apply -f .\ingress.yaml --tcp-services-configmap=default/tcp-services

helm create NAME 
helm template ./ingress/
helm install ingress-nginx ./ingress/
helm uninstall ingress-nginx 


