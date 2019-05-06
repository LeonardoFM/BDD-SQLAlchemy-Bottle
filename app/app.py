#!/usr/bin/env python
# -*- coding: utf-8 -*-

### Microserviço para expor a inserção de transação
from json import dumps
from bottle import Bottle, request, response
from app.core import (search_all_users,
                     insert_user,
                     insert_transfer,
                     search_transfer_by_date,
                     search_transfer_by_pagador,
                     search_transfer_by_beneficiario)

app = Bottle()

@app.get('/')
def index_map(): #chamada teste do bdd convocando a raiz
    return dumps({"usuarios": "url/usuarios","transferencia":"url/transferencia"})

@app.get('/transferencia/<date>')
def transfer_map(date): #
    return search_transfer_by_date(date)

@app.get('/transferencia/pagador/<nome>')
def transfer_map(nome): #
    return search_transfer_by_pagador(nome)

@app.get('/transferencia/beneficiario/<nome>')
def transfer_map(nome): #
    return search_transfer_by_beneficiario(nome)

@app.post('/transferencia')
def post_transferencia():
    transf = request.json
    response.headers['Content-Type'] = 'application/json'

    if not transf:
        response.status = 400
        return {response.status: transf}

    if insert_transfer(transf['nome'],
                       transf['pagador_banco'],
                       transf['pagador_agencia'],
                       transf['pagador_conta'],
                       transf['beneficiario_nome'],
                       transf['beneficiario_banco'],
                       transf['beneficiario_agencia'],
                       transf['beneficiario_conta'],
                       transf['valor']):
        response.status = 201 # Created
    else:
        response.status = 409 #conflito
        print(response.status,": pode não existir nenhum cliente no banco de dados")

    return dumps({response.status: transf})


@app.get('/usuarios')
def users_map():
    return search_all_users()

@app.post('/usuarios/')
def post_users():
    user = request.json
    response.headers['Content-Type'] = 'application/json'

    if not user: # gera a necessidade do formato json para o post de usuarios
        response.status = 400
        return {response.status: user}

    if insert_user(user['nome'],user['cnpj']):
        response.status = 201 # Created
    else:
        response.status = 409 #conflito

    return dumps({response.status: user})


if __name__ == '__main__':
    app.run()
