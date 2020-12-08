# If quota is enabled in a namespace for compute resources like cpu and memory, 
# users must specify requests or limits for those values; otherwise, the quota system may reject pod creation. 

az login --use-device-code

#kubectl config use-context docker-for-desktop
kubectl config use-context ts-aks-experimental
# get supporting resource
kubectl api-resources

kubectl get quota --namespace=exp-namespace-quota
kubectl get ns
kubectl get pod --namespace=exp-namespace-quota
kubectl get sts --namespace=exp-namespace-quota
kubectl get all --namespace=exp-namespace-quota

kubectl describe statefulset timescale --namespace=exp-namespace-quota

kubectl delete -f .\quota-mem-cpu.yaml --namespace=exp-namespace-quota

# limits namespace with quota on namespace
# limit limits quota on all the container within namespace
kubectl create -f .\quota-mem-cpu.yaml --namespace=exp-namespace-quota

kubectl delete -f .\kube-timescale-aks-with-storage-no-ns.yaml --namespace=exp-namespace-quota
kubectl create -f .\kube-timescale-aks-with-storage-no-ns.yaml --namespace=exp-namespace-quota

# limit-range namespace with quota on namespace
# limit-range limits quota on each container within namespace

############## Sub Namespace ######################## Propagation does not work from parent to child
kubectl delete -f .\quota-mem-cpu-child.yaml --namespace=exp-namespace-quota-child
kubectl create -f .\quota-mem-cpu-child.yaml --namespace=exp-namespace-quota-child

kubectl delete -f .\quota-mem-cpu.yaml --namespace=exp-namespace-quota-child
kubectl create -f .\quota-mem-cpu.yaml --namespace=exp-namespace-quota-child
kubectl get quota --namespace=exp-namespace-quota-child
kubectl get pod --namespace=exp-namespace-quota-child
kubectl create -f .\kube-timescale-aks-with-storage-no-ns.yaml --namespace=exp-namespace-quota-child
kubectl delete -f .\kube-timescale-aks-with-storage-no-ns.yaml --namespace=exp-namespace-quota-child
kubectl get sts --namespace=exp-namespace-quota-child
kubectl describe statefulset timescale --namespace=exp-namespace-quota-child
