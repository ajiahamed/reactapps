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
                sendTelegramMessage('[✅] Admin-Portal_Pipeline completed successfully at ' + getCurrentTime() + '. Branch: ' + getGitBranch() + ', Build: #' + currentBuild.number + ' 😊')
            }
        }
        
        failure {
            script {
                sendTelegramMessage('[❌] Admin-Portal_Pipeline failed at ' + getCurrentTime() + '. Branch: ' + getGitBranch() + ', Build: #' + currentBuild.number + ' 😱')
            }
        }
    }
}
triggers {
        pollSCM('H/2 * * * *') // Poll SCM every minute
    }
}

def sendTelegramMessage(message) {
    def botToken = '6993570114:AAFFzf0QrMbi9YaY7NsVMCp7nR3JrXs1mJQ'
    def chatId = '-1002117551270'

    sh "curl -X POST -v 'https://api.telegram.org/bot${botToken}/sendMessage' -d 'chat_id=${chatId}&text=${message}'"
}

def getCurrentTime() {
    return new Date().format("yyyy-MM-dd HH:mm:ss")
}

def getGitBranch() {
    return sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
}
