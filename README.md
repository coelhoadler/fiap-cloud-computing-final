# Trabalho acadêmico FIAP 75aoj 2020

Este é o trabalho final de CLOUD COMPUTING & SRE, lecionado pelo professor Rafael Barbosa.

## Integrantes

* 336959 – Adler Coelho
* 337098 – Beatriz Bafini 
* 337317 – Kelvin Marques
* 338111 – Michel Santana

## Infra do Terraform

### Construindo o bucket back end

Navegue pelo terminal até a pasta `S3` e execute os comando `terraform init` e `terraform apply -auto-approve`.

### Construindo a Infra

Navegue pelo terminal até a pasta `Infra` e execute os comando `terraform init` e `terraform apply -auto-approve`.

### Requisitos

[x] Os 2 SQS e o SNS serão criados com terraform. Assim como a regra de DLQ que deve ser de
apenas uma tentativa na fila principal.

[x] O nome dos recursos deve conter o ambiente o qual pertence. Você fará isso concatenando o
nome do workspace no qual foi aplicado. EX: SQS-princial-dev

[x] Deve ser configurado um estado remoto para o bucket do s3 utilizado em aula (Construímos um novo bucket caso ele não exista).

O terraform deve ter os seguinte outputs:
  * [x] ARN da fila sqs principal
  * [x] ARN da fila sqs DLQ
  * [x] URL da fila sqs principal
  * [x] ARN do SNS criado
  * [ ] Deve ser utlizado workspaces para fazer deploy do ambiente de produção[prod] e desenvolvimento[dev]
  * [ ] O SNS deve ter uma subscrição de um email(ou vários) para receber o que chega na fila DLQ. Essa
subscrição pode ser manual ou no terraform.

## Infra do Serverless

### Requisitos

Crie na sua linguagem preferido e suportada pelo lambda as 3 funções descritas no desenho
assim como o api gateway.
  * [ ] A primeira função responde um uma API no path /inseresqs e insere o payload no SQS.
  * [ ] A segunda função deve receber lotes de uma mensagem do SQS principal e imprimir o
conteúdo.
  * [ ] A terceira função esta conectada a fila SQS. Recebe lotes de uma mensagem e publicar no
tópico SNS criado.
  * [ ] Deve ser utlizado o mesmo código e configuração serverless yml para fazer deploy no 2
ambientes e não pode dar conflito de nomes ou apontar para os recursos errados.
  * [ ] Adicione X-Ray aos lambdas e api gateway.