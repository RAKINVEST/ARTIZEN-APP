"""Pydantic schemas for the users module."""

import uuid

from pydantic import BaseModel, ConfigDict, EmailStr, Field


class UserRegister(BaseModel):
    email: EmailStr
    password: str = Field(min_length=8)
    full_name: str | None = None
    # Seeds Company.name for the new tenant this registration creates.
    # Optional: an artisan can always set it properly later via
    # `PUT /branding/company`.
    company_name: str | None = None


class UserLogin(BaseModel):
    email: EmailStr
    password: str


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
