*** Settings ***
Resource    ../../resources/base.robot
Documentation    Nesses cenários vamos validar a tela de Login e cadastro no Site
Test Teardown    Take Screenshot    EMBED

*** Test Cases ***
CADASTRO - Realizar um cadastro de um usuário comum
    [Documentation]    Nesse cenário vamos estar realizando o cadastro de um usuário comum no site https://front.serverest.dev/login
    [Tags]    frontend     cadastro    positivo
    Abrir navegador                        ${URL_FRONTEND}
    Clicar em:                             ${LINK_CADASTRO}
    Preencher as informações de cadastro   USER_ADMIN=unchecked    MENSAGEM=Cadastro realizado com sucesso    SUCESS=true 

CADASTRO - Realizar um cadastro de um usuário administrador
    [Documentation]    Nesse cenário vamos estar realizando o cadastro de um usuário administrador no site https://front.serverest.dev/login
    [Tags]    frontend     cadastro    positivo
    Abrir navegador                        ${URL_FRONTEND}
    Clicar em:                             ${LINK_CADASTRO}
    Preencher as informações de cadastro   USER_ADMIN=checked    MENSAGEM=Cadastro realizado com sucesso  SUCESS=true  

CADASTRO - Validar mensagem de erro ao tentar cadastrar um usuário sem nome, sem email e sem senha
    [Documentation]    Nesse cenário vamos estar validando a mensagem de erro ao tentar cadastrar com informações incompletas.
    [Tags]     frontend    cadastro    negativo
    [Setup]    Run Keywords        Abrir navegador    ${URL_FRONTEND}    AND
    ...                            Clicar em:         ${LINK_CADASTRO}
    [Template]        Preencher as informações de cadastro
    EMAIL=teste.com    USER_ADMIN=unchecked    MENSAGEM=Email não pode ficar em branco              ALERT=Please include an '@' in the email address. 'teste.com' is missing an '@'.
    NAME_USUARIO=${EMPTY}     USER_ADMIN=unchecked    MENSAGEM=Nome não pode ficar em branco        SUCESS=false
    EMAIL=${EMPTY}            USER_ADMIN=unchecked    MENSAGEM=Email não pode ficar em branco       SUCESS=false
    SENHA=${EMPTY}            USER_ADMIN=unchecked    MENSAGEM=Password não pode ficar em branco    SUCESS=false
