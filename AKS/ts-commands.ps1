az login
Connect-AzAccount

az aks get-credentials --resource-group DevTest --name exp-tsdb

kubectl config view
kubectl config view -o jsonpath='{.users[].name}'    # display the first user
kubectl config view -o jsonpath='{.users[*].name}'   # get a list of users
kubectl config get-contexts                          # display list of contexts 
kubectl config current-context                       # display the current-context
kubectl config use-context my-cluster-name           # set the default context to my-cluster-name

kubectl config unset users.clusterUser_experimental-rg_ts-aks-experimental                       # delete user foo

kubectl config use-context 

kubectl create -f kube-timescale-aks-resources.yaml
kubectl apply -f kube-timescale-aks-resources.yaml
kubectl delete -f kube-timescale-aks-resources.yaml

kubectl describe pod timescale-0 --namespace experimental-poc
kubectl logs timescale-0 --namespace experimental-poc

kubectl get all --namespace experimental-poc
kubectl get pods --namespace experimental-poc
kubectl get sc --namespace experimental-poc
kubectl get pvc --namespace experimental-poc
kubectl get pv --namespace experimental-poc
kubectl get services --namespace experimental-poc
kubectl get statefulsets --namespace experimental-poc


# delete individual
kubectl delete statefulset timescale --namespace experimental-poc
kubectl delete pod timescale-0 --namespace experimental-poc





