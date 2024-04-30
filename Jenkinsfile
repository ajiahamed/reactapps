pipeline {
    agent any
    
    environment {
        BOT_TOKEN = '6993570114:AAFFzf0QrMbi9YaY7NsVMCp7nR3JrXs1mJQ'
        CHAT_ID = '235671675'
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

        stage('Send Message to Telegram') {
            steps {
                script {
                    def botToken = env.BOT_TOKEN
                    def chatId = env.CHAT_ID
                    def message

                    if (currentBuild.result == 'SUCCESS') {
                        message = 'Pipeline completed successfully!'
                    } else {
                        message = 'Pipeline failed!'
                    }

                    sendTelegramMessage(botToken, chatId, message)
                }
            }
        }
    }

    post {
       success {
           script {
            sendTelegramMessage('Pipeline completed successfully!')
        }
    }

        failure {
            script {
            sendTelegramMessage('Pipeline failed!')
        }
    }
        }
    }
}

def sendTelegramMessage(message) {
    def botToken = '6993570114:AAFFzf0QrMbi9YaY7NsVMCp7nR3JrXs1mJQ'
    def chatId = '235671675'

    sh "curl -X POST 'https://api.telegram.org/bot${botToken}/sendMessage' -d 'chat_id=${chatId}&text=${message}'"
}

