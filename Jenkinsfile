pipeline {
    agent any
    environment {
        GIT_URL = 'https://github.com/ajiahamed/reactapps.git'
    }

    stages {

        stage('Checkout') {
            steps {
                script {
                    git branch: 'main',
                        url: "${GIT_URL}"
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'    
            }
        }

        stage('Build Project') {
            steps {
                sh 'npm run build'
            }
        }
        
        stage('Copy Files') {
            steps {
                script {
                    sh 'mkdir -p /opt/jenkins/admin'  // Create directory if it doesn't exist
                }
            }
        }
        
        stage('Deploy to Apache') {
            steps {
                sh 'cp -r build/* /opt/jenkins/admin'
            }
        }
    }
}
