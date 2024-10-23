# config/settings.py

import os

class Settings:
    TMDB_API_KEY = os.getenv('TMDB_API_KEY', 'sua_chave_aqui')
    BASE_URL = 'https://api.themoviedb.org/3'
    # Adicione outras configurações necessárias

settings = Settings()
