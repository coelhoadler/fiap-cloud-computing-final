# Configurando
Acessar ./Infra
    `$ terraform init`
    `$ terraform plan`
    `$ terraform apply -auto-approve`
Vai criar a infraestrutura 
- SQS
- DLQ
- S3 (AINDA UM MISTÉRIO)

Acessa ./Gateway
    No arquivo src/insert: Modificar a QueueUrl pela recebida do terraform
    No arquivo src/receive: Modificar a QueueUrl pela recebida do terraform
    `$ sls deploy`
    Comando vai fazer o deploy das lambdas

## Postar um payload no SQS:
 [POST]
 {URL}/insertsqs 

## Consumir mensagens do SQS:
 [GET]
 {URL}/printsqs