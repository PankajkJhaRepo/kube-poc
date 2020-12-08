kubectl create namespace ingress-basic

# Create a namespace for your ingress resources
kubectl create namespace ingress-basic

# Add the ingress-nginx repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm uninstall nginx-ingress --namespace ingress-basic

# Use Helm to deploy an NGINX ingress controller
helm install nginx-ingress ingress-nginx/ingress-nginx --set tcp.5432="galore/timescale-0:5432" --namespace ingress-basic --set controller.replicaCount=2 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

kubectl get configmap tcp-services  -o yaml --namespace ingress-basic

#############For rabbit test
# helm install stable/nginx-ingress --namespace ingress --name ingres
#equivalent command of above
helm install nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-basic --set controller.replicaCount=1 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux
kubectl get services --namespace ingress-basic

helm repo add bitnami https://charts.bitnami.com/bitnami
helm install rabbitmq bitnami/rabbitmq
kubectl get secret --namespace default rabbitmq -o jsonpath="{.data.rabbitmq-password}" | base64 --decode
# Password for rabbit mq  fb9HsSP4OW
# check
kubectl port-forward --namespace default svc/rabbitmq 15672:15672

helm upgrade -f .\ingress\values-msdn.yaml nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-basic

helm uninstall  rabbitmq
kubectl describe service rabbitmq 
kubectl get pods -o wide --namespace ingress-basic
kubectl logs nginx-ingress-ingress-nginx-controller-9fd74df89-kmb7k --namespace ingress-basic
##################################





helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install my-release ingress-nginx/ingress-nginx --set tcp.5432="galore/timescale-0:5432"
helm uninstall my-release 




kubectl exec -it timescale-0 -n galore -- bash

#helm install nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-basic --set controller.replicaCount=2 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

#helm upgrade -f values.yaml ingress stable/nginx-ingress
kubectl get pods -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].metadata.name}'
POD_NAME=$(kubectl get pods -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].metadata.name}')
# my-release-ingress-nginx-controller-5df8665dc-6dg76PS
kubectl exec -it my-release-ingress-nginx-controller-5df8665dc-6dg76PS --nginx-ingress-controller --version

kubectl get all



