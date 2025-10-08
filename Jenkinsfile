pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sathya2003ME/service-reference-java.git'
            }
        }

        stage('Start Services') {
            steps {
                sh 'docker-compose up -d'
                sh 'sleep 20'  // wait for MySQL/Redis
            }
        }

        stage('Build') {
            steps {
                sh './gradlew clean build'
            }
        }

        stage('Run App') {
            steps {
                sh 'nohup java -jar build/libs/service-reference-java-0.0.1-SNAPSHOT.jar &'
                sh 'sleep 10'  // wait for app to boot
            }
        }

        stage('Test App') {
            steps {
                sh 'curl -f http://localhost:9090/hello'
            }
        }
    }

    post {
        always {
            sh 'docker-compose down || true'
            sh 'pkill -f "service-reference-java-0.0.1-SNAPSHOT.jar" || true'
        }
    }
}
