pipeline {
    agent any

    environment {
        EXPO_TOKEN = credentials('expo-access-token')
        DOCKER_IMAGE_NAME = 'alvynwira/alvyngame:latest'
    }

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
        
        stage('Push to Docker Hub') {
            environment {
                DOCKER_CREDS = credentials('credentials-dockerhub')
            }
            steps {
                echo 'Logging in to Docker Hub...'
                bat 'docker login -u %DOCKER_CREDS_USR% -p %DOCKER_CREDS_PSW%'
                
                echo "Mendorong (push) image: ${DOCKER_IMAGE_NAME}..."
                bat "docker push ${DOCKER_IMAGE_NAME}"
                
                echo 'Logging out...'
                bat 'docker logout'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo 'Menghentikan container lama (jika ada)...'
                bat 'docker stop alvyn-game-app & exit /b 0'
                bat 'docker rm alvyn-game-app & exit /b 0'
                bat 'docker-compose down'
                
                echo 'Menjalankan container baru...'
                bat 'docker-compose up -d react-native-web'
            }
        }

        stage('Build Android APK (Mobile)') {
            steps {
                echo 'Memulai build .apk via Expo Application Services (EAS)...'
                bat 'npm install eas-cli'
                bat 'npm install'
                echo 'Menjalankan EAS Build (login otomatis menggunakan EXPO_TOKEN)...'
                bat 'npx eas build -p android --profile production --non-interactive'
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline selesai.'
        }
    }
}

