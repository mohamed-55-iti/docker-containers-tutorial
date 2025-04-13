pipeline {
  agent any

  environment {
    TF_VAR_aws_access_key = credentials('aws_access_key')
    TF_VAR_aws_secret_key = credentials('aws_secret_key')
  }

  stages {
    stage('Checkout') {
      steps {
        echo '🔄 Checking out the code...'
        checkout scm
      }
    }

    stage('Debug Terraform Volume') {
      steps {
        echo '📂 Checking Terraform directory contents...'
        sh '''
          docker run --rm -v ${WORKSPACE}/terraform:/workspace -w /workspace alpine sh -c "ls -la"
        '''
      }
    }

    stage('Terraform Init') {
      steps {
        echo '🚀 Initializing Terraform...'
        sh '''
          docker run --rm \
            -e TF_VAR_aws_access_key=$TF_VAR_aws_access_key \
            -e TF_VAR_aws_secret_key=$TF_VAR_aws_secret_key \
            -v ${WORKSPACE}/terraform:/workspace \
            -w /workspace \
            terraform-with-bash terraform init
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
            -v ${WORKSPACE}/terraform:/workspace \
            -w /workspace \
            terraform-with-bash terraform apply -auto-approve
        '''
      }
    }

    stage('Wait for instance') {
      steps {
        echo '⏳ Waiting for the instance to be ready...'
        sleep(time:30, unit:"SECONDS")
      }
    }

    stage('Run Ansible') {
      steps {
        echo '🛠️ Running Ansible...'
        sh '''
          docker run --rm \
            -v ${WORKSPACE}/ansible:/ansible \
            -v ${WORKSPACE}/ansible/hosts:/etc/ansible/hosts \
            ansible-image ansible-playbook /ansible/playbook.yml
        '''
      }
    }
  }
}
