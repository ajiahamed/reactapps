pipeline {
    agent {
        label 'worker'
    }
    environment {
        GIT_URL = 'https://github.com/ajiahamed/reactapps.git'
    }

    stages {

        stage('StartingPipline') {
            steps {
                script {
                    sendTelegramMessage('Pipeline for reactapp is starting... ' + getCurrentTime())
                }
            }
            post {
                success {
                    script {
                        sendTelegramMessage('[✅] Preparation stage completed successfully.')
                    }
                }
                failure {
                    script {
                        sendTelegramMessage('[❌] Preparation stage failed.')
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
            post {
                success {
                    script {
                        sendTelegramMessage('[✅] Dependencies stage completed successfully.')
                    }
                }
                failure {
                    script {
                        sendTelegramMessage('[❌] Dependencies stage failed.')
                    }
                }
            }
        }

        stage('Build Project') {
            steps {
                sh 'npm run build'
            }
            post {
                success {
                    script {
                        sendTelegramMessage('[✅] Build stage completed successfully.')
                    }
                }
                failure {
                    script {
                        sendTelegramMessage('[❌] Build stage failed.')
                    }
                }
            }
        }
        
        stage('Deploy to Apache') {
            steps {
                //sh 'cp -r build/* /opt/jenkins'
                sh 'ssh nix@192.168.122.97 "rm -rf /opt/jenkins/reactapp/*"'
                sh 'scp -r build/* nix@192.168.122.97:/opt/jenkins/reactapp'
            }
            post {
                success {
                    script {
                        sendTelegramMessage('[✅] Deploy stage completed successfully.')
                    }
                }
                failure {
                    script {
                        sendTelegramMessage('[❌] Deploy stage failed.')
                    }
                }
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

    sh "curl -X POST 'https://api.telegram.org/bot${botToken}/sendMessage' -d 'chat_id=${chatId}&text=${message}'"
}

def getCurrentTime() {
    return new Date().format("yyyy-MM-dd HH:mm:ss")
}

def getGitBranch() {
    return sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
}
