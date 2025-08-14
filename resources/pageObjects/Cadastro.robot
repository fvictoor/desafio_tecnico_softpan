*** Settings ***
Resource  ../base.robot 

*** Variables***
${TITULO_CADASTRO}          xpath=//h2[text()="Cadastro"]
${CAMPO_NOME}               css=form [data-testid='nome']
${CAMPO_EMAIL_CADASTRO}     css=form [data-testid='email']
${CAMPO_SENHA_CADASTRO}     css=form [data-testid='password']
${CHECKBOX_ADMINISTRADOR}   css=form [data-testid='checkbox']
${BOTAO_CADASTRAR}          css=form [data-testid='cadastrar']
${LINK_LOGIN}               xpath=//a[@data-testid="entrar"]
${ALERTA_CADASTRO}          css=div.alert-dismissible