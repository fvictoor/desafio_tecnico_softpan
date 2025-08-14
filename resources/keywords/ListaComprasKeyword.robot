*** Settings ***
Resource         ../base.robot
Documentation    Nesse arquivo vamos armazenar keywords relacionada a carrinho de compras.

*** Keywords ***

Pesquisar produto na home
    [Arguments]     ${NOME_PRODUTO}
    Wait Element    ${TITULO_PAGINA}
    Escrever em:    ${CAMPO_PESQUISAR}    ${NOME_PRODUTO}
    Clicar em:      ${BOTAO_PESQUISAR}
    Wait Element    xpath=//div[contains(@class, 'card-body')]//h5[normalize-space()='${NOME_PRODUTO}']

Adicionar produto a Lista de Compras
    [Arguments]    ${NOME_PRODUTO}
    Clicar em:      xpath=//h5[normalize-space()='${NOME_PRODUTO}']/following::button[@data-testid="adicionarNaLista"]

Validar produto na lista de compras
    [Arguments]     ${NOME_PRODUTO}
    Clicar em:      ${LINK_LISTA_COMPRAS}
    Wait Element    xpath=//div[@data-testid='shopping-cart-product-name'][text()='${NOME_PRODUTO}']
    
Limpar lista de compras
    Clicar em:      ${BOTAO_LIMPAR_LISTA}
    Wait Element    ${LISTA_COMPRAS_VAZIA}
