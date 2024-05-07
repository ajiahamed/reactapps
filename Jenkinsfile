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
                sh 'cp -r build/* /opt/jenkins'
            }
        }
    }
        post {
        success {
            script {
                sendTelegramMessage('[✅] ReactApp_pipeline completed successfully at ' + getCurrentTime() + '. Branch: ' + getGitBranch() + ', Build: #' + currentBuild.number + ' 😊')
            }
        }
        
        failure {
            script {
                sendTelegramMessage('[❌] ReactApp_pipeline failed at ' + getCurrentTime() + '. Branch: ' + getGitBranch() + ', Build: #' + currentBuild.number + ' 😱')
            }
        }
    }

triggers {
        pollSCM('H/2 * * * *') // Poll SCM every minute
    }
}

def sendTelegramMessage(message) {
    def botToken = '6538192612:AAFfKCzXnDn1QU3_sKJAMNgtdU5E37hYO44'
    def chatId = '235671675'

    sh "curl -X POST -v 'https://api.telegram.org/bot${botToken}/sendMessage' -d 'chat_id=${chatId}&text=${message}'"
}

def getCurrentTime() {
    return new Date().format("yyyy-MM-dd HH:mm:ss")
}

def getGitBranch() {
    return sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
}
