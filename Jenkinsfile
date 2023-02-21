pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'jenkins-polybot'
        DOCKER_HUB_REPO = 'deanosaurx'
    }
    stages {
        stage('telegram') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'TELEGRAM', passwordVariable: 'TELEGRAM_TOKEN', usernameVariable: 'NO_NEED')]) {
                    sh 'echo "${TELEGRAM_TOKEN}" > .telegramToken'
                }
            }
        }            
        stage('Build') {
            steps {
                sh 'sudo docker build -t $DOCKER_IMAGE .'
            }
        }
        stage('Tag') {
            steps {
                sh 'sudo docker tag $DOCKER_IMAGE $DOCKER_HUB_REPO/$DOCKER_IMAGE:${BUILD_NUMBER}'
            }
        }
        stage('Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'DOCKER_HUB', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                    sh "sudo docker login -u $DOCKER_HUB_USERNAME -p $DOCKER_HUB_PASSWORD"
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'DOCKER_HUB', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                    sh "sudo docker push $DOCKER_HUB_REPO/$DOCKER_IMAGE:${BUILD_NUMBER}"
                }
            }                
        }
    }
}
