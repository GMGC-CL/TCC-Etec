import sqlite3

DATABASE_PATH = "api/database/filmes.db"

def conectar():
    """Cria conexão com o banco de dados SQLite"""
    conn = sqlite3.connect(DATABASE_PATH)
    return conn

def criar_tabelas():
    """Executa o script SQL para criar as tabelas"""
    conn = conectar()
    cursor = conn.cursor()
    with open("api/database/schema.sql", "r", encoding="utf-8") as f:
        cursor.executescript(f.read())
    conn.commit()
    conn.close()

if __name__ == "__main__":
    criar_tabelas()
    print("Banco de dados e tabelas criados com sucesso!")
