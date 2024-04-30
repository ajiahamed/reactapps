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

        stage('Deploy to Apache') {
            steps {
                sh 'cp -r build/* /opt/jenkins/admin'
            }
        }
    }

    post {
       success {
           script {
            sendTelegramMessage('Pipeline completed successfully! :)')
        }
    }
        
        failure {
            script {
            sendTelegramMessage('Pipeline failed! :(')
        }
     } 
  }
}

def sendTelegramMessage(message) {
    def botTokenCredential = credentials('telegram_token').toString().trim()
    def chatIdCredential = credentials('telegram_chatid').toString().trim()
    
    sh "curl -X POST -v 'https://api.telegram.org/bot${botTokenCredential}/sendMessage' -d 'chat_id=${chatIdCredential}&text=${message}'"
}

