from pydantic import BaseModel, constr

class MovieData(BaseModel):
    title: constr(max_length=255)
    genre: str
    year: int
    rating: float

def validate_movie_data(data):
    movie = MovieData(**data)
    return movie
