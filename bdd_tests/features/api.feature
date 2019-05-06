# language:pt

Funcionalidade: API


  Cenário: Resposta do mapa da API
      Quando faço uma requisição na url "/"
      Então a api deve responder
      """
      {"usuarios": "url/usuarios","transferencia":"url/transferencia"}
      """

  Cenário: Requisição de clientes da API
      Quando faço uma requisição na url "/usuarios"
      Então a api deve responder
      """
      {}
      """


  Cenário: Inserção de um usuário na API
      Quando faço uma requisição POST na url "/usuarios/"
      """
      {"nome":"elisa","cnpj":"999jn9"}
      """
      Então a api deve responder
      """
      {
        "201 Created":{
          "nome":"elisa","cnpj":"999jn9"
        }
      }
      """
      Quando faço uma requisição na url "/usuarios"

      Então a api deve responder
      """
      {
        "1":{"nome":"elisa","cnpj":"999jn9"}
      }
      """

  Cenário: Requisição de transferencias da API
      Quando faço uma requisição POST na url "/transferencia"
      """
      {
      "nome":"elisa",
      "pagador_banco":"001",
      "pagador_agencia":"0001",
      "pagador_conta":"00001",
      "beneficiario_nome":"roma",
      "beneficiario_banco":"001",
      "beneficiario_agencia":"0002",
      "beneficiario_conta":"00002",
      "valor":"100000"
      }
      """


  Cenário: Requisição de transferencias da API
      Quando faço uma requisição na url "/transferencia/2019-05-04"

      Então a api deve responder
      """
      {
        "2019-05-04": {
              "transferências": [
                  {
                      "id": 1,
                      "usuario_id": 2,
                      "pagador_nome": "ju",
                      "pagador_banco": "003",
                      "pagador_agencia": "0001",
                      "pagador_conta": "00001",
                      "beneficiario_nome": "sebastião",
                      "beneficiario_banco": "003",
                      "beneficiario_agencia": "0045",
                      "beneficiario_conta": "003334",
                      "valor": 100,
                      "tipo": "CC",
                      "status": "OK"
                  },
                  {
                      "id": 2,
                      "usuario_id": 2,
                      "pagador_nome": "ju",
                      "pagador_banco": "003",
                      "pagador_agencia": "0001",
                      "pagador_conta": "00001",
                      "beneficiario_nome": "elisa",
                      "beneficiario_banco": "005",
                      "beneficiario_agencia": "0045",
                      "beneficiario_conta": "003334",
                      "valor": 100000,
                      "tipo": "DOC",
                      "status": "OK"
                  },
                  {
                      "id": 3,
                      "usuario_id": 3,
                      "pagador_nome": "marcelo",
                      "pagador_banco": "003",
                      "pagador_agencia": "0001",
                      "pagador_conta": "00001",
                      "beneficiario_nome": "gabriel",
                      "beneficiario_banco": "003",
                      "beneficiario_agencia": "0045",
                      "beneficiario_conta": "003334",
                      "valor": 100001,
                      "tipo": "CC",
                      "status": "ERRO"
                  },
                  {
                      "id": 4,
                      "usuario_id": 3,
                      "pagador_nome": "marcelo",
                      "pagador_banco": "003",
                      "pagador_agencia": "0001",
                      "pagador_conta": "00001",
                      "beneficiario_nome": "gabriel",
                      "beneficiario_banco": "003",
                      "beneficiario_agencia": "0045",
                      "beneficiario_conta": "003334",
                      "valor": 200,
                      "tipo": "CC",
                      "status": "OK"
                  },
                  {
                      "id": 5,
                      "usuario_id": 5,
                      "pagador_nome": "nina",
                      "pagador_banco": "003",
                      "pagador_agencia": "0001",
                      "pagador_conta": "00001",
                      "beneficiario_nome": "ju",
                      "beneficiario_banco": "003",
                      "beneficiario_agencia": "0045",
                      "beneficiario_conta": "003334",
                      "valor": 10000,
                      "tipo": "CC",
                      "status": "OK"
                  },
                  {
                      "id": 6,
                      "usuario_id": 1,
                      "pagador_nome": "sebastião",
                      "pagador_banco": "003",
                      "pagador_agencia": "0001",
                      "pagador_conta": "00001",
                      "beneficiario_nome": "elisa",
                      "beneficiario_banco": "003",
                      "beneficiario_agencia": "0045",
                      "beneficiario_conta": "003334",
                      "valor": 10000,
                      "tipo": "CC",
                      "status": "OK"
                  },
                  {
                      "id": 7,
                      "usuario_id": 1,
                      "pagador_nome": "sebastião",
                      "pagador_banco": "003",
                      "pagador_agencia": "0001",
                      "pagador_conta": "00001",
                      "beneficiario_nome": "elisa",
                      "beneficiario_banco": "005",
                      "beneficiario_agencia": "0045",
                      "beneficiario_conta": "003334",
                      "valor": 10000232,
                      "tipo": "DOC",
                      "status": "ERRO"
                  }
              ]
          }
      }
      """

  Cenário: Requisição de transferencias da API
      Quando faço uma requisição na url "/transferencia/beneficiario/elisa"

      Então a api deve responder
      """
      {
          "elisa": {
              "transferências": [
                  {
                      "id": 2,
                      "usuario_id": 2,
                      "pagador_nome": "ju",
                      "pagador_banco": "003",
                      "pagador_agencia": "0001",
                      "pagador_conta": "00001",
                      "beneficiario_nome": "elisa",
                      "beneficiario_banco": "005",
                      "beneficiario_agencia": "0045",
                      "beneficiario_conta": "003334",
                      "valor": 100000,
                      "tipo": "DOC",
                      "status": "OK"
                  },
                  {
                      "id": 6,
                      "usuario_id": 1,
                      "pagador_nome": "sebastião",
                      "pagador_banco": "003",
                      "pagador_agencia": "0001",
                      "pagador_conta": "00001",
                      "beneficiario_nome": "elisa",
                      "beneficiario_banco": "003",
                      "beneficiario_agencia": "0045",
                      "beneficiario_conta": "003334",
                      "valor": 10000,
                      "tipo": "CC",
                      "status": "OK"
                  },
                  {
                      "id": 7,
                      "usuario_id": 1,
                      "pagador_nome": "sebastião",
                      "pagador_banco": "003",
                      "pagador_agencia": "0001",
                      "pagador_conta": "00001",
                      "beneficiario_nome": "elisa",
                      "beneficiario_banco": "005",
                      "beneficiario_agencia": "0045",
                      "beneficiario_conta": "003334",
                      "valor": 10000232,
                      "tipo": "DOC",
                      "status": "ERRO"
                  }
              ]
          }
      }
      """


  @solo
  Cenário: Requisição de transferencias da API
      Quando faço uma requisição na url "/transferencia/pagador/nina"

      Então a api deve responder
      """
      {
          "nina": {
              "transferências": [
                  {
                      "id": 5,
                      "usuario_id": 5,
                      "pagador_nome": "nina",
                      "pagador_banco": "003",
                      "pagador_agencia": "0001",
                      "pagador_conta": "00001",
                      "beneficiario_nome": "ju",
                      "beneficiario_banco": "003",
                      "beneficiario_agencia": "0045",
                      "beneficiario_conta": "003334",
                      "valor": 10000,
                      "tipo": "CC",
                      "status": "OK"
                  }
              ]
          }
      }
      """
