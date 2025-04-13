pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo '🔄 Checking out the code...'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo '⚙️ Building the project...'
                sh 'echo "Building the project..."'
                // أو هنا تضيف أمر بناء خاص بمشروعك مثل `npm install` أو `mvn clean install`
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Running tests...'
                sh 'echo "Running tests..."'
                // هنا تضيف أمر اختبار مثل `npm test` أو `mvn test`
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 Deploying the project...'
                sh 'echo "Deploying..."'
                // هنا تضيف أمر النشر (مثل نشر على سيرفر أو إلى خدمة مثل Heroku أو AWS)
            }
        }
    }
}

