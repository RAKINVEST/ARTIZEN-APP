"""Data-access layer for the users module."""

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.repositories.base import BaseRepository
from app.users.models import User


class UserRepository(BaseRepository[User]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(User, session)

    async def get_by_email(self, email: str) -> User | None:
        result = await self.session.execute(select(User).where(User.email == email))
        return result.scalars().first()

    async def get_by_reset_token_hash(self, token_hash: str) -> User | None:
        result = await self.session.execute(
            select(User).where(User.reset_token_hash == token_hash)
        )
        return result.scalars().first()
