pipeline {
    agent any
    
    environment {
        BOT_TOKEN = credentials('6993570114:AAFFzf0QrMbi9YaY7NsVMCp7nR3JrXs1mJQ')
        CHAT_ID = '235671675'
        GIT_URL = 'https://gt.mgsigma.net/msigma/assessment-admin-portal.git'
        GIT_CREDENTIAL_ID = 'mgit_token'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    git branch: 'dev',
                        credentialsId: "${GIT_CREDENTIAL_ID}",
                        url: "${GIT_URL}"
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install --legacy-peer-deps'
                sh 'npm install caniuse-lite@latest update-browserslist-db@latest --legacy-peer-deps'
            }
        }

        stage('Build Project') {
            steps {
                sh 'npm run build-dev'
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
                    echo "BOT_TOKEN: ${env.BOT_TOKEN}"
                    echo "CHAT_ID: ${env.CHAT_ID}"

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
                def botToken = env.BOT_TOKEN
                def chatId = env.CHAT_ID
                def message = 'Pipeline completed successfully!'

                sendTelegramMessage(botToken, chatId, message)
            }
        }

        failure {
            script {
                def botToken = env.BOT_TOKEN
                def chatId = env.CHAT_ID
                def message = 'Pipeline failed!'

                sendTelegramMessage(botToken, chatId, message)
            }
        }
    }
}

def sendTelegramMessage(botToken, chatId, message) {
    node {
        def sendMessageUrl = "https://api.telegram.org/bot${botToken}/sendMessage"
        def sendMessageParams = "chat_id=${chatId}&text=${message}"
    
        sh "curl -X POST '${sendMessageUrl}' -d '${sendMessageParams}'"
    }    
}

