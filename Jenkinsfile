pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Mengambil kode...'
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Memulai build Docker image...'
                bat 'docker-compose build react-native-web'
            }
        }
        
        stage('Run Docker Container') {
            steps {
                echo 'Menjalankan container...'
                bat 'docker stop alvyn-game-app || exit 0'
                bat 'docker rm alvyn-game-app || exit 0'
                bat 'docker run -d --name alvyn-game-app -p 8081:8080 alvyngame_react-native-web'
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline selesai.'
        }
    }
}

