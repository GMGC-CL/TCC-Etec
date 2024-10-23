from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017/")
db = client["your_database_name"]

def get_collection(collection_name):
    return db[collection_name]
