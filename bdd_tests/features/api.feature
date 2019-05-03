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
      Quando faço uma requisição POST na url "/usuarios"
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

  @solo
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
