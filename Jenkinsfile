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
            sendTelegramMessage('[✅] Pipeline completed successfully! 😊') // Telegram success msg
        }
    }
        
        failure {
            script {
            sendTelegramMessage('[❌] Pipeline failed! 😱') // Telegram failed msg
        }
     } 
  }
}

def sendTelegramMessage(message) {
    def botToken = '6993570114:AAFFzf0QrMbi9YaY7NsVMCp7nR3JrXs1mJQ'
    def chatId = '235671675'

    sh "curl -X POST -v 'https://api.telegram.org/bot${botToken}/sendMessage' -d 'chat_id=${chatId}&text=${message}'"
}
