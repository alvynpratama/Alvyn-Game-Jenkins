pipeline {
    agent any

    environment {
        EXPO_TOKEN = credentials('expo-access-token')
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Mengambil kode...'
                checkout scm
            }
        }
        
        stage('Build Docker Image (Web)') {
            steps {
                echo 'Memulai build Docker image...'
                bat 'docker-compose build react-native-web'
            }
        }
        
        stage('Run Docker Container (Web)') {
            steps {
                echo 'Menghentikan container lama (jika ada)...'
                bat 'docker-compose down'
                
                echo 'Menjalankan container baru...'
                bat 'docker-compose up -d react-native-web'
            }
        }

        stage('Build Android APK (Mobile)') {
            steps {
                echo 'Memulai build .apk via Expo Application Services (EAS)...'
                
                bat 'npm install -g eas-cli'
                
                bat 'npm install'
                
                bat 'eas login --token %EXPO_TOKEN%'
                
                bat 'eas build -p android --profile production --non-interactive'
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline selesai.'
        }
    }
}

