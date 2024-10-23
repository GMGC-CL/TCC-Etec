from fastapi import Request
import logging

logging.basicConfig(level=logging.INFO)

async def logging_middleware(request: Request, call_next):
    logging.info(f"Request: {request.method} {request.url}")
    response = await call_next(request)
    logging.info(f"Response: {response.status_code}")
    return response
