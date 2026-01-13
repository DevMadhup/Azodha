pipeline {
  agent any

  environment {
    DOCKERHUB_REPO = "madhupdevops/python-api-azodha"
    IMAGE_TAG = "${BUILD_NUMBER}"
    AWS_REGION   = "us-east-1"
    EKS_CLUSTER  = "api"
  }

  stages {

    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/DevMadhup/Azodha.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh """
          docker build -t ${DOCKERHUB_REPO}:${IMAGE_TAG} .
        """
      }
    }

    stage('Login to Docker Hub') {
      steps {
        
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
          sh """
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
          """
        }  
      }
    }

    stage('Push Image to Docker Hub') {
      steps {
        sh """
          docker push ${DOCKERHUB_REPO}:${IMAGE_TAG}
        """
      }
    }
    
    stage("Deploy to EKS") {
      steps {
        script {
          sh """
            aws eks update-kubeconfig \
              --name ${EKS_CLUSTER} \
              --region ${AWS_REGION}
            sed -i 's|IMAGE_TAG|${IMAGE_TAG}|g' kubernetes/deployment.yaml
            kubectl apply -f kubernetes/deployment.yaml --validate=false
            kubectl apply -f kubernetes/service.yaml --validate=false
          """
        }
      }
    }
  }

  post {
    success {
      echo "✅ Deployment successful to EKS"
    }
    failure {
      echo "❌ Pipeline failed"
    }
  }
}
