#kubectl config use-context docker-for-desktop
kubectl config use-context ts-aks-experimental

kubectl get ns 
kubectl get services --namespace=exp-ts-existingdisk
kubectl get pods --namespace=exp-ts-existingdisk
kubectl get pvc --namespace=exp-ts-existingdisk
kubectl get pv --namespace=exp-ts-existingdisk

kubectl describe pod timescale-0 --namespace=exp-ts-existingdisk
kubectl describe service timescale --namespace=exp-ts-existingdisk

kubectl create namespace exp-ts-existingdisk

kubectl delete -f .\kube-timescale-aks-with-preexisting-storage.yaml --namespace=exp-ts-existingdisk

kubectl delete -f .\existing-volume.yaml --namespace=exp-ts-existingdisk

kubectl create -f .\existing-volume.yaml --namespace=exp-ts-existingdisk
kubectl create -f .\kube-timescale-aks-with-preexisting-storage.yaml --namespace=exp-ts-existingdisk

