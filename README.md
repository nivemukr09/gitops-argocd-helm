<<<<<<< HEAD
![GitOps](https://img.shields.io/badge/GitOps-ArgoCD-blue)
=======
# 🚀 GitOps with ArgoCD and Helm on Minikube

This project demonstrates a complete GitOps workflow using **ArgoCD** and **Helm** to deploy a sample NGINX-based application on a local **Minikube** Kubernetes cluster.

![GitOps](https://img.shields.io/badge/GitOps-ArgoCD-blue)

---

## 📦 Stack Used

- 🐳 Docker (via Minikube)
- ☸️ Kubernetes (Minikube)
- 🔧 Helm (Chart-based deployments)
- 🔁 ArgoCD (GitOps CI/CD)
- 📝 GitHub (as source of truth)

---

## 📁 Folder Structure

gitops-argocd-helm/ ├── demo-app/ │ ├── Dockerfile │ ├── Chart.yaml │ ├── values.yaml │ └── templates/ │ ├── deployment.yaml │ └── service.yaml ├── argo-apps/ │ └── demo-app.yaml ├── .gitignore └── README.md


---

## 🛠️ Setup Instructions

### 1. Start Minikube
```bash
minikube start

```

2. Enable Minikube Docker Env
For PowerShell:
& minikube -p minikube docker-env --shell powershell | Invoke-Expression

3. Build Docker Image
```bash
docker build -t demo-app:1.0 demo-app/
```

4. Install ArgoCD
```bash
kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
Wait a bit for pods to be ready:
```bash
kubectl get pods -n argocd
```

5. Expose ArgoCD Server (insecure for local testing)
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
Open http://localhost:8080

Username: admin

Password: (get using below)
```bash
$encoded = kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}"
[System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($encoded))
```
📦 Helm Chart Setup
Install Helm if not already:
```bash
choco install kubernetes-helm
```
Deploy Helm chart:
```bash
helm install demo-app demo-app/ --namespace default
```
🔁 ArgoCD App Definition
Apply ArgoCD app manifest:
```bash
kubectl apply -f argo-apps/demo-app.yaml -n argocd
```
Then sync the app:
```bash
argocd login localhost:8080 --username admin --password <password> --insecure
argocd app sync demo-app
```

🌐 Access the App
Change service type to NodePort:
```bash
kubectl patch svc demo-app -n default -p "{\"spec\": {\"type\": \"NodePort\"}}"
```
Then access it using:
```bash
minikube service demo-app -n default
```
You should see an NGINX page!
✅ Output
Once deployed and synced, you will see:

ArgoCD shows demo-app as Healthy and Synced

Accessing the app shows the NGINX default page.


📌 Notes
This setup is intended for local testing of GitOps.

ArgoCD watches the GitHub repo for changes and automatically applies them.

Works with private or public repos.

🙏 Credits
Made with ❤️ by Nive

>>>>>>> 20b23bc (Updated files&folders)
