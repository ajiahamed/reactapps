pipeline {
    agent none // This will default to the Jenkins server if no specific agent is chosen
    
    environment {
        GIT_URL = 'https://github.com/ajiahamed/reactapps.git'
    }

    stages {

        stage('Check Agent Availability') {
            steps {
                script {
                    def worker01Label = 'worker01'
                    def worker01Online = isNodeOnline(worker01Label)
                    if (worker01Online) {
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

    post {
       success {
           script {
            sendTelegramMessage('[✅] Pipeline completed successfully! 😊')
        }
    }
        
        failure {
            script {
            sendTelegramMessage('[❌] Pipeline failed! 😱')
        }
     } 
  }
}

def isNodeOnline(nodeLabel) {
    return Jenkins.instance.nodes.find { node ->
        node.getAssignedLabels().contains(nodeLabel) && node.toComputer().online
    }
}

def sendTelegramMessage(message) {
    def botToken = '6993570114:AAFFzf0QrMbi9YaY7NsVMCp7nR3JrXs1mJQ'
    def chatId = '235671675'

    sh "curl -X POST -v 'https://api.telegram.org/bot${botToken}/sendMessage' -d 'chat_id=${chatId}&text=${message}'"
}
