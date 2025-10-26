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
                bat 'docker-compose build my-react-native-web-app'
            }
        }
        
        stage('Run Docker Container') {
            steps {
                echo 'Menjalankan container...'
                
                bat 'docker stop my-rn-web-container || exit 0'
                
                bat 'docker rm my-rn-web-container || exit 0'
                
                bat 'docker run -d --name my-rn-web-container -p 8081:8080 alvyngame_my-react-native-web-app'
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline selesai.'
        }
    }
}

