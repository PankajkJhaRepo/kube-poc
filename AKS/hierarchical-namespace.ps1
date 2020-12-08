#kubectl config use-context docker-for-desktop
kubectl config use-context ts-aks-experimental

kubectl get ns

HNC_VERSION=v0.5.1
kubectl apply -f https://github.com/kubernetes-sigs/multi-tenancy/releases/download/hnc-v0.5.1/hnc-manager.yaml

kubectl create -f .\namespace-with-quota.yaml
kubectl create -f .\namespace-with-quota-child.yaml
kubectl create -f .\namespace-with-quota-child2.yaml

kubectl create -f .\namespace-2-with-quota.yaml

# By default, HNC propagates RBAC Role and RoleBinding objects. If you create objects of these kinds in a parent namespace, 
# it will automatically be copied into any descendant namespaces as well. 

# exp-namespace-quota
# exp-namespace-quota-child
# exp-namespace-quota-child2

kubectl get namespaces
# parent displays all child 
kubectl get -oyaml -n exp-namespace-quota hierarchyconfiguration hierarchy
# child displays its parent 
kubectl get -oyaml -n exp-namespace-quota-child hierarchyconfiguration hierarchy
kubectl get -oyaml -n exp-namespace-quota-child2 hierarchyconfiguration hierarchy

# cannot delete sub namespace
kubectl delete namespace exp-namespace-quota-child2
# delete child namespace in parent
kubectl delete subns exp-namespace-quota-child2 -n exp-namespace-quota

# Deleting namespaces is very dangerous, and deleting subnamespaces can result in entire subtrees of namespaces being deleted as well.
kubectl delete namespace exp-namespace-quota
