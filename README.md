# Microserviço para cliente do Banco Nix realizar suas transações

  API REST para efetuar transferências no sistema do Banco Nix

## Desenvolvido com BDD, SQLAlchemy e Bottle

    Requisitos do sistema:

        - behave
        - sqlalchemy
        - bottle

**Realizar os testes**

   - é necessário enviar um json pra inserir novos usuários e transferências, isto é feito usando os arquivos em bdd_tests/

   - exemplo de entradas

      -Usuários:

         {"nome":"elisa","cnpj":"999jn9"}

      -Transferências:

         {
          "nome":"elisa",
          "pagador_banco":"003",
          "pagador_agencia":"0001",
          "pagador_conta":"00001",
          "beneficiario_nome":"beth",
          "beneficiario_banco":"004",
          "beneficiario_agencia":"0045",
          "beneficiario_conta":"003334",
          "valor":"1000000"
         }

   - no arquivo bdd_tests/feature/api.feature controlamos quais testes devem rodar
      - o comando de execução é: behave bdd_tests/features/api.feature -t solo
      - o decorador @solo deve estar sobre a função que queremos testar

   - para alguns testes de comportamento é necessário incluir itens nas tabelas "usuarios" e "transferencia",
     exemplo de feramenta complementar como Postman para operações genéricas nos protocolos HTTP:
      - http://localhost:8080/usuarios
      - http://localhost:8080/transferencia


**Banco de dados**

   - a implementação foi usando sqlalchemy: app/core.py
   - querys implementadas:

      - [x] inclusão de usuários
      - [x] inclusão de transferências
      - [x] busca por usuário
      - [x] busca por transferências feitas por um determinado pagador (http://localhost:8080/transferencia/pagador/<nome>)
      - [x] busca por transferências feita em uma determinada data (http://localhost:8080/transferencia/<data>)
      - [x] busca por transferências feitas por um determinado beneficiário (http://localhost:8080/transferencia/beneficiario/<nome>)
      - [x] paginação
      - [X] retornar a somatória total de transferências
      - [ ] delete lógico
