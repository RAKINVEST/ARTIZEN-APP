"""Pydantic schemas for the users module."""

import uuid

from pydantic import BaseModel, ConfigDict, EmailStr, Field

# bcrypt hashes at most 72 bytes and passlib raises above 4096. Bounding
# both password fields keeps a long input from silently losing its tail on
# register, and from raising an unhandled error on login — which turned a
# uniform "invalid credentials" 401 into a 500 whenever the email existed,
# i.e. a plain user-enumeration oracle.
_MAX_PASSWORD_LENGTH = 72


class UserRegister(BaseModel):
    email: EmailStr
    password: str = Field(min_length=8, max_length=_MAX_PASSWORD_LENGTH)
    full_name: str | None = None
    # Seeds Company.name for the new tenant this registration creates.
    # Optional: an artisan can always set it properly later via
    # `PUT /branding/company`.
    company_name: str | None = None


class UserLogin(BaseModel):
    email: EmailStr
    # No min_length here: login must not reveal the password policy, and a
    # too-short password is simply wrong credentials (401), not a 422.
    password: str = Field(max_length=_MAX_PASSWORD_LENGTH)


class ForgotPasswordRequest(BaseModel):
    email: EmailStr


class ResetPasswordRequest(BaseModel):
    token: str = Field(min_length=1)
    password: str = Field(min_length=8, max_length=_MAX_PASSWORD_LENGTH)


class UserRead(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    company_id: uuid.UUID
    email: str
    full_name: str | None
    is_active: bool


class TokenRead(BaseModel):
    access_token: str
    token_type: str = "bearer"
    user: UserRead
