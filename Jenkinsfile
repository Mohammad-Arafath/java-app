pipeline {
    agent any
    environment {
        SONARQUBE_URL = 'http://localhost:9000'
        DOCKER_REGISTRY = 'mydockerhub/java-app'
    }
    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/Mohammad-Arafath/java-app.git'
            }
        }
        stage('Build Java Application') {
            agent {
                docker {
                    image 'openjdk:17-jdk'
                }
            }
            steps {
                sh 'javac -version'
                sh 'javac src/*.java'
            }
        }
        stage('Run Unit Tests') {
            agent {
                docker {
                    image 'openjdk:11-jdk'
                }
            }
            steps {
                sh 'java -jar test-runner.jar'
            }
        }
        stage('Analyze Code Quality') {
            agent {
                docker {
                    image 'openjdk:8-jdk'
                }
            }
            steps {
                sh 'mvn sonar:sonar -Dsonar.host.url=$SONARQUBE_URL'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_REGISTRY .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                sh 'docker login -u mzamankhan1 -p Khan@2032'
                sh 'docker push $DOCKER_REGISTRY'
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
