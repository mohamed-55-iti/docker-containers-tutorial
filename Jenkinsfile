pipeline {
  agent any

  environment {
    TF_VAR_aws_access_key = credentials('AWS_ACCESS_KEY') // تأكد من أن هذا هو الاسم الصحيح للـ credentials في Jenkins
    TF_VAR_aws_secret_key = credentials('AWS_SECRET_KEY') // تأكد من أن هذا هو الاسم الصحيح للـ credentials في Jenkins
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
        docker.image('hashicorp/terraform:latest').inside {
          dir('terraform') {
            sh 'terraform init'
          }
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        echo '🚀 Applying Terraform changes...'
        docker.image('hashicorp/terraform:latest').inside {
          dir('terraform') {
            sh 'terraform apply -auto-approve'
          }
        }
      }
    }

    stage('Wait for instance') {
      steps {
        echo '⏳ Waiting for instance to be ready...'
        sh 'sleep 60' // يمكنك تغيير الوقت حسب احتياجك
      }
    }

    stage('Run Ansible') {
      steps {
        echo '⚙️ Running Ansible playbook...'
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

