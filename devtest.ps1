# powershell.exe -NoLogo -NoProfile -Command 'Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber'

kubectl config use-context ts-aks-galore-devtest
kubectl get services --namespace ingress-basic

helm list -n timescale-releases 

helm uninstall galore-8592bd0a-e60f-4451-b772-6808addf7cac -n timescale-releases 
helm uninstall galore -n timescale-releases 

helm uninstall nginx-ingress --namespace ingress-basic

#-f .\infra\tcp-ports.yaml
helm install nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-basic -f .\infra\tcp-ports.yaml --set tcp.5432="galore/galore-chart-timescale:5432" --set controller.replicaCount=1 --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

kubectl get service --namespace ingress-basic
kubectl get pod --namespace ingress-basic
kubectl logs nginx-ingress-ingress-nginx-controller-598d7b44b5-mfk6h  --namespace ingress-basic
kubectl logs nginx-ingress-ingress-nginx-controller-845b994fd5-vrcgc --namespace ingress-basic
kubectl describe pod  nginx-ingress-ingress-nginx-controller-5ddc5d69d5-dpdpf  --namespace ingress-basic


kubectl port-forward --namespace galore timescale-0 5433:5432

kubectl get pods
kubectl get service --namespace galore
kubectl get pod --namespace galore
kubectl get pv --namespace galore
kubectl get pvc --namespace galore
kubectl describe pod  timescale-0 --namespace galore
kubectl describe service  galore-chart-timescale --namespace galore
kubectl get service galore-chart-timescale -n galore -o yaml > nginx.yaml
kubectl label pod nginx-6db489d4b7-rnq4p app=nginx
vi nginx.yaml

kubectl delete -f nginx.yaml
kubectl get service
kubectl delete service  nginx

kubectl exec -it nginx-6db489d4b7-rnq4p bash

kubectl get service --namespace galore-1
kubectl describe service  galore-1-chart-timescale --namespace galore-1

kubectl logs timescale-0  --namespace galore
helm uninstall galore -n timescale-releases 
managed-premium-retain

kubectl delete sc manual

kubectl create -f .\helm-chart-restore\existing\storage.yaml 


kubectl create namespace galore
kubectl create -f .\helm-chart-restore\existing\existing-volume.yaml  --namespace galore
kubectl create -f .\helm-chart-restore\existing\pvc.yaml --namespace galore
kubectl create -f .\helm-chart-restore\existing\statefulset.yaml --namespace galore
# upgrade postgres
kubectl delete -f .\helm-chart-restore\existing\statefulset.yaml --namespace galore
kubectl create -f .\helm-chart-restore\existing\statefulset.yaml --namespace galore

#tune
kubectl exec -it timescale-0 -n galore -- bash
timescaledb-tune --conf-path=/var/lib/postgresql/data/dbfiles/postgresql.conf

kubectl create -f .\helm-chart-restore\existing\secret.yaml --namespace galore

kubectl delete -f .\helm-chart-restore\existing\storage.yaml 
kubectl delete -f .\helm-chart-restore\existing\existing-volume.yaml  --namespace galore
kubectl delete -f .\helm-chart-restore\existing\pvc.yaml --namespace galore
kubectl delete -f .\helm-chart-restore\existing\statefulset.yaml --namespace galore
