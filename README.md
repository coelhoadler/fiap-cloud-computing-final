# Trabalho acadêmico FIAP 75aoj

Este é o trabalho final de CLOUD COMPUTING & SRE, lecionado pelo professor Rafael Barbosa.

## Integrantes

* 336959 – Adler Coelho
* 337098 – Beatriz Bafini 
* 337317 – Kelvin Marques
* 338111 – Michel Santana

## Rodando a Infra

### Construindo o bucket back end

Navegue pelo terminal até a pasta `S3` e execute os comando `terraform init` e `terraform apply -auto-approve`.

### Construindo a Infra do Terraform

Navegue pelo terminal até a pasta `Infra` e execute os comando `terraform init` e `terraform apply -auto-approve`.

### Construindo o Serverless

Navegue pelo terminal até a pasta `Serverless` e 
Configure no arquivo serverless.yml na sessão custom os outputs gerados pelo terraform
Exemplo:
```
custom
  stage: 'dev'
  userId: '085297972612'
```

execute o commando `sls deploy` 

### Postando uma mensagem no lambda insert

Com a url retornada após o deploy
Em qualquer ferramenta de requisições HTTP utilize [POST] em https://${url}/insertsqs
Mande um body em json 

### Postando uma mensagem no lambda para ir ao DLQ

No serviço receiver, force uma exception e depois refaça o deploy
`sls deploy`
A mesagem que seria lida e excluída será enviada para a DLQ.

### DLQ > SNS

As mensagens que caem na DLQ são automáticamente enviadas para as subscrições do sns
(obs. Subscrições para e-mail via terraform, de acordo com a documentação do terraform, não funciona. 
Fazer subscrição manualmente.)

## Requisitos do projeto

### Infra do Terraform

* [x] Os 2 SQS e o SNS serão criados com terraform. Assim como a regra de DLQ que deve ser de
apenas uma tentativa na fila principal.

* [x] O nome dos recursos deve conter o ambiente o qual pertence. Você fará isso concatenando o
nome do workspace no qual foi aplicado. EX: SQS-princial-dev

* [x] Deve ser configurado um estado remoto para o bucket do s3 utilizado em aula (Construímos um novo bucket caso ele não exista).

O terraform deve ter os seguinte outputs:
  * [x] ARN da fila sqs principal
  * [x] ARN da fila sqs DLQ
  * [x] URL da fila sqs principal
  * [x] ARN do SNS criado
  * [x] Deve ser utlizado workspaces para fazer deploy do ambiente de produção[prod] e desenvolvimento[dev]
  * [x] O SNS deve ter uma subscrição de um email(ou vários) para receber o que chega na fila DLQ. Essa
subscrição pode ser manual ou no terraform.
    * NOTA: As subscrições no SNS foram feitas no terraform para sms, pois o protocolo email SMTP não é suportado no terraform, conforme diz [esta documentação] (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription#email) do próprio terraform.

### Infra do Serverless

Crie na sua linguagem preferido e suportada pelo lambda as 3 funções descritas no desenho
assim como o api gateway.
  * [x] A primeira função responde um uma API no path /inseresqs e insere o payload no SQS. (Verificar! está fazendo dois payloads. Ainda não analisei)
  * [x] A segunda função deve receber lotes de uma mensagem do SQS principal e imprimir o
conteúdo.
  * [x] A terceira função esta conectada a fila SQS. Recebe lotes de uma mensagem e publicar no
    * Essa função está dando erro de Permissão devido a licença "educate"
tópico SNS criado.
  * [ ] Deve ser utlizado o mesmo código e configuração serverless yml para fazer deploy no 2
ambientes e não pode dar conflito de nomes ou apontar para os recursos errados.
  * [x] Adicione X-Ray aos lambdas e api gateway.
