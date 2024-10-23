import requests

TMDB_API_KEY = ''

# Função auxiliar para realizar a busca no TMDB
def search_movies(query_params):
    base_url = 'https://api.themoviedb.org/3/discover/movie'
    params = {
        'api_key': TMDB_API_KEY,
        'language': 'en-US',
        'sort_by': query_params.get('sort_by', 'popularity.desc'),
        'with_genres': query_params.get('genre'),  # Gênero
        'year': query_params.get('year'),          # Ano
        'vote_average.gte': query_params.get('min_vote_average', 0),  # Mínima nota
        'vote_average.lte': query_params.get('max_vote_average', 10),  # Máxima nota
        'page': query_params.get('page', 1),       # Página
        'with_cast': query_params.get('with_cast'), # ID do ator/atriz
        'with_crew': query_params.get('with_crew'), # ID do diretor
        'without_genres': query_params.get('without_genres'), # Gêneros a serem excluídos
        'release_date.gte': query_params.get('release_date.gte'), # Data de lançamento mínima
        'release_date.lte': query_params.get('release_date.lte'), # Data de lançamento máxima
        'with_runtime.gte': query_params.get('with_runtime.gte'), # Duração mínima
        'with_runtime.lte': query_params.get('with_runtime.lte'), # Duração máxima
        'region': query_params.get('region'),       # Região
        'include_adult': query_params.get('include_adult', False), # Incluir conteúdo adulto
        'certification_country': query_params.get('certification_country'), # País de certificação
        'certification': query_params.get('certification'), # Certificação
    }
    
    response = requests.get(base_url, params=params)
    
    # Verifica se a requisição foi bem-sucedida
    if response.status_code == 200:
        return response.json()
    else:
        return {"error": "Error fetching data from TMDB", "status_code": response.status_code}

# Função para manipular os parâmetros recebidos e buscar os filmes
def get_movie_recommendation(
    genre, year, min_vote_average, max_vote_average, sort_by, 
    page=1, with_cast=None, with_crew=None, without_genres=None, 
    release_date_gte=None, release_date_lte=None, 
    with_runtime_gte=None, with_runtime_lte=None, 
    region=None, include_adult=False, 
    certification_country=None, certification=None
):
    query_params = {
        'genre': genre,
        'year': year,
        'min_vote_average': min_vote_average,
        'max_vote_average': max_vote_average,
        'sort_by': sort_by,
        'page': page,
        'with_cast': with_cast,
        'with_crew': with_crew,
        'without_genres': without_genres,
        'release_date.gte': release_date_gte,
        'release_date.lte': release_date_lte,
        'with_runtime.gte': with_runtime_gte,
        'with_runtime.lte': with_runtime_lte,
        'region': region,
        'include_adult': include_adult,
        'certification_country': certification_country,
        'certification': certification,
    }
    
    # Chamada para buscar os filmes usando os parâmetros fornecidos
    result = search_movies(query_params)
    return result

