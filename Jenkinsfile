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
                sh 'sleep 20'  // wait for MySQL and Redis
            }
        }

        stage('Build') {
            steps {
                sh './gradlew clean build'
            }
        }

        stage('Run App') {
            steps {
                // Start Spring Boot JAR in background
                sh 'nohup java -jar build/libs/service-reference-java-0.0.1-SNAPSHOT.jar &'
                sh 'sleep 10'  // give the app time to boot
            }
        }

        stage('Test App') {
            steps {
                // Call the /hello endpoint
                sh 'curl -f http://localhost:9090/hello'
            }
        }
    }

    post {
        always {
            // Stop and clean up services
            sh 'docker-compose down || true'
            // Kill Spring Boot if still running
            sh 'pkill -f "service-reference-java-0.0.1-SNAPSHOT.jar" || true'
        }
    }
}
