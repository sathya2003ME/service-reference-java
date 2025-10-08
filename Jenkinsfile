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
        // Kill old app if running
        sh 'pkill -f "service-reference-java-0.0.1-SNAPSHOT.jar" || true'

        // Start fresh app
        sh 'nohup java -jar build/libs/service-reference-java-0.0.1-SNAPSHOT.jar > app.log 2>&1 &'
        sh 'sleep 10'
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
            // Removed pkill so app keeps running
            echo "App is running on port 9090. You can access it from browser."
        }
    }
}
