# Devops Teste
  
## Versão dos softwares utilizados:  
Sistema Operacional Linux Ubuntu 18.04
docker 19  
docekr-composer 1.27  
ansible 2.9  
terraform 0.12.29  
NodeJS 12  
  
Este lab tem como finalidade a criação do recurso de mensageria AWS SQS com 2 usuarios AWS IAM com politicas especificas para enviar e receber as mensagens da fila SQS e a criação de 2 aplicações nodejs: uma para enviar as mensagens com o nome sender e receiver para receber as mensagens e enviar para o mongodb (encontradas no path app/sender e app/receiver).  
  
A aplicação sqs_sender esta exposta na porta 8001 com path api para que possamos realizar as requisições de POST para o envio das mensagens ao SQS.  
- http://localhost:8001/api
  
As etapas a seguir foram realizadas num computador com sistema operacional Linux Ubuntu 18.04 e os comandos descritos abaixo devem ser executados num computador com Linux instalado e como pre-requisito ter em execução o docker. Para seguir com os procedimento realize o clone do repositorio com os artefatos do lab. 
* Step 1  
Como primeiro passo, realizar o provisionamento dos recursos AWS executando o docker-compose.yml que encontra-se na pasta infra.  
Acesse a pasta do repositorio clonado e entre na pasta "infra" para seguir:  
  
Como primeira ação, adicionar ao arquivo docker-compose.yml as credenciais AWS com permissão de criação de filas SQS e usuários IAM, recomendo que seja um usuário administrador da conta AWS ou que tenha permissão full nos recursos SQS e IAM.  
Adicionar no valor das variaveis descritas abaixo as credencias:
```
      - AWS_ACCESS_KEY_ID=  
      - AWS_SECRET_ACCESS_KEY=  
```
Após adicionar as credenciais e salvar o arquivo executar o comando abaixo para execução do container que irá realizar o provisionamento dos recursos e expor no log a informação dos recursos criados.

- docker-compose up  
  
Após realizada a execução será necessario copiar as informações expostas no log para adicionar no docker-compose das aplicações.  
Copiar a access_key e secret_key dos usuarios sender_user e receiver_user e copiar a URL correspondente a SQS "sqs-sugestao" para uso das aplicações.  
  
* Step 2
Acessar o repositorio das aplicações do repositorio clonado na pasta apps.  
Como primeira ação, adicionar ao arquivo docker-compose.yml as credenciais AWS destinadas a cada aplicação e a URL da fila SQS nos campos conforme abaixo:  
```
 sender:
    build: ./sender
    environment:
      TZ: America/Sao_Paulo
      SQS_URL: 
      AWS_DEFAULT_REGION: us-east-1
      AWS_ACCESS_KEY_ID: 
      AWS_SECRET_ACCESS_KEY: 
 receiver:
    build: ./receiver
    environment:
      TZ: America/Sao_Paulo
      SQS_URL: 
      MONGO_URL: mongodb://mongodb:27017/
      MONGO_DB: sqs
      MONGO_COLLECTION: sugestao
      AWS_DEFAULT_REGION: us-east-1
      AWS_ACCESS_KEY_ID: 
      AWS_SECRET_ACCESS_KEY: 
```
  
Após adicionar as informações salvar o arquivo e executar o comando abaixo para realizar a execução das aplicações.  
- docker-compose up  
  
Para realizar o teste utilizei a aplicação POSTMAN para fazer a requisição de POST na aplicação de envio de mensagem para o SQS.  
  - http://localhost:8001/api
  
![Alt text](img/postman.png?raw=true "Title")
  
A aplicação de envio de mensagem sqs_sender esta configurada para receber os campos conforme exemplo abaixo. 
- http://localhost:8001/api   
```
{
	"Nome": "Daniel Vieira",
	"Sugestao": "Viajar com a Maxmilhas",
}
```
A aplicação que recebe as mensagens é a sqs_receiver, ela recebe automaticamente as mensagems postadas na fila SQS e faz o insert no banco de dados mongodb.  