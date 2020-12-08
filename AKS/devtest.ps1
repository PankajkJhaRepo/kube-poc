az login --use-device-code
az account set --subscription f73b5c50-56a7-41b3-9024-e2a988b13bfb
az aks get-credentials --resource-group KDI_Galore_DevTestRG --name ts-aks-perftest
kubectl config use-context ts-aks-perftest
# kubectl config delete-context ts-aks-perftest
# kubectl config delete-cluster ts-aks-perftest
# # Not worked kubectl config delete-user clusterUser_KDI_Galore_DevTestRG_ts-aks-perftest
# kubectl config view

kubectl get services --namespace=experimental-poc
kubectl get pvc --namespace=experimental-poc
kubectl get pod --namespace=experimental-poc

kubectl describe pod timescale-0 --namespace=experimental-poc


kubectl create -f .\kube-timescale-aks-with-storage.yaml
kubectl delete -f .\kube-timescale-aks-with-storage.yaml

kubectl describe pod timescale-0 --namespace=experimental-poc

kubectl exec -it timescale-0 -n experimental-poc -- bash
timescaledb-tune --conf-path=/var/lib/postgresql/data/dbfiles/postgresql.conf
# to restart
kubectl delete pods timescale-0 --namespace=experimental-poc

kubectl get quota 


#############For rabbit test
# helm install stable/nginx-ingress --namespace ingress --name ingres
#equivalent command of above

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
kubectl create namespace ingress-basic
helm uninstall nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-basic
helm install nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-basic --set controller.replicaCount=1 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

kubectl get services --namespace ingress-basic
kubectl describe services nginx-ingress-ingress-nginx-controller --namespace ingress-basic
kubectl get pod --namespace exp-rabbitmq
kubectl get service --namespace exp-rabbitmq
kubectl describe service rabbitmq --namespace exp-rabbitmq
kubectl describe pod rabbitmq-0 --namespace exp-rabbitmq
kubectl run nginx --image=nginx
kubectl get pods -o wide --namespace exp-rabbitmq
kubectl get pods -o wide --namespace ingress-basic

kubectl label pod nginx-ingress-ingress-nginx-controller-9fd74df89-kmb7k app=nginx --namespace ingress-basic
kubectl apply -f .\ingress\test.yaml
kubectl delete -f .\ingress\test.yaml

kubectl logs nginx-ingress-ingress-nginx-controller-9fd74df89-kmb7k --namespace ingress-basic
kubectl exec -it nginx-6db489d4b7-rnq4p bash

kubectl create namespace exp-rabbitmq
helm repo add bitnami https://charts.bitnami.com/bitnami
helm uninstall rabbitmq bitnami/rabbitmq --namespace exp-rabbitmq

helm install rabbitmq bitnami/rabbitmq --namespace exp-rabbitmq

kubectl get secret --namespace exp-rabbitmq rabbitmq -o jsonpath="{.data.rabbitmq-password}" 
# Password for rabbit mq  IrBz6sDUKY
# check
kubectl port-forward --namespace exp-rabbitmq svc/rabbitmq 15672:15672

helm upgrade -f .\ingress\values.yaml nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-basic

kubectl get pod --namespace exp-rabbitmq

kubectl get pod,svc --show-labels --namespace exp-rabbitmq