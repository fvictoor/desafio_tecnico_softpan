*** Settings ***
Resource    ../../resources/base.robot
Documentation    Nesses cenários vamos validar a tela de Login.

*** Test Cases ***
LOGIN - Realizar login com usuário comum
    [Documentation]    Nesse cenário vamos estar realizando o login de um usuário comum no site https://front.serverest.dev/login
    [Tags]     frontend     login    positivo
    [Setup]    POST - Cadastrar Usuário                      ${URL_BACKEND}            ADMINISTRADOR=false          STATUS_CODE=201
    Abrir navegador                                          ${URL_FRONTEND}
    Realizar Login                                           ${body_usuario}[email]    ${body_usuario}[password]    TIPO_USER=comum    SUCESS=true
    [Teardown]    Run Keywords    DELETE - Excluir Usuário    ${URL_BACKEND}    AND
    ...                           Take Screenshot    EMBED

LOGIN - Realizar login com usuário administrador
    [Documentation]    Nesse cenário vamos estar realizando o login de um usuário administrador no site https://front.serverest.dev/login
    [Tags]     frontend     login    positivo
    [Setup]    POST - Cadastrar Usuário                      ${URL_BACKEND}           ADMINISTRADOR=true           STATUS_CODE=201
    Abrir navegador                                          ${URL_FRONTEND}          
    Realizar Login                                           ${body_usuario}[email]   ${body_usuario}[password]    TIPO_USER=administrador    SUCESS=true
    [Teardown]    Run Keywords    DELETE - Excluir Usuário    ${URL_BACKEND}    AND
    ...                           Take Screenshot    EMBED

LOGIN - Validar mensagem de erro ao tentar realizar login com usuário sem email e sem senha
    [Documentation]    Nesse cenário vamos estar validando a mensagem de erro ao tentar realizar login sem informar o email informando apenas a senha, sem informar a senha ou sem informar nenhum dos dois campos.
    [Tags]     frontend    login    negativo
    [Setup]    Abrir navegador    ${URL_FRONTEND}
    [Template]    Realizar Login
    USUARIO=${EMPTY}           SENHA=${EMPTY}       TIPO_USER=Alert    MENSAGEM=Email é obrigatório        SUCESS=false
    USUARIO=${EMPTY}           SENHA=${EMPTY}       TIPO_USER=Alert    MENSAGEM=Password é obrigatório     SUCESS=false
    USUARIO=${EMPTY}           SENHA=teste1234      TIPO_USER=Alert    MENSAGEM=Email é obrigatório        SUCESS=false
    USUARIO=teste.com          SENHA=${EMPTY}       TIPO_USER=Alert    SUCESS=false                        ALERT=Please include an '@' in the email address. 'teste.com' is missing an '@'.
    [Teardown]    Take Screenshot    EMBED
