pipeline {
    agent any

    environment {
        TF_VAR_aws_access_key = credentials('aws-access-key')
        TF_VAR_aws_secret_key = credentials('aws-secret-key')
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
                echo '🚀 Initializing Terraform...'
                sh '''
                    docker run --rm \
                        -e TF_VAR_aws_access_key=$TF_VAR_aws_access_key \
                        -e TF_VAR_aws_secret_key=$TF_VAR_aws_secret_key \
                        -v $(pwd)/terraform:/workspace \
                        -w /workspace terraform-with-bash terraform init
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                echo '🚀 Applying Terraform changes...'
                sh '''
                    docker run --rm \
                        -e TF_VAR_aws_access_key=$TF_VAR_aws_access_key \
                        -e TF_VAR_aws_secret_key=$TF_VAR_aws_secret_key \
                        -v $(pwd)/terraform:/workspace \
                        -w /workspace terraform-with-bash terraform apply -auto-approve
                '''
            }
        }

        stage('Wait for instance') {
            steps {
                echo '⏳ Waiting for instance to be ready...'
                sh 'sleep 60'
            }
        }

        stage('Run Ansible') {
            steps {
                echo '⚙️ Running Ansible playbook...'
                sh '''
                    docker run --rm \
                        -v $(pwd)/ansible:/ansible \
                        -v /root/test.pem:/root/test.pem \
                        -w /ansible \
                        williamyeh/ansible:alpine3 \
                        ansible-playbook -i hosts playbook.yml --private-key /root/test.pem -u ec2-user
                '''
            }
        }
    }
}
