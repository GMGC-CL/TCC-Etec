def format_movie_data(movie):
    """Formata os dados do filme para exibição."""
    return {
        "title": movie.get("title"),
        "release_date": movie.get("release_date"),
        "vote_average": movie.get("vote_average"),
        "overview": movie.get("overview"),
        # Adicione mais campos conforme necessário
    }

def validate_genre(genre):
    """Valida se o gênero é permitido."""
    allowed_genres = ['action', 'comedy', 'drama', 'horror']  # Adicione os gêneros permitidos
    return genre in allowed_genres
