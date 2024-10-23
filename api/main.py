from fastapi import FastAPI
from .routes.movieRoutes import router as movieRoutes  # Use ponto para indicar que está no mesmo pacote

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Welcome to the Movie Recommendation API!"}

# Inclui as rotas de filmes
app.include_router(movieRoutes, prefix="/api")  # Adicionando um prefixo para rotas, se desejado

# Função para configurar o tratamento de erros (opcional)
@app.exception_handler(Exception)
async def global_exception_handler(request, exc):
    return JSONResponse(
        status_code=500,
        content={"message": "An error occurred.", "detail": str(exc)},
    )

# Rodar a aplicação com: uvicorn api.main:app --reload
