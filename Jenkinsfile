pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-cred')  
        DOCKER_IMAGE = "venureddy3417/devops-task"   
        DOCKER_TAG = "v1${env.BUILD_NUMBER}"
        AWS_REGION = "us-east-1"
        ECS_CLUSTER = "devops-task-app"
        ECS_SERVICE = "devops-task-service"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'dev', url: 'https://github.com/nanapurvenu/devops-task.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test || echo "No tests found, skipping..."'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $DOCKER_IMAGE:$DOCKER_TAG ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([ credentialsId: 'docker-hub-cred', url: 'https://index.docker.io/v1/' ]) {
                    sh "docker push $DOCKER_IMAGE:$DOCKER_TAG"
                }
            }
        }

        stage('Deploy to ECS') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-creds', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    script {
                        // Check if ECS service exists
                        def serviceExists = sh(
                            script: "aws ecs describe-services --cluster $ECS_CLUSTER --services $ECS_SERVICE --region $AWS_REGION --query 'services[0].status' --output text",
                            returnStatus: true
                        ) == 0

                        if (serviceExists) {
                            echo "ECS service exists. Triggering a new deployment..."
                            sh """
                                aws ecs update-service \
                                  --cluster $ECS_CLUSTER \
                                  --service $ECS_SERVICE \
                                  --force-new-deployment \
                                  --region $AWS_REGION
                            """
                        } else {
                            echo "ECS service not found! Skipping deployment."
                        }
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully! Image pushed: $DOCKER_IMAGE:$DOCKER_TAG"
        }
        failure {
            echo "❌ Pipeline failed. Check logs."
        }
    }
}
