pipeline {
    agent {   
        label 'agent1'
    }

    environment {
        DOCKER_IMAGE = 'shehab19/book-tracker-devops'
    }

    stages {
        stage('fetch code') {
            steps {
                git url: 'git@github.com:shehab-19/book-tracker-devops.git', branch: 'main'
            }
        }

        stage('determine version') {
            steps {
                script {
                    def tags = sh(script: "docker images --format '{{.Tag}}' ${DOCKER_IMAGE} | sort -V", returnStdout: true).trim().split('\n')
                    def lastTag = tags[-1] == '' ? '0' : tags[-1]
                    env.IMAGE_TAG = (lastTag.toInteger() + 1).toString()
                }
            }
        }

        stage('build the image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:v${IMAGE_TAG} ."
            }
        }

        stage('login to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh '''
                        echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin
                        '''
                    }
                }
            }
        }

        stage('push the image') {
            steps {
                sh "docker push ${DOCKER_IMAGE}:v${IMAGE_TAG}"
            }
        }
    }

    post {

        always {
            sh "docker rmi ${DOCKER_IMAGE}:v${IMAGE_TAG}"
        }

        success {
            echo "Build and push completed successfully with tag v${IMAGE_TAG}"
        }
        failure {
            echo 'Build failed'
        }
        
    }
}
