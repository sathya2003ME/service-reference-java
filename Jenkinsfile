pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sathya2003ME/service-reference-java.git'
            }
        }

        stage('Build & Start Services') {
            steps {
                sh 'docker-compose up --build -d'
                // Wait for services
                sh 'sleep 25'
            }
        }

        stage('Test App') {
            steps {
<<<<<<< HEAD
                sh 'curl -f http://localhost:9090/hello'
=======
                sh '''
                    for i in {1..30}; do
                      if curl -s http://localhost:9090/hello; then
                        echo "App is UP"
                        exit 0
                      fi
                      echo "Waiting for app..."
                      sleep 5
                    done
                    exit 1
                '''
>>>>>>> 3114b56 (WIP: local changes before rebase)
            }
        }
    }

    post {
        always {
            sh 'docker-compose down || true'
        }
    }
}

