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
    
    sh "curl -X POST 'https://api.telegram.org/bot${telegram_token}/sendMessage' -d 'chat_id=${telegram_chatid}&text=${message}'"
}

