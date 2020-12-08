kubectl config use-context ts-aks-experimental
kubectl config use-context ts-aks-galore-devtest
kubectl config view 

kubectl get services --namespace ingress-basic
helm list -n timescale-releases 
helm uninstall galore -n timescale-releases 
helm uninstall galore-1 -n timescale-releases 
helm uninstall galore-25ti7185-289m-4esc-8529-471a1le5fc08 -n timescale-releases 
helm uninstall galore-24cf7185-289e-4aec-8529-471f1fe5fc08 -n timescale-releases
helm uninstall galore-555c0e13-e3c2-4159-9cd1-ddb9ebf140d0 -n timescale-releases
helm uninstall nginx-ingress --namespace ingress-basic

kubectl describe pod timescale-0 -n galore-1
kubectl logs timescale-0 -n galore-1
kubectl logs timescale-0 -n galore

kubectl describe statefulsets timescale -n galore-1

kubectl get nodes

#kubectl describe node <name>

kubectl config current-context

kubectl config -h

