## deploy ingress
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
kubectl create namespace ingress-basic
helm install nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-basic --set controller.replicaCount=1 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

## deploy rabbitmq
kubectl create namespace exp-rabbitmq
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install rabbitmq bitnami/rabbitmq --namespace exp-rabbitmq
kubectl get secret --namespace exp-rabbitmq rabbitmq -o jsonpath="{.data.rabbitmq-password}" 

# check if services works
kubectl port-forward --namespace exp-rabbitmq svc/rabbitmq 15672:15672

# apply tcp port forward rules
helm upgrade -f .\values.yaml nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-basic

