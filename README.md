
# 🚗 Rent-a-Car API

Este projeto é uma API backend para gerenciamento de **locações de veículos**, desenvolvida com foco em um ambiente cloud-native utilizando serviços da **Azure**, como o **Service Bus** e **Container Apps**.

## 📦 Funcionalidades

- Criação de registros de locações de veículos.
- Envio de mensagens com os dados da locação para uma **fila do Azure Service Bus**.
- Suporte a CORS para integração com frontends diversos.
- Middleware para parsing de JSON.
- Estrutura preparada para autenticação com `DefaultAzureCredential`.

## 🛠️ Tecnologias Utilizadas

- [Node.js](https://nodejs.org/)
- [Express](https://expressjs.com/)
- [Azure Service Bus SDK](https://www.npmjs.com/package/@azure/service-bus)
- [dotenv](https://www.npmjs.com/package/dotenv)
- [CORS](https://www.npmjs.com/package/cors)

## 📁 Estrutura do Projeto

```bash
rent-a-car/
│
├── .env.example          # Exemplo de variáveis de ambiente
├── index.js              # Arquivo principal da API
├── package.json
├── Dockerfile            # Arquivo para build da imagem local
└── README.md             # Documentação do projeto
```

## ▶️ Como Executar o Projeto

### 1. Pré-requisitos

- Node.js instalado (versão 16 ou superior)
- Conta no [Microsoft Azure](https://azure.microsoft.com/)
- Azure Service Bus com uma fila chamada `fila-locacao-auto`

### 2. Configuração

Clone o repositório e instale as dependências:

```bash
git clone https://github.com/oMaestro174/azure-cloud-native-lab007.git
cd azure-cloud-native-lab007
npm install
```

Crie um arquivo `.env` com as variáveis de ambiente necessárias:

```env
AZURE_CLIENT_ID=<seu-client-id>
AZURE_TENANT_ID=<seu-tenant-id>
AZURE_CLIENT_SECRET=<seu-client-secret>
SERVICE_BUS_CONNECTION_STRING="Endpoint=sb://<seu-servicebus>.servicebus.windows.net/;SharedAccessKeyName=...;SharedAccessKey=..."
```

### 3. Executar o Servidor

```bash
node index.js
```

O servidor ficará disponível em: [http://localhost:3001](http://localhost:3001)

## 🔁 Endpoints

### POST `/api/locacao`

**Descrição**: Envia uma solicitação de locação para a fila no Azure Service Bus.

**Corpo da Requisição**:
```json
{
  "nome": "João",
  "email": "taguardado.net@gmail.com",
  "modelo": "Fusca",
  "ano": 1970,
  "tempoAluguel": 5
}
```

**Resposta de Sucesso (200)**:
```json
{
  "message": "Locação de veiculo enviada para a fila com sucesso para o Service Bus"
}
```

**Erro (500)**:
```json
{
  "message": "Erro ao enviar mensagem para o Service Bus"
}
```

## 🐳 Rodando a imagem localmente com docker

**Build**: Faça o build da imagem local:

```bash

docker build -t bff-rent-a-car-local

```


**Run**: Rode a imagem local para testar a build:

```bash

docker run -d -p 3001 bff-rent-a-car-local

```


**Teste**: Refaça os testes na api como no tópico 3  



## ☁️ Publicando em um enviroment do Azure


**Login**: Faça login no seu tenant 


```bash

az login

```



**Login no ACR**: Faça login no seu acr para enviar a imagem 


```bash

az acr login --name acrlab007jvieira

```



**Tag da Imagem**: Adicione uma tag para imagem antes do envio ao ACR 


```bash

docker tag bff-rent-a-car-local acrlab007jvieira.azurecr.io/bff-rent-a-car-local:latest

```


**Push da Imagem**: Faça o push da imagem para o ACR 


```bash

docker push acrlab007jvieira.azurecr.io/bff-rent-a-car-local:latest

```



**Crie um enviroment**: Faça login no seu tenant 


```bash

az containerapp env create --name bff-rent-a-car-local --resource-group LAB007 --location eastus


```


**Crie um Container APP**: crie um container app para a imagem que subiu no acr


```bash

az containerapp create --name bff-rent-a-car-local --environment bff-rent-a-car-local --resource-group LAB007 --image acrlab007jvieira.azurecr.io/bff-rent-a-car-local:latest --target-port 3001 --ingress 'external'  --revision-suffix latest


```





## 🐞 Problemas Conhecidos

- **Credenciais Sensíveis**: A string de conexão do Service Bus estava inicialmente hardcoded. Isso foi identificado como uma falha de segurança.
- **Validação de Dados**: Falta de validação nos campos enviados pelo cliente.
- **Tratamento de Erros**: Poderia fornecer mensagens mais específicas e rastreáveis.
- **Dependência de Ambiente Azure**: Erros ao tentar criar ambientes do Container App impediram o deploy completo.

## 🛑 Motivo da Interrupção do Projeto

Apesar do backend estar funcional e a imagem Docker ter sido publicada com sucesso no Azure Container Registry, não conseguimos prosseguir com o deploy no serviço **Azure Container Apps** por limitações da própria **assinatura do Azure** utilizada:

- A **região `East US`** já possuía o número máximo de ambientes permitidos.
- A tentativa de criar um novo ambiente em **`East US 2`** resultou em erro de cota global.
- A criação do container usando um ambiente pré-existente falhou porque o grupo de recursos estava em processo de **deprovisionamento**.
- Um erro de digitação ao tentar usar `az app containerapp create` causou frustração e confusão adicional durante os testes.

Esses fatores impossibilitaram o deploy final do container, interrompendo a continuação do laboratório em ambiente cloud-native.

## 📷 Prints do Processo

Durante o desenvolvimento e tentativa de deploy, foram capturados **16 prints de tela** que ilustram tanto o funcionamento da API localmente quanto os erros enfrentados na criação do container na Azure.  
Eles estão armazenados na pasta `assets/` no repositório e organizados na ordem cronológica dos testes.



### Criado o Resource Group
![Tela da aplicação](/assets/01-criado-resource-group-lab007.png)

### Criando o ACR Azure Container Registry
![Tela da aplicação](/assets/02-criado-azure-container-registry-lab007.png)


### Criando Container APP
![Tela da aplicação](/assets/03-criado-containerapp-dev-lab001.png)


### Criando Function APP
![Tela da aplicação](/assets/04-criando-function-app-lab007-dev-eastus.png)


### Instanciando Servidor Azure SQL
![Tela da aplicação](/assets/05-criando-server-sql.png)


### Criando Uma Database no Azure SQL
![Tela da aplicação](/assets/06-criando-database-sql.png)


### Criando o Service Bus
![Tela da aplicação](/assets/07-criando-service-bus.png)


### Erro ao Criar CosmosDB
![Tela da aplicação](/assets/08-erro-de-regiao-lcosmodb.png)


### Preparando Ambiente Node JS
![Tela da aplicação](/assets/09-preparando-ambiente-node.png)


### Codificação da API Locação
![Tela da aplicação](/assets/10-codificando-locadora.png)

### Testando a API Locação no Postman
![Tela da aplicação](/assets/17-testes-da-api-com-postman.png)


### Processando a Fila Service Bus
![Tela da aplicação](/assets/11-preocessando-fila-service-bus.png)


### Build do Container
![Tela da aplicação](/assets/12-build-container-bff-rent-a-car-local.png)


### Enviando a Imagem Para o ACR
![Tela da aplicação](/assets/13-enviando-imagem-para-acr.png)


### Erros de Limitação de Região ou Licença
![Tela da aplicação](/assets/14-erros-de-licenca-e-regiao.png0


### Erros ACR
![Tela da aplicação](/assets/15-erro-container-registry.png)


### Lista de Recursos LAB007 (Resouce Group)
![Tela da aplicação](/assets/16-resource-group-lab007-e-seus-itens.png)


## ✅ Melhorias Futuras

- Mover a string de conexão para o `.env` e usar `process.env`.
- Implementar validação de dados com Joi ou Zod.
- Adicionar testes unitários (ex: com Jest).
- Automatizar deploy com GitHub Actions + Azure CLI.
- Implementar autenticação e controle de acesso.
- Trocar o ambiente de deploy para Kubernetes via AKS ou outro PaaS viável.

## 🤝 Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir *issues* ou enviar *pull requests* com melhorias.

## 📄 Licença

Este projeto está sob a licença [MIT](LICENSE).
