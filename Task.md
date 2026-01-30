🧩 Assignment (Short Version)

Containerize & Deploy a Simple Service
Create any small API (Node/Python/Go) with two endpoints:
• GET /health
• GET /predict → returns { "score": 0.75 }

Deliverables:
• Production-grade Dockerfile (multi-stage, non-root, healthcheck)
• ECS Fargate OR Kubernetes deployment manifest

Minimal CI/CD Pipeline
Using GitHub Actions (preferred):
CI must:
• Build + test
• Build container image
• Push image to ECR (or Docker Hub)

CD must:
• Deploy updated image to ECS/EKS
• Use rolling or blue-green deployment

Basic Monitoring
Provide:
• CloudWatch metrics (CPU, memory, error count)
• One dashboard (Grafana or CloudWatch)
• Two alerts: high CPU/memory, health check failures

Security Expectations
Demonstrate:
• IAM least-privilege
• Secrets stored in AWS Secrets Manager or SSM
• No credentials in repo
• HTTPS enforcement explanation

Documentation (1–2 pages)
README must include:
• Simple architecture diagram
• CI/CD workflow explanation
• Deployment steps
• Monitoring & alert design
• Security considerations

📦 Submission
Submit:

GitHub repo link

IaC code (Terraform/CloudFormation/K8s)

Screenshots of CI, deployment, dashboard, alerts
