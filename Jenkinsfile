pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'polybot'
        DOCKER_HUB_REPO = 'deanosaurx/jenkins-polybot'
    }
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }
        stage('Tag') {
            steps {
                sh 'docker tag $DOCKER_IMAGE $DOCKER_HUB_REPO/$DOCKER_IMAGE'
            }
        }
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'DOCKER_HUB', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                    sh "docker login -u $DOCKER_HUB_USERNAME -p $DOCKER_HUB_PASSWORD"
                    sh "docker push $DOCKER_HUB_REPO/$DOCKER_IMAGE"
                }
            }
        }
    }
}