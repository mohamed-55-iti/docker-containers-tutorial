pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY = credentials('aws-access-key')
        AWS_SECRET_KEY = credentials('aws-secret-key')
    }

    stages {
        stage('Checkout') {
            steps {
                echo '🔄 Checking out the code...'
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    docker.image('hashicorp/terraform:latest').inside('-u root --entrypoint=""') {
                        dir('terraform') {
                            sh 'terraform --version'
                            sh 'terraform init'
                        }
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    docker.image('hashicorp/terraform:latest').inside('-u root --entrypoint=""') {
                        dir('terraform') {
                            sh '''
                            terraform apply -auto-approve \
                              -var="aws_access_key=$AWS_ACCESS_KEY" \
                              -var="aws_secret_key=$AWS_SECRET_KEY"
                            '''
                        }
                    }
                }
            }
        }

        stage('Wait for instance') {
            steps {
                sh 'sleep 60'
            }
        }

        stage('Run Ansible') {
            steps {
                dir('ansible') {
                    sh '''
                    ansible-playbook -i hosts playbook.yml \
                      --private-key /root/test.pem \
                      -u ec2-user
                    '''
                }
            }
        }
    }
}

