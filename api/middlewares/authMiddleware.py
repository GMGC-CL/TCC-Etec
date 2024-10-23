from fastapi import Request, HTTPException
from fastapi.security import OAuth2PasswordBearer

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

async def auth_middleware(request: Request):
    token = await oauth2_scheme(request)
    # Lógica para verificar o token
    if not verify_token(token):
        raise HTTPException(status_code=401, detail="Unauthorized")
