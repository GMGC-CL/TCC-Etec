# utils/helpers.py

def format_response(data):
    # Função para formatar a resposta da API, se necessário
    return {"data": data, "status": "success"}

def handle_error(error):
    # Função para tratar erros
    return {"error": str(error), "status": "failed"}
