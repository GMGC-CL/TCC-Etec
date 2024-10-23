from fastapi import APIRouter, Query
from ..controllers.movieController import get_movie_recommendation  # Usando importação relativa

router = APIRouter()

@router.get("/recommendation/")
async def recommend_movie(
    genre: str = Query(None, title="Movie Genre", description="Filmes de um gênero específico"),
    year: int = Query(None, title="Release Year", description="Filmes lançados em um determinado ano"),
    min_vote_average: float = Query(0, title="Min Vote Average", description="Nota mínima no TMDB"),
    max_vote_average: float = Query(10, title="Max Vote Average", description="Nota máxima no TMDB"),
    sort_by: str = Query('popularity.desc', title="Sorting", description="Ordenar por popularidade, nota, etc."),
    page: int = Query(1, title="Page", description="Número da página"),
    with_cast: str = Query(None, title="Cast ID", description="ID do ator/atriz"),
    with_crew: str = Query(None, title="Crew ID", description="ID do diretor"),
    without_genres: str = Query(None, title="Excluded Genres", description="Gêneros a serem excluídos"),
    release_date_gte: str = Query(None, title="Release Date From", description="Data de lançamento mínima"),
    release_date_lte: str = Query(None, title="Release Date To", description="Data de lançamento máxima"),
    with_runtime_gte: int = Query(None, title="Min Runtime", description="Duração mínima"),
    with_runtime_lte: int = Query(None, title="Max Runtime", description="Duração máxima"),
    region: str = Query(None, title="Region", description="Região"),
    include_adult: bool = Query(False, title="Include Adult", description="Incluir conteúdo adulto"),
    certification_country: str = Query(None, title="Certification Country", description="País de certificação"),
    certification: str = Query(None, title="Certification", description="Certificação")
):
    result = get_movie_recommendation(
        genre,
        year,
        min_vote_average,
        max_vote_average,
        sort_by,
        page,
        with_cast,
        with_crew,
        without_genres,
        release_date_gte,
        release_date_lte,
        with_runtime_gte,
        with_runtime_lte,
        region,
        include_adult,
        certification_country,
        certification
    )
    return result
