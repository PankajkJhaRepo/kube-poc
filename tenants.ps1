
$tenant = "galore"
$port=100
$dbPassword="YWRtaW5AMTIzNA=="

# $tenant = "galore-1"
# $port=5433
# $dbPassword="YWRtaW5AMTIzNDU="

# install
helm install $tenant -f ./helm-chart/values.yaml ./helm-chart/ --create-namespace --set namespace.name=$tenant --set service.port=$port --set secret.dbPassword=$dbPassword -n timescale-releases
#helm upgrade nginx-ingress  -f ./helm-chart/tcp-ports.yaml ./ingress-chart/ -n ingress-basic --set controller.replicaCount=2 

#helm upgrade nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-basic -f ./helm-chart/tcp-ports.yaml --set controller.replicaCount=2 

# upgrade tenant
# helm upgrade $tenant -f ./helm-chart/values.yaml ./helm-chart/ --set namespace.name=$tenant --set service.port=$port --set secret.dbPassword=$dbPassword -n timescale-releases 

#helm upgrade nginx-ingress ingress-nginx/ingress-nginx --set tcp.$port=$tenant/$tenant-chart-timescale:$port --namespace ingress-basic 
#timescaledbTune.enabled


#helm install $tenant -f ./helm-chart/values.yaml ./helm-chart/ --set namespace.name=$tenant --set service.port=$port --set secret.dbPassword=$dbPassword -n timescale-releases --dry-run --debug



