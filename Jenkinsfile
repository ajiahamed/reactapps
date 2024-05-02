pipeline {
    agent none // This will default to the Jenkins server if no specific agent is chosen
    
    environment {
        GIT_URL = 'https://github.com/ajiahamed/reactapps.git'
    }

    stages {

        stage('Check Agent Availability') {
            steps {
                script {
                    // Check if "worker01" agent is online
                    def workerOnline = false
                    def workerNode = Jenkins.instance.getNode("worker01")
                    if (workerNode != null && workerNode.toComputer().online) {
                        workerOnline = true
                    }

                    // Choose agent based on availability
                    if (workerOnline) {
                        agent {
                            label 'worker01'
                        }
                    } else {
                        agent any // Run on any available agent if "worker01" is not online
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

def sendTelegramMessage(message) {
    def botToken = '6993570114:AAFFzf0QrMbi9YaY7NsVMCp7nR3JrXs1mJQ'
    def chatId = '235671675'

    sh "curl -X POST -v 'https://api.telegram.org/bot${botToken}/sendMessage' -d 'chat_id=${chatId}&text=${message}'"
}
