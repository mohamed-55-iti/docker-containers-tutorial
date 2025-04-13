FROM jenkins/jenkins:lts

USER root

# تثبيت الأدوات الأساسية المطلوبة
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    apt-transport-https \
    software-properties-common

# إضافة مستودع HashiCorp وتثبيت Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com bookworm main" \
    > /etc/apt/sources.list.d/hashicorp.list
RUN apt-get update && apt-get install -y terraform

# إضافة bash (عادة موجود مسبقًا، لكن تأكيدًا فقط)
RUN apt-get install -y bash

