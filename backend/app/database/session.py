"""Async SQLAlchemy engine and session factory.

``get_db`` is the single FastAPI dependency every endpoint/repository uses
to obtain a database session. Commit/rollback is handled here so services
never have to manage transaction boundaries themselves.
"""

from collections.abc import AsyncGenerator

from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine

from app.core.config import settings

engine = create_async_engine(
    settings.DATABASE_URL,
    # echo is left False: SQLAlchemy's echo mode attaches its own handler
    # and would duplicate every query line next to our centralized logger.
    # Query visibility in debug mode is controlled by the "sqlalchemy.engine"
    # logger level instead, see app/core/logging.py.
    echo=False,
    pool_pre_ping=True,
)

AsyncSessionLocal = async_sessionmaker(
    bind=engine,
    class_=AsyncSession,
    expire_on_commit=False,
    autoflush=False,
)


async def get_db() -> AsyncGenerator[AsyncSession, None]:
    async with AsyncSessionLocal() as session:
        try:
            yield session
            await session.commit()
        except Exception:
            await session.rollback()
            raise
        finally:
            await session.close()
