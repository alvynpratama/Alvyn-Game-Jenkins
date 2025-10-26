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
                echo 'Menghentikan container lama (jika ada)...'
                bat 'docker-compose down'
                
                echo 'Menjalankan container baru...'
                bat 'docker-compose up -d react-native-web'
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline selesai.'
        }
    }
}

