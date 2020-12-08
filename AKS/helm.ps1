choco install kubernetes-helm

choco install kubernetes-helm --version=2.14.0
kubectl config use-context ts-aks-experimental

kubectl -n kube-system create serviceaccount tiller

kubectl create clusterrolebinding tiller --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

# Not working start from here
# https://rancher.com/docs/rancher/v2.x/en/installation/options/helm2/helm-init/
# https://github.com/qmfrederik/helm
helm init --service-account tiller

#Ingress
https://docs.microsoft.com/en-us/azure/aks/ingress-basic

helm version --short
# add a repo
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm install demo-mysql stable/mysql

helm uninstall demo-mysql
# get local environment
helm env
helm ls


# add timescaledb repo
helm repo add timescaledb 'https://raw.githubusercontent.com/timescale/timescaledb-kubernetes/master/charts/repo/'
helm repo remove timescaledb
helm list
helm install timescaledb timescaledb/timescaledb-multinode
helm uninstall timescaledb timescaledb/timescaledb-multinode
kubectl get pods
kubectl describe pod timescaledb-access-0
kubectl logs timescaledb-access-0
kubectl get services 
Run a postgres pod and connect using the psql cli:
    # login as superuser
    # kubectl run -i --tty --rm psql --image=postgres \
    #   --env "PGPASSWORD=$PGPASSWORD_SUPERUSER" \
    #   --command -- psql -U postgres \
    #   -h timescaledb.default.svc.cluster.local postgres

    # # login as admin
    # kubectl run -i -tty --rm psql --image=postgres \
    #   --env "PGPASSWORD=$PGPASSWORD_ADMIN" \
    #   --command -- psql -U admin \
    #   -h timescaledb.default.svc.cluster.local postgres

# helm commands
      helm list -n timescale-releases 
      helm tempalte [chart]
      helm install [release] [chart] --dry-run --debug

      helm install -f file # for values other than values.yaml
      helm install --set foo=bar # set variables

      # examples
      helm template .
      helm template -f ./values.yaml .
      
      helm template release1 -f ./timescale-chart/values.yaml ./timescale-chart/ --set namespace.name=galore
      
      helm install release1 -f ./timescale-chart/values.yaml ./timescale-chart/ --dry-run --debug

      helm install --help

      # helm install release1 -f ./timescale-chart/values.yaml ./timescale-chart/ -n namespace-for-releases
      kubectl create namespace timescale-releases
      kubectl create namespace galore
      kubectl delete namespace galore
      helm install galore -f ./timescale-chart/values.yaml ./timescale-chart/ --set namespace.name=galore --set secret.dbPassword=YWRtaW5AMTIzNA== -n timescale-releases --dry-run --debug

      helm install galore -f ./helm-chart/values.yaml ./helm-chart/ --set namespace.name=galore --set secret.dbPassword=YWRtaW5AMTIzNA== -n timescale-releases 
      helm install galore-1 -f ./helm-chart/values.yaml ./helm-chart/ --set namespace.name=galore-1 --set secret.dbPassword=YWRtaW5AMTIzNDU= -n timescale-releases
      helm list -n timescale-releases

      
      helm uninstall release1 
      helm uninstall galore -n timescale-releases --timeout 2m0s
      helm delete release1 -n timescale-releases --timeout 2m0s
      kubectl delete ns galore
    kubectl get ns
    kubectl get statefulset --namespace=galore
    kubectl get pod --namespace=galore
    kubectl get service --namespace=galore
    kubectl get pvc --namespace galore
    kubectl get pv  --namespace galore
    kubectl get pods --namespace=galore
    kubectl describe pod timescale-0 --namespace galore

    kubectl delete statefulset timescale --namespace=galore
    kubectl delete pod timescale-0 --namespace=galore

    helm list -n timescale-releases

    helm install galore_1 -f ./timescale-chart/values.yaml ./timescale-chart/ --set namespace.name=galore_1 -n timescale-releases

    # Package chart
    helm package timescale-chart
    helm repo index .

#    helm repo index  --url 'https://pankajkjharepo.github.io/ts-chart-helm/'
#       helm list

#       helm repo add --help
#       helm repo add timescaledb-custom-chart 'https://github.com/PankajkJhaRepo/ts-chart-helm/blob/master/'

#       helm install demo-timescale timescale-chart --dry-run --debug



      