from .database import get_collection
from .models import Movie

def insert_movie(movie: Movie):
    collection = get_collection("movies")
    return collection.insert_one(movie.dict())

def get_movies():
    collection = get_collection("movies")
    return list(collection.find())
