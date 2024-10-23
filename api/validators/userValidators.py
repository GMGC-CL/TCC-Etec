from pydantic import BaseModel, EmailStr, constr

class User(BaseModel):
    email: EmailStr
    password: constr(min_length=8)

def validate_user_data(data):
    user = User(**data)
    return user
