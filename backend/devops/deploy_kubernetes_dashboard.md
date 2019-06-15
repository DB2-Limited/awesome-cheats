# Deploy kubernetes dashboard to cluster
##### Table of Contents

- [Base info](#)
  - [Kubernetes dashboard](#)
- [Setup dashboard](#)
  - [Generate certificates](#)
  - [Install dashboard](#)
  - [Add role](#)
  - [Update deployment](#)
- [Uninstall dashboard](#)
- [Knows errors](#)
 ---
 
<p align="left">
  <img src="./assets/deploy_kubernetes_dashboard/dashboard-ui.png" width=285>
</p>


 **Kubernetes dashboard** - is a general purpose, web-based UI for Kubernetes clusters. It allows users to manage applications running in the cluster and troubleshoot them, as well as manage the cluster itself.
 [Learn more](https://github.com/kubernetes/dashboard/tree/master)
 
## Setup dashboard
### Generate certificates
If you want to deploy dashboard with your custom SSL certificates, you need to create secret kubernetes-dashboard-certs before deploy the dashboard. The secret must contain dashboard.crt and dashboard.key data.
```bash
kubectl create secret generic kubernetes-dashboard-certs --from-file=<path_to_folder_with_crt_and_key> -n kube-system
```

### Install dashboard
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
```

### Add role
Add admin permissions and dashboard log in by token.

<p align="left">
  <img src="./assets/deploy_kubernetes_dashboard/dashboard-ui.png" width=285>
</p>

```yaml
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
   name: kubernetes-dashboard
   labels:
     k8s-app: kubernetes-dashboard
roleRef:
   apiGroup: rbac.authorization.k8s.io
   kind: ClusterRole
   name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: kubernetes-dashboard
    namespace: kube-system
```

### Update deployment
Add authentication skip button to dashboard log in. Just add arg *--enable-skip-login* to kubernetes dashboard deployment. Also remove arg *--auto-generate-certificates* if you used custom dashboard certificates.
```bash
kubectl edit deployment/kubernetes-dashboard --namespace=kube-system
```
*example*:
```yaml
containers:
      - args:
        - --auto-generate-certificates   # <-- remove this line, if you used custom certificates
        - --enable-skip-login            # <-- add this line 
        image: k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.1
```

### Uninstall dashboard
For delete kubernetes dashboard from your cluster use next commands.
```bash
	kubectl delete deployment kubernetes-dashboard --namespace=kube-system 
	kubectl delete service kubernetes-dashboard  --namespace=kube-system 
	kubectl delete role kubernetes-dashboard-minimal --namespace=kube-system 
	kubectl delete rolebinding kubernetes-dashboard-minimal --namespace=kube-system
	kubectl delete sa kubernetes-dashboard --namespace=kube-system 
	kubectl delete secret kubernetes-dashboard-certs --namespace=kube-system
	kubectl delete secret kubernetes-dashboard-key-holder --namespace=kube-system
	kubectl delete clusterrolebinding kubernetes-dashboard --namespace=kube-system
```

[Knows errors](./kubernetes_known_errors.md)
