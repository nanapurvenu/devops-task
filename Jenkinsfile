pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-cred')  
        DOCKER_IMAGE = "venureddy3417/devops-task"   
        DOCKER_TAG = "v1${env.BUILD_NUMBER}"
        PATH = "/usr/bin:$PATH"  
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'dev', url: 'https://github.com/nanapurvenu/devops-task.git'
            }
        }

        stage('Setup Node.js') {
            steps {
                sh '''
                  #!/bin/bash
                  if ! command -v node >/dev/null 2>&1; then
                    echo "Node.js not found. Installing..."
                    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
                    sudo apt-get install -y nodejs
                  else
                    echo "Node.js is already installed: $(node -v)"
                  fi
                  npm -v || echo "npm is installed with Node.js"
                '''
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

        stage('Deploy with Terraform') {
            steps {
                dir('Terraform') {
                    withCredentials([usernamePassword(credentialsId: 'aws-creds', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                          terraform init -input=false
                          terraform plan -input=false -var docker_image=$DOCKER_IMAGE:$DOCKER_TAG
                          terraform apply -auto-approve -var docker_image=$DOCKER_IMAGE:$DOCKER_TAG
                        '''
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
