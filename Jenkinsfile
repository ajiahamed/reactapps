pipeline {
    agent none // This will default to the Jenkins server if no specific agent is chosen
    
    environment {
        GIT_URL = 'https://github.com/ajiahamed/reactapps.git'
    }

    stages {

        stage('Check Agent Availability') {
            steps {
                script {
                    def worker01Online = 'worker01'
                    if (isNodeOnline(worker01Label)) {
                        agent {
                            label worker01Label
                        }
                    } else {
                        agent any
                    }
                }
            }
        }

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

        stage('Deploy to Apache') {
            steps {
                sh 'cp -r build/* /opt/jenkins/admin'
            }
        }
    }
}

def isNodeOnline(nodeLabel) {
    return !Jenkins.instance.nodes.find { node ->
        node.getAssignedLabels().contains(nodeLabel) && node.toComputer().online
    }
}
