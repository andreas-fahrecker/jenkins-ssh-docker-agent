#!groovy

pipeline {
    agent {
        label 'linux'
    }

    stages {
        stage('Build/Push Docker Image') {
            when {
                beforeAgent true;
                branch 'main'
            }
            stages {
                stage('Login') {
                    environment {
                        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-fah16145')
                    }
                    steps {
                        sh 'docker login -u ${DOCKER_HUB_CREDENTIALS_USR} -p ${DOCKER_HUB_CREDENTIALS_PSW}'
                    }
                }
                stage('Build & Push') {
                    parallel {
                        stage('Default Image') {
                            stages {
                                stage('Build Default Image') {
                                    steps {
                                        sh 'docker build -t fah16145/jenkins-ssh-docker-agent:latest .'
                                    }
                                }
                                stage('Push Default Image') {
                                    steps {
                                        sh 'docker push fah16145/jenkins-ssh-docker-agent:latest'
                                    }
                                }
                            }
                        }
                        stage('Alpine Image') {
                            stages {
                                stage('Build Alpine Image') {
                                    steps {
                                        sh 'docker build -t fah16145/jenkins-ssh-docker-agent:alpine alpine/'
                                    }
                                }
                                stage('Push Alpine Image') {
                                    steps {
                                        sh 'docker push fah16145/jenkins-ssh-docker-agent:alpine'
                                    }
                                }
                            }
                        }
                    }
                }
            }
            post {
                always {
                    sh 'docker logout'
                }
            }
        }
    }
}
