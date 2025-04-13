FROM jenkins/jenkins:lts

USER root

# Install Docker and setup docker group
RUN apt-get update && \
    apt-get install -y docker.io && \
    groupadd docker || true && \
    usermod -aG docker jenkins && \
    chown -R jenkins:jenkins /var/jenkins_home

USER jenkins

