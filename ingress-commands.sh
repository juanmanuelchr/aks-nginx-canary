# Create the AKS cluster with version 1.25

# Create the NGINX Ingress Controller with Basic Configuration
NAMESPACE=ingress-basic

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --create-namespace \
  --namespace $NAMESPACE \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz

# Check external IP for Ingress Controller (provided by Azure Load Balancer)
kubectl get services --namespace ingress-basic -o wide -w ingress-nginx-controller

NAME                       TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)                      AGE   SELECTOR
ingress-nginx-controller   LoadBalancer   10.0.65.205   EXTERNAL-IP     80:30957/TCP,443:32414/TCP   1m   app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx

# Commands for testing Canary Use Cases with NGINX Ingress Controller

curl -H "Host: canary.example.com" -H "x-region: us-east" http://20.96.83.212/echo
curl -H "Host: canary.example.com" -H "x-region: us-west" http://20.96.83.212/echo
curl -H "Host: canary.example.com" http://20.96.83.212/echo

curl -s -H "Host: canary.example.com" --cookie "my_cookie=always" http://20.96.83.212/echo
curl -s -H "Host: canary.example.com" --cookie "other_cookie=always" http://20.96.83.212/echo
curl -s -H "Host: canary.example.com" http://20.96.83.212/echo

for i in {1..10}; do curl -H "Host: canary.example.com" http://20.96.83.212/echo; done