kubectl config use-context ts-aks-experimental

helm install nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-basic --set controller.replicaCount=1 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux
kubectl get services --namespace ingress-basic

helm install galore -f ./helm-chart/values.yaml ./helm-chart/ --set namespace.name=galore --set service.port=5432 --set secret.dbPassword=YWRtaW5AMTIzNA== -n timescale-releases 
kubectl get pod --namespace=galore
kubectl get service --namespace=galore
kubectl describe service galore-chart-timescale  --namespace=galore

# add new entry
helm upgrade -f .\ingress\values-msdn.yaml nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-basic

kubectl get pods --namespace ingress-basic
kubectl logs nginx-ingress-ingress-nginx-controller-57c5d68845-gzf9c --namespace ingress-basic


# kubectl describe service rabbitmq 

 kubectl get pod,svc --show-labels --namespace galore


helm install galore-1 -f ./helm-chart/values.yaml ./helm-chart/ --set namespace.name=galore-1 --set service.port=5433 --set secret.dbPassword=YWRtaW5AMTIzNDU= -n timescale-releases
kubectl get pod --namespace=galore-1
kubectl get service --namespace=galore-1
kubectl describe service galore-1-chart-timescale  --namespace=galore-1


#########-----------------------------##############
helm list --namespace ingress-basic

helm install -f .\ingress\values-msdn-with-keys.yaml nginx-ingress ingress-nginx/ingress-nginx --set tcp.5432="galore/galore-chart-timescale:5432" --namespace ingress-basic --dry-run --debug 

helm upgrade -f .\ingress\values-msdn-with-keys.yaml nginx-ingress ingress-nginx/ingress-nginx --set tcp.5433="galore-1/galore-1-chart-timescale:5433" --namespace ingress-basic --dry-run --debug
helm upgrade -f .\ingress\values-msdn-with-keys.yaml nginx-ingress ingress-nginx/ingress-nginx --set tcp.5434="galore-2/galore-2-chart-timescale:5434" --namespace ingress-basic --dry-run --debug

#helm install -f .\ingress\values-msdn-with-keys.yaml nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-basic --dry-run --debug --dry-run --debug
helm upgrade --namespace ingress-basic --install --set tcp.5432=galore/galore-chart-timescale:tcp.5432 --wait ingress-nginx ingress-nginx


