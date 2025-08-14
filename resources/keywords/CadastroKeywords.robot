*** Settings ***
Resource         ../base.robot
Documentation    Nesse arquivo vamos armazenar apenas Keyqords envolvendo o processo de Login e Cadastro de usuário no sistema.
*** Keywords ***

Preencher as informações de cadastro
    [Documentation]    Aguarda o carregamento do formulário de cadastro e preenche os campos com dados gerados dinamicamente utilizando a biblioteca FakerLibrary.
    ...                Também registra no log os dados utilizados no preenchimento para rastreabilidade.
    [Arguments]     ${NAME_USUARIO}=aleatórios    ${EMAIL}=aleatórios    ${SENHA}=aleatórios    ${USER_ADMIN}=unchecked    ${MENSAGEM}=    ${ALERT}=false    ${SUCESS}=
    Wait Element    SELECTOR=${TITULO_CADASTRO}

    # Gerar dados aleatórios se não fornecidos
    ${NOME}=     Run Keyword If    '${NAME_USUARIO}'=='aleatórios'    FakerLibrary.Name
    ...          ELSE IF           '${NAME_USUARIO}'=='${EMPTY}'      Set Variable    ${EMPTY}
    ...          ELSE               Set Variable    ${NAME_USUARIO}
    ${EMAIL}=    Run Keyword If    '${EMAIL}'=='aleatórios'   FakerLibrary.Email
    ...          ELSE IF           '${EMAIL}'=='${EMPTY}'     Set Variable    ${EMPTY}
    ...          ELSE               Set Variable    ${EMAIL}
    ${SENHA}=    Run Keyword If    '${SENHA}'=='aleatórios'   FakerLibrary.Password
    ...          ELSE IF           '${SENHA}'=='${EMPTY}'     Set Variable    ${EMPTY}
    ...          ELSE               Set Variable    ${SENHA}

    Log Many    Informações do Usuário Cadastrados
    ...         Nome: ${NOME}
    ...         E-mail: ${EMAIL}
    ...         Senha: ${SENHA}
    
    Escrever em:                    ${CAMPO_NOME}                 ${NOME}
    Escrever em:                    ${CAMPO_EMAIL_CADASTRO}       ${EMAIL}
    Escrever em:                    ${CAMPO_SENHA_CADASTRO}       ${SENHA}
    Marcar ou Desmarcar Checkbox    ${CHECKBOX_ADMINISTRADOR}     ${USER_ADMIN}
    Clicar em:                      ${BOTAO_CADASTRAR}
    
    IF  "${ALERT}" != "false"
        ${MENSAGEM}    Get Property    ${CAMPO_EMAIL_CADASTRO}    property=validationMessage
        Should Be Equal As Strings    ${MENSAGEM}    ${ALERT}    msg=Mensagem de alerta diferente da validação    ignore_case=true     collapse_spaces=true     strip_spaces=true
    ELSE 
        Wait Until Keyword Succeeds     2x    2s    Validar mensagem de cadastro    ${MENSAGEM}    ${SUCESS}
    END

Validar mensagem de cadastro
    [Arguments]    ${TEXT}    ${SUCESS}=true
    IF    '${SUCESS}'=='true'
        Wait Until Keyword Succeeds     2x    2s    Run Keyword And Return Status    Wait Element    ${ALERTA_CADASTRO} 
        ${TEXTO_EXIBIDO}    Get Text    ${ALERTA_CADASTRO}       message=Texto não encontrado
    ELSE IF     '${SUCESS}'=='false'
        Wait Until Keyword Succeeds     2x    2s    Run Keyword And Return Status    Wait Element    xpath=//div[@role='alert']//span[normalize-space()='${TEXT}'] 
        ${TEXTO_EXIBIDO}    Get Text    xpath=//div[@role='alert']//span[normalize-space()='${TEXT}']       message=Texto não encontrado
    END
    Should Contain     ${TEXTO_EXIBIDO}    ${TEXT}    msg=Texto diferente da validação
