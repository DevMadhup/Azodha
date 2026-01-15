## Python Application Deployment on EKS Cluster 

📌 Overview

This project demonstrates a production-style CI/CD pipeline for deploying a containerized API application to Amazon EKS using Jenkins, with CloudWatch monitoring, alerts, and AWS security best practices.

#

**The application exposes:**

- GET /health
- GET /predict → { "score": 0.75 }

#

> [!Important]
> Below table helps you to understand the tech stack used in this project

| Tech stack    | Installation |
| -------- | ------- |
| Jenkins  | <a href="">Jenkins for CI/CD</a>     |
| eksctl | <a href="">Eksctl for EKS Cluster creation</a>     |
| Docker | <a href="">Containerization of Application</a> |
| Cloudwatch | <a href="">EKS CLuster Monitoring on Cloudwatch</a>
| Grafana and Prometheus | <a href="">Grafana for Monitoring</a>
| Clean Up | <a href="">Clean up</a>     |

#

**Architure diagram:**

<img width="1512" height="512" alt="image" src="https://github.com/user-attachments/assets/93a9f77e-330c-4c70-a93c-67fb4b8bc579" />


**🔄 CI/CD Workflow Explanation**


- Developer pushes code to GitHub.
- Jenkins pipeline is triggered.
- Jenkins performs:
  - Code checkout
  - Dependency installation & basic tests
  - Docker image build
  - Image tagging using Jenkins BUILD_NUMBER
  - Image push to container registry

- Jenkins updates the Kubernetes deployment:
  - Image tag is updated
  - Rolling update is triggered in EKS

- Kubernetes replaces pods with zero downtime.

Rolling deployment strategy is used to ensure high availability.

#
**🚀 Deployment Steps**

Prerequisites

- AWS account
- EKS cluster created
- Jenkins running on EC2 with IAM role
- Docker, kubectl, AWS CLI installed

#
**CI/CD pipeline flow:**
<img width="1433" height="702" alt="image" src="https://github.com/user-attachments/assets/2f5d4110-ee4e-4744-9a3d-2e226dfd19a3" />

**Steps**
(JENKINS)
- Build Docker image.
- Push image to registry with versioned tag.
- Update kubeconfig:

```bash
aws eks update-kubeconfig --name api --region us-east-1
```

- Deploy application:

```bash kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
```

- Verify deployment:

```bash
kubectl get pods
kubectl get svc
```

#
**Deployment Confirmation:**
<img width="1880" height="598" alt="image" src="https://github.com/user-attachments/assets/5b371abe-bc33-4e8a-9b2a-803ab07141f0" />

**Application Output:**

<img width="1427" height="352" alt="image" src="https://github.com/user-attachments/assets/c6c55dfd-a0bc-4941-9026-e84db42124f4" />

<img width="1173" height="247" alt="image" src="https://github.com/user-attachments/assets/b087d57f-8297-481f-8548-0dcc4950dcf4" />



#

**📊 Monitoring & Alert Design**

- Monitoring Architecture

  - The application and infrastructure are monitored using a Prometheus + Grafana based observability stack deployed via kube-prometheus-stack.

  
| Components    | Purpose |
| -------- | ------- |
| Prometheus  | Metrics collection and storage     |
| Grafana  | Grafana	Visualization and alerting     |
| cAdvisor | Pod/container CPU & memory metrics     |
| node-exporter | Node-level CPU & memory metrics |
| Grafana Alerting  | Alert evaluation and notifications |

- CloudWatch metrics for EKS Cluster monitoring

<img width="1532" height="637" alt="image" src="https://github.com/user-attachments/assets/f278e97d-74d4-4707-be1d-92388cc79247" />

- Grafana Dashboards
  - CPU and Memory for Instance
<img width="1410" height="702" alt="image" src="https://github.com/user-attachments/assets/dcf86449-0ee3-4f0b-b551-3833e1e7299e" />

  - Alerts configured on Grafana for CPU usage and Memory usage
    - High Resource Usage
      - CPU > 70% for 5 minutes
      - Memory > 75% for 5 minutes
     
<img width="1401" height="692" alt="image" src="https://github.com/user-attachments/assets/ae9529f6-a766-4fd4-9073-debddeb8b964" />

<img width="1396" height="705" alt="image" src="https://github.com/user-attachments/assets/e67aee64-0b07-428a-95f7-9c61e1cdebba" />

<img width="1488" height="766" alt="image" src="https://github.com/user-attachments/assets/29089000-9251-457f-896b-a295971fb628" />

