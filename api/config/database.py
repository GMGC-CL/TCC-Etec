# config/database.py

from pymongo import MongoClient

def get_database():
    client = MongoClient("mongodb://localhost:27017/")
    return client['nome_do_seu_banco_de_dados']
