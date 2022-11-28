*** Settings ***
#Informações sobre o teste
Documentation       Teste de API de Pokemons - https://github.com/rasolo/pokemon
#Bibliotecas utilizadas
Library             RequestsLibrary
*** Variables ***
#Variável com UrlBase dos testes
${base_url}             http://pokeapi.azurewebsites.net/
#Variável com endpoint de listar todos os pokemons
${get_all_path}         /api/pokemon/list
#Variável com endpoint de listar um pokemon
${get_one_path}         /api/pokemon/Bulbasaur

*** Test Cases ***
#Caso de teste 1
Cenário 01: Valida endpoint get all
    #Keyword que faz a chamada à API e salva a chamada em uma variável  
    Chamar o endpoint de listar todos os pokemons
    #Keyword que valida se o status é 200
    Verificar status code 200
    #Keyword que valida se Success == True
    Verificar o retorno True para o campo Success 

#Caso de teste 2
Cenário 02: Valida endpoint get one
    #Keyword que faz a chamada à API e salva a chamada em uma variável  
    Chamar o endpoint de listar um pokemon
    #Keyword que valida se o status é 200
    Verificar status code 200
    #Keyword que valida se name == Bulbasaur
    Verificar o retorno Bulbasaur para o campo name 

*** Keywords ***
#Implementação dos comando da keyword
Chamar o endpoint de listar todos os pokemons
    #Salva a chamada da API na variável RESPOSTA
    ${RESPOSTA}=        GET    ${base_url}${get_all_path} 
    #Torna a variável RESPOSTA visível para as outras keywords
    Set Test Variable   ${RESPOSTA}

#Implementação dos comando da keyword
Verificar status code 200
    #Verifica se o status code é igual a 200
    Should Be Equal As Strings   ${RESPOSTA.status_code}  200

#Implementação dos comando da keyword
Verificar o retorno True para o campo Success 
    #Verifica se o campo success tem o valor True
    Should Be Equal As Strings   ${RESPOSTA.json()}[success]  True

#Implementação dos comando da keyword
Chamar o endpoint de listar um pokemon
    #Salva a chamada da API na variável RESPOSTA
    ${RESPOSTA}=        GET    ${base_url}${get_one_path}
    #Torna a variável RESPOSTA visível para as outras keywords
    Set Test Variable   ${RESPOSTA}

#Implementação dos comando da keyword
Verificar o retorno Bulbasaur para o campo name 
    #Verifica se o campo name tem o valor Bulbasaur
    Should Be Equal As Strings   ${RESPOSTA.json()}[data][name]    Bulbasaur
