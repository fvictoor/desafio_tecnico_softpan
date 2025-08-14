# Desafio Técnico - (QA Sênior) - SoftPlan

Este projeto demonstra uma esteira de automação de testes ponta a ponta, utilizando **Robot Framework** para testar uma aplicação web e api, onde vamos realizar cadastro de usuários, login e validação do carrinhos de campras.

---

## Principais Validações

* **Automação de Testes Web:** Scripts robustos com Robot Framework e Browser Library.
Na automação de testes Web faremos as seguintes validações:
    - Cadastro de usuário Comum
    - Cadastro de usuário Administrador
    - Validação dos campos de Cadastro
        - Validar mensagem de erro do campo com um e-mail inválido
        - Validar mensagem de erro do campo com um Nome em branco
        - Validar mensagem de erro do campo com um E-mail em branco
        - Validar mensagem de erro do campo com uma Senha em branco
    - Validação de Login com um usuário Comum
    - Validação do Login com um usuário Administrador
    - Validação dos campos de Login
        - Validar mensagem de erro com o campo de Email em branco
        - Validar mensagem de erro com o campo de Senha em branco
        - Validar mensagem de erro com o campo de Email inválido
    - Validação de inclusão na lista de compras
    - Validação de limpeza da lista de compras
    
    

* **Automação de Testes API:** Scripts robustos com Robot Framework e Resquest Library.
Na automação de testes via API, faremos as seguintes validações:
    - Validação de cadastro de usuário
        - Validação de cadastro de um usuário comum e a exclusão do mesmo
        - Validação de cadastro de um usuário Administrador e a exclusão do mesmo
        - Validação de um cadastro com um usuário sem preencher o nome, sem email e sem senha
        - Validação de um cadastro de usuário com o mesmo E-mail usado anteriormente
        - Validando a edição de um usuário
    - Validação de cadastro de produto
        - Validação de cadastro de produto como Administrador
        - Validação de cadastro de produto como usuário comum, com validação da mensagem de erro esperada
        - Validação de cadastro de produto sem informar o token
        - Validação de cadastro de produto com o mesmo nome
        - Validação de cadastro de produto sem informar nome, preço, quantidade e descrição
* **Geração de Dados Falsos:** Utilização da Faker Library para criar dados de teste dinâmicos.
* **Execução Paralela:** Testes mais rápidos com o uso do Pabot para execuções em múltiplas threads.
* **Notificações via Webhook:** Envio de status da execução para canais como Discord ou Slack.
* **Dashboard Interativo:** Geração de um relatório HTML consolidado e visualmente agradável.
* **Relatórios por E-mail:** Envio automático do dashboard para as partes interessadas.
* **Integração com CI/CD:** Preparado para rodar em pipelines e integração contínua como o GitHub Actions.

---

## Tecnologias Utilizadas

| Tecnologia | Descrição | Documentação |
| :--- | :--- | :--- |
| **Robot Framework** | Framework principal para automação de testes. | [Acessar](https://robotframework.org/?tab=1#getting-started) |
| **JSON Library** | Biblioteca para manipulação de objetos JSON | [Acessar](https://github.com/robotframework-thailand/robotframework-jsonlibrary) |
| **Requests Library** | Biblioteca para realizar requisições HTTP com o Robot Framework | [Acessar](https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html) |
| **Browser Library** | Biblioteca para automação de testes web. | [Acessar](https://marketsquare.github.io/robotframework-browser/Browser.html) |
| **Pabot** | Ferramenta para execução paralela de testes. | [Acessar](https://github.com/mkorpela/pabot) |
| **Faker Library** | Biblioteca para geração de dados dinâmicos. | [Acessar](https://guykisel.github.io/robotframework-faker/) |
| **Jinja2** | Motor de templates para a criação do dashboard. | [Acessar](https://github.com/pallets/jinja) |
| **Pandas** | Biblioteca para manipulação e análise de dados. | [Acessar](https://github.com/pandas-dev/pandas) |
| **Requests** | Biblioteca para realizar requisições HTTP (API). | [Acessar](https://github.com/psf/requests) |
| **python-dotenv** | Gerenciamento de variáveis de ambiente. | [Acessar](https://github.com/theskumar/python-dotenv) |

---

## Primeiros Passos

Siga os passos abaixo para configurar e executar o projeto em seu ambiente local.

### 1. Pré-requisitos

Certifique-se de que você tem os seguintes softwares instalados:

* [Python 3.x](https://www.python.org/downloads/)
* [Node.js (versão LTS)](https://nodejs.org/en/download/)

### 2. Instalação das Dependências

Com os pré-requisitos atendidos, instale as bibliotecas Python necessárias com um único comando:

```bash
python -m pip install -U pip
pip install -U robotframework
pip install -U robotframework-browser
pip install -U robotframework-faker
pip install -U robotframework-jsonlibrary
pip install -U robotframework-requests
pip install -U robotframework-pabot
pip install -U requests
pip install -U pandas
pip install -U Jinja2
pip install -U python-dotenv
```
Ou você pode realizar a instalação de todas as dependencias com um único comando ultilizando o arquivo ``requirements.txt``
```
pip install -r requirements.txt
```

### 3. Inicialização da Browser Library

Após a instalação, a Browser Library precisa ser inicializada. Este comando fará o download dos binários dos navegadores necessários.

```bash
rfbrowser init
```

---

## Configuração

Antes de executar os testes, é necessário configurar as variáveis de ambiente para as notificações.

### Webhook para Notificações

Para que o status da execução seja enviado, configure a URL do seu webhook no arquivo `.env`.

* **Arquivo:** `libs/report_robotframework_webhook/report/.env`
* **Conteúdo:** 
``` ini
# URL do Webhook
WEBHOOK_URL="SUA URL DO WEBHOOK"

# Tags que o script deve procurar, separadas por vírgula
TAGS="frontend,api,positivo,negativo"
```
### Envio de E-mail

Para enviar o dashboard por e-mail, configure as credenciais de uma conta de e-mail (recomenda-se o uso de uma conta dedicada para automação).

* **Arquivo:** `libs/robot_report_email/robot_report_email/.env`
* **Conteúdo:**

```ini
# Configuração do remetente
EMAIL_REMETENTE="seu_email@dominio.com"
EMAIL_SENHA="sua_senha_de_app"
SMTP_SERVIDOR="smtp.gmail.com"
SMTP_PORTA="587"

# Lista de destinatários (separados por vírgula)
EMAIL_DESTINATARIOS="destinatario1@dominio.com,destinatario2@dominio.com"
```

> **Importante:** Para contas do Gmail, é necessário gerar uma **[Senha de App](https://support.google.com/accounts/answer/185833?hl=pt)** para usar no campo `EMAIL_SENHA`.

---

## Executando a Suite de Testes

O fluxo de execução foi projetado para ser simples e eficiente.

### Passo 1: Execução Principal dos Testes

Execute todos os testes em paralelo. Os resultados serão salvos no diretório `./log`.

```bash
pabot --testlevelsplit --processes 4 --outputdir ./log --include cadastro .\tests\
```

### Passo 2: Re-execução dos Testes que Falharam (Opcional)

Caso queira re-executar apenas os cenários que falharam na primeira execução, utilize o comando abaixo. Os resultados serão salvos em `./log/rerun`.

```bash
pabot --testlevelsplit --processes 4 --outputdir ./log/rerun --rerunfailed ./log/output.xml .\tests\
```

### Passo 3: Geração do Dashboard

Consolide os resultados da execução principal (e da re-execução, se houver) em um único dashboard.

```bash
python ./libs/robot_report_dashboard/robot_report_dashboard/main.py .\log\output.xml .\log\rerun\output.xml --tags "frontend,api,positivo,negativo" --output_dir ".\log" --filename "dashboard_tests.html"
```

* `--tags`: Define quais tags terão destaque no relatório.
* `--output_dir`: Pasta onde o dashboard será salvo.
* `--filename`: Nome do arquivo HTML do dashboard.

### Passo 4: Envio do Relatório por E-mail

Por fim, dispare o e-mail com o dashboard gerado em anexo.

```bash
python .\libs\robot_report_email\robot_report_email\disparador_email.py ./log/dashboard_tests.html
