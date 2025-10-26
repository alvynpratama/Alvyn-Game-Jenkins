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
                
                // Hentikan paksa container dengan nama yang sama, abaikan error jika tidak ada
                // '& exit /b 0' adalah cara 'bat' untuk melanjutkan meski perintah gagal
                bat 'docker stop alvyn-game-app & exit /b 0'
                
                // Hapus paksa container dengan nama yang sama, abaikan error jika tidak ada
                bat 'docker rm alvyn-game-app & exit /b 0'

                // Jalankan 'down' untuk membersihkan (sekarang harusnya aman)
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

