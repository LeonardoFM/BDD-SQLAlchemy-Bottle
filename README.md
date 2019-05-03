# Microserviço para cliente do Banco Nix realizar suas transações

  API REST para efetuar transferências no sistema do Banco Nix

## Desenvolvido com BDD, SQLAlchemy e Bottle

    Requisitos do sistema:
    
        - behave
        - sqlalchemy
        - bottle

**Realizar os testes**

   - é necessário enviar um json pra inserir novos usuários, isto é feito usando os arquivos em bdd_tests/
   - no arquibo bdd_tests/feature/api.feature controlamos quais testes vão rodar
      - o comando de execução é: behave bdd_tests/features/api.feature -t solo
      - o decorador solo deve estar sobre a função que queremos testar

**Banco de dados**

   - a implementação foi usando sqlalchemy: app/core.py
   - querys foram implementadas:
      -[x] inclusão de usuários
      -[x] inclusão de transferências
      -[x] busca por usuário
      -[x] busca por transferências feita por um determinado usuário
      -[x] busca por transferências feita por um determinado por data
      -[x] busca por transferências feita por um determinado
      -[] paginação
      -[] retornar a somatória total de transferências
