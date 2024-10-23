from firebase_admin import auth

# Função para criar um usuário
def create_user(email, password):
    user = auth.create_user(email=email, password=password)
    return user

# Função para verificar a autenticação do usuário
def verify_user(token):
    decoded_token = auth.verify_id_token(token)
    return decoded_token
