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
        script {
          docker.image('hashicorp/terraform:latest').inside {
            dir('terraform') {
              sh 'terraform init'
            }
          }
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        script {
          docker.image('hashicorp/terraform:latest').inside {
            dir('terraform') {
              sh 'terraform apply -auto-approve'
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
