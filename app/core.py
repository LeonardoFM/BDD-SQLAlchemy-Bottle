import datetime
from sqlalchemy import (create_engine, MetaData, Column, DateTime, func,
                        Table, Integer, Float, String, ForeignKey, select, Boolean)

from sqlalchemy.orm import sessionmaker
import json

engine = create_engine('sqlite:///base_banco_nix.db',
                        echo=True)

metadata = MetaData(bind=engine)

user_table = Table('usuarios',metadata,
                    Column('id',Integer,primary_key=True,autoincrement=True),
                    Column('nome',String(128),index=True,nullable=False,unique=True),
                    Column('cnpj',String(14),nullable=False))

transfer_table = Table('transferencia',metadata,
                    Column('id',Integer,primary_key=True,autoincrement=True),
                    Column('usuario_id',ForeignKey('usuarios.id'),nullable=False),
                    Column('pagador_nome',String(128)),
                    Column('pagador_banco',String(3)),
                    Column('pagador_agencia',String(4)),
                    Column('pagador_conta',String(6)),
                    Column('beneficiario_nome',String(128)),
                    Column('beneficiario_banco',String(3)),
                    Column('beneficiario_agencia',String(4)),
                    Column('beneficiario_conta',String(6)),
                    Column('valor',Float(15)),
                    Column('tipo',String(4)),
                    Column('status',String(12)),
                    #Column('sts_excluido',Boolean ),
                    Column('data',DateTime, default=datetime.datetime.utcnow,index=True)
                    )


metadata.create_all()


def id_user(nome):
    sel = select([user_table]).where(user_table.c.nome==nome)
    result = {_id: {"nome":nome,"cnpj":cnpj} for _id, nome, cnpj in sel.execute()}
    try:
        return result.popitem()[0]
    except:
        print("Id não encontrado no banco de dados: base_banco_nix.db")
        print("Necessário fazer cadastro de ",nome)


def hour_now():
    hnow = datetime.datetime.utcnow().strftime('%B %d %Y - %H:%M:%S')
    hr = hnow.split(' ')[4].split(':')
    return int(hr[0])


def search_all_users():
    return {_id: {"nome":nome,"cnpj":cnpj} for _id, nome, cnpj in select([user_table]).execute()}


def search_transfer_by_date(key):
    d = key.split('-')
    d[:] = {int(d[i]) for i in range(len(d))}
    d1 = str(d[0])+'-0'+str(d[2])+'-0'+str(d[1]-1)
    d2 = str(d[0])+'-0'+str(d[2])+'-0'+str(d[1]+1)
    session = sessionmaker()
    session.configure(bind=engine)
    s = session()
    lista = s.query(transfer_table).filter(
                                           transfer_table.c.data > d1,
                                           transfer_table.c.data < d2
                                           ).all()[:]

    return transfers_out(key,lista)

def search_transfer_by_pagador(key:String):
    session = sessionmaker()
    session.configure(bind=engine)
    s = session()
    lista = s.query(transfer_table).filter(transfer_table.c.pagador_nome == key).all()[:]

    return transfers_out(key,lista)

def search_transfer_by_beneficiario(key:String):
    session = sessionmaker()
    session.configure(bind=engine)
    s = session()
    lista = s.query(transfer_table).filter(transfer_table.c.beneficiario_nome == key).all()[:]

    return transfers_out(key,lista)


def insert_transfer(name,pbank,pag,pcc,
                    bname,bbank,bag,bcc,
                    value):
    if float(value) <= 100000.0:
        sts = 'OK'

    else:
        sts = 'ERRO'

    if (pbank == bbank):
        tp = 'CC'

    elif (10 <= hour_now() <= 16) and (float(value) < 5000.0):
        tp = 'TED'

    else:
        tp = 'DOC'

    conn = engine.connect()
    transf_ins = transfer_table.insert()
    n_transf = transf_ins.values(usuario_id = id_user(name),
                                 pagador_nome = name,
                                 pagador_banco = pbank,
                                 pagador_agencia = pag,
                                 pagador_conta = pcc,
                                 beneficiario_nome = bname,
                                 beneficiario_banco = bbank,
                                 beneficiario_agencia = bag,
                                 beneficiario_conta = bcc,
                                 valor=float(value),
                                 tipo=tp,
                                 status=sts)
    try:
        conn.execute(n_transf)
        status = True

    except Exception as e:
        print(e)
        status = False

    finally:
        conn.close()
        return status

def insert_user(name,reg):
    conn = engine.connect()
    usuarios_ins = user_table.insert()
    n_usuario = usuarios_ins.values(nome=name,
                                    cnpj=reg)
    try:
        conn.execute(n_usuario)
        status = True
    except Exception as e:
        print(e)
        status = False
    finally:
        conn.close()
        return status

def transfers_out(search,l):

    keys = ['id',
            'usuario_id',
            'pagador_nome',
            'pagador_banco',
            'pagador_agencia',
            'pagador_conta',
            'beneficiario_nome',
            'beneficiario_banco',
            'beneficiario_agencia',
            'beneficiario_conta',
            'valor',
            'tipo',
            'status']
    transf = []
    for i in range(len(l)):
        transf.append({'página':i+1})
        transf.append(dict(zip(keys,l[i][0:13])))

    return {search:{'transferências': transf},'total':total(l)}

def total(lista):
    s = 0.0
    for i in range(len(lista)):
        s = s + lista[i][10]
    return s
