FROM garland/aws-cli-docker

WORKDIR /devops

ENV TERRAFORM_VERSION 0.12.29

RUN apk add --update ansible curl
RUN cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

COPY . /devops/

RUN cd ansible

CMD ansible-playbook /devops/ansible/stack-sqs.yml