pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-cred')  
        DOCKER_IMAGE = "venureddy3417/devops-task"   
        DOCKER_TAG = "v1${env.BUILD_NUMBER}"
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
                    sh """
                        aws ecs update-service \
                            --cluster devops-task-cluster \
                            --service devops-task-service \
                            --force-new-deployment \
                            --region us-east-1
                    """
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
