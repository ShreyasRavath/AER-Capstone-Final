
# 🚀 AER High Availability & Disaster Recovery Project

This project demonstrates a **highly available**, **multi-region**, GitOps-based deployment of a web application (FastAPI + React) on **AWS EKS**, with **DR failover** via Route 53 and **CI/CD automation** using GitHub Actions.

---

## 🏗️ Architecture Overview

```text
          +-------------------------+
          |     Route 53 (DNS)     |
          +-----------+------------+
                      |
       +--------------+--------------+
       |                             |
+------+-------+             +-------+------+
| us-east-1    |             | us-east-2    |
| PRIMARY      |             | DR REGION    |
| EKS Cluster  |             | EKS Cluster  |
+------+-------+             +-------+------+
       |                             |
+------v-------+             +-------v------+
| ArgoCD       |             | ArgoCD       |
| Backend/FE   |             | Backend/FE   |
| LoadBalancer |             | LoadBalancer |
+--------------+             +--------------+
```

- **Frontend** is exposed using `LoadBalancer` in both regions.
- **Route 53** manages DNS-level failover via health checks.
- **ArgoCD** syncs Helm charts to both clusters.
- **GitHub Actions** automates builds, infra provisioning, and failover.

---

## 💡 High Availability (HA) Features

- EKS spread across 3 AZs in each region
- Managed node groups for auto-healing
- LoadBalanced frontend for public access
- Health checks on frontend allow automatic failover
- ArgoCD ensures desired state is always applied

## 🛡️ Disaster Recovery (DR) Features

- Fully mirrored EKS infrastructure in `us-east-2`
- Route 53 failover routing policy
- CI/CD pipeline with manual `dr-failover.yml`
- Sync ArgoCD in DR cluster to promote apps

---

## 📦 Application Stack

- **Backend**: FastAPI
- **Frontend**: React
- **Infra**: Terraform + AWS EKS + ECR + Route 53
- **Deploy**: Helm + ArgoCD
- **CI/CD**: GitHub Actions

---

## 📁 Directory Structure

```
.
├── app-code/              # Application source code
│   ├── backend/           # FastAPI backend
│   └── frontend/          # React frontend
├── helm/                  # Helm charts for K8s deployment
│   ├── backend/
│   └── frontend/
├── terraform/
│   ├── primary/           # Primary EKS + VPC + ECR
│   └── dr/                # DR EKS + VPC + ECR
├── argocd-apps/           # ArgoCD Application manifests
└── .github/workflows/     # GitHub Actions CI/CD & failover
```

---

## 🚀 Deployment Steps

1. **Configure GitHub Secrets**:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

2. **Provision Infra**:
   Run `Terraform Deploy` workflow (manual trigger):
   - Creates EKS, VPC, ECR in `us-east-1` and `us-east-2`

3. **Build & Push Docker Images**:
   - Push to `main` branch or trigger `docker-ecr-deploy.yml`

4. **Install ArgoCD** in both clusters and apply apps:
   ```bash
   kubectl apply -f argocd-apps/
   ```

5. **Access App** via Route 53 DNS:
   - Automatically routes to healthy region

6. **Trigger Failover** (if needed):
   - Use `dr-failover.yml` GitHub Action to manually promote DR

---

## 🧠 Why This is HA/DR Ready

| Feature                      | Description                                |
|-----------------------------|--------------------------------------------|
| Multi-AZ                    | Each cluster spans 3 AZs for redundancy    |
| Multi-Region                | Full replica in `us-east-2`                |
| GitOps Sync (ArgoCD)        | Ensures consistent state everywhere        |
| Route 53 Failover           | DNS-based region switching                 |
| Manual DR Pipeline          | Enables one-click promotion if needed      |
| CI/CD Automation            | Fully automated deployment and infra setup |

---

## ✨ Built With

- AWS EKS, Route 53, ECR
- Terraform
- Helm & Kubernetes
- ArgoCD
- GitHub Actions
- FastAPI + React


