# aks-nginx-canary
Canary deployment using NGINX Ingress Controller on Kubernetes (in this case using: Azure Kubernetes Service)

Canary deployments release applications incrementally to a subset of users, which allows for the gradual deployment of new application versions without any downtime.

NGINX Ingress Controller supports traffic-splitting policies based on header, cookie, and weight. Whereas header- and cookie-based policies serve to provide a new service version to a subset of users, weight-based policies serve to divert a percentage of traffic to a new service version.

NGINX Ingress Controller uses the following annotations to enable canary deployments:

- nginx.ingress.kubernetes.io/canary-by-header
- nginx.ingress.kubernetes.io/canary-by-header-value
- nginx.ingress.kubernetes.io/canary-by-header-pattern
- nginx.ingress.kubernetes.io/canary-by-cookie
- nginx.ingress.kubernetes.io/canary-weight

Canary deployment use cases implemented in this tutorial:

1. By HTTP request header.
2. By HTTP cookie value.
3. By Traffic weight.