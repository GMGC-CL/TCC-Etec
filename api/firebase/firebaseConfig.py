import firebase_admin
from firebase_admin import credentials

# Inicializa o aplicativo Firebase
def initialize_firebase():
    cred = credentials.Certificate("path/to/your/firebase_credentials.json")
    firebase_admin.initialize_app(cred)

initialize_firebase()
