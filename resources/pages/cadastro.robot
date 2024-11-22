*** Settings ***
Resource    ../main.robot

*** Variables ***
${URL}                    http://localhost:3000/
${CAMPO_NOME}             id:form-nome
${CAMPO_CARGO}            id:form-cargo
${CAMPO_IMAGEM}           id:form-imagem
${CAMPO_TIME}             class:lista-suspensa
${BOTAO_CARD}             id:form-botao
${CARD_COLABORADOR}       class:colaborador
${MENSAGEM_ERRO_NOME}     id:form-nome-erro
${MENSAGEM_ERRO_CARGO}    id:form-cargo-erro
${MENSAGEM_ERRO_TIME}     id:form-times-erro
@{selecionar_times}
...      //option[contains(.,'Programação')]
...      //option[contains(.,'Front-End')]
...      //option[contains(.,'Data Science')]
...      //option[contains(.,'Devops')] 
...      //option[contains(.,'UX e Design')]
...      //option[contains(.,'Mobile')]
...      //option[contains(.,'Inovação e Gestão')]


*** Keywords ***
Dado que eu preencha os campos do formulário
    ${Nome}          FakerLibrary.First Name
    Input Text       ${CAMPO_NOME}      ${Nome}
    ${Cargo}         FakerLibrary.Job
    Input Text       ${CAMPO_CARGO}     ${Cargo}
    ${Imagem}        FakerLibrary.Image Url    width=100    height=100
    Input Text       ${CAMPO_IMAGEM}    ${Imagem}
    Click Element    ${CAMPO_TIME}
    Click Element    ${selecionar_times}[0]

E clique no botão criar card
    Click Element    ${BOTAO_CARD} 

Então identificar o card no time esperado
    Element Should Be Visible    ${CARD_COLABORADOR}
    Sleep    10s


Então identificar 3 cards no time esperado
    FOR    ${i}    IN RANGE    1    3
        Dado que eu preencha os campos do formulário
        E clique no botão criar card 
    END
    Sleep    10s


Então criar e identificar um card em cada time disponível
    FOR    ${indice}    ${time}    IN ENUMERATE    @{selecionar_times}
        Dado que eu preencha os campos do formulário
        Click Element    ${time}
        E clique no botão criar card        
    END
    Sleep    10s


Dado que eu clique no botão Criar Card e não coloque nenhuma informação para cadastro
    Click Element    ${BOTAO_CARD}

Então sistema deve apresentar mensagens de erros nos campos Nome, Cargo e Time
    Element Should Be Visible    ${MENSAGEM_ERRO_NOME}
    Element Should Be Visible    ${MENSAGEM_ERRO_CARGO}
    Element Should Be Visible    ${MENSAGEM_ERRO_TIME}