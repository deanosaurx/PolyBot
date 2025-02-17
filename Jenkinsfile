pipeline {
    agent {
        docker {
            image 'deanosaurx/jenkins-agent:latest'
            args  '--user root -v /var/run/docker.sock:/var/run/docker.sock'
            }
        }
    options {
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '30'))
        disableConcurrentBuilds()
        timeout(time: 10, unit: 'MINUTES')
    }
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
        stage('Docker Login & Build') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'DOCKER_HUB', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                    sh "docker login -u $DOCKER_HUB_USERNAME -p $DOCKER_HUB_PASSWORD"
                }
                sh 'docker build -t $DOCKER_IMAGE .'
                sh 'docker tag $DOCKER_IMAGE $DOCKER_HUB_REPO/$DOCKER_IMAGE:latest'
                sh 'docker tag $DOCKER_IMAGE $DOCKER_HUB_REPO/$DOCKER_IMAGE:polybot-${BUILD_NUMBER}'
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'DOCKER_HUB', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                    sh "docker push $DOCKER_HUB_REPO/$DOCKER_IMAGE:latest"
                    sh "docker push $DOCKER_HUB_REPO/$DOCKER_IMAGE:polybot-${BUILD_NUMBER}"
                }
            }                
        }
        stage('Clean up Docker images') {
            steps {
                sh 'docker image prune -af'
            }
            post {
                always {
                    sh 'docker image prune -af'
                }
            }
        }
    }
}
