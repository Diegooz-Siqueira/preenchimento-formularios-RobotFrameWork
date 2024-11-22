*** Settings ***
Resource         ../resources/main.robot
Test Setup       Dado que eu acesse o Organo
Test Teardown    Fechar o navegador

*** Test Cases ***
Verificar se quando clico no botão de Criar Card aparece as mensagens de erro
    Dado que eu clique no botão Criar Card e não coloque nenhuma informação para cadastro
    Então sistema deve apresentar mensagens de erros nos campos Nome, Cargo e Time 





