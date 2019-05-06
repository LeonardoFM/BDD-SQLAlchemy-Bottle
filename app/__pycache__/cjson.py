
def transfers_by_date_out(date,l):

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
        transf.append(dict(zip(keys,lista[6][0:13])))

    return do = {'data':date,'transferências': transf}
