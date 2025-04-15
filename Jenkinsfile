@Library('jenkins-shared-library') _  // This imports the shared library

pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/your-user/your-repo'  // URL of your GitHub repository (where Dockerfile is located)
        IMAGE_NAME = 'your-docker-image-name'  // Docker image name (this will be the name of the Docker image in Docker Hub)
    }

    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Call the function from the shared library
                    buildAndPushDockerImage(REPO_URL, 'main', IMAGE_NAME)
                }
            }
        }
    }
}
