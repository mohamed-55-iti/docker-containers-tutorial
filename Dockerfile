FROM jenkins/jenkins:lts

# تثبيت terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | tee /etc/apt/trusted.gpg.d/hashicorp.asc
RUN apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update && apt-get install terraform

