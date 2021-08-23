# -*- coding: utf-8 -*-
"""
Created on Thu Apr 22 20:27:12 2021

@author: badil
"""
from datetime import datetime
import pandas as pd
import requests
import time
import sqlalchemy
import mysql.connector
import os

API_URL='https://api.binance.com'

API_KEY='API_KEY DEL USUARIO'

def creaSesion():
    sesion=requests.session()
    sesion.headers.update({'Accept': 'application/json',
                        'User-Agent':'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',
                        'X-MBX-APIKEY': API_KEY})
    return (sesion)

def conectaBD():
    try:
        # engine=sqlalchemy.create_engine("mysql+mysqlconnector://crypto:crypto@localhost/crypto")
        engine=sqlalchemy.create_engine("mysql+mysqlconnector://root:advavf25s@192.168.0.168:3306/crypto")
    except sqlalchemy.exc.SQLAlchemyError:
        print('Error de conección')
        os.system('sudo systemctl restart mariadb.service')
        time.sleep(20)
        engine=conectaBD()
    return(engine)

sesion=creaSesion()
engine = conectaBD()



# vals=sesion.get(API_URL+'/api/v3/ticker/price')

# valores=pd.DataFrame(vals.json())

# valores=valores[valores['symbol'].str.contains('USDT')].reset_index(drop=True)

# valores['fechahora']=pd.Timestamp('now')



while 0==0:
    vals=requests.models.Response()
    try:
        vals=sesion.get(API_URL+'/api/v3/ticker/price')

    except requests.exceptions.RequestException as e:
        vals.status_code=401
        print("\n\n{} Error al obtener los datos \n\n".format(pd.Timestamp('now')))
        print(e)

    if vals.status_code==200:

        valores=pd.DataFrame(vals.json())
        
        valores=valores[valores['symbol'].str.contains('USDT')].reset_index(drop=True)
        
        valores['fechahora']=pd.Timestamp('now')
        
        valores=valores[['symbol', 'fechahora', 'price']]
        
        valores.to_sql(name='precios', con=engine, if_exists='append', index=False)
        #print(valores)
        if datetime.now().minute==30:
            sesion=creaSesion()
            engine = conectaBD()

        time.sleep(15)
