"""Storage abstraction for uploaded files (branding assets, documents to
analyze, and anything else that needs durable file storage).

``StorageProvider`` is the only contract the rest of the application
should depend on. Only a local filesystem implementation exists today;
S3, Azure Blob and Google Cloud Storage can be added later as new
classes behind the same interface, selected via ``settings.STORAGE_PROVIDER``
without touching any calling code.

This lives at the top level (alongside ``core``, ``database``, ``auth``)
rather than inside a business module: it started in ``branding/`` when
that was the only consumer, and moved here once ``document_analysis``
needed the exact same capability — a second real consumer is the signal
that something is infrastructure, not business logic.
"""

import asyncio
from abc import ABC, abstractmethod
from dataclasses import dataclass
from functools import lru_cache
from pathlib import Path
from typing import Annotated
from uuid import uuid4

from fastapi import Depends

from app.core.config import settings


@dataclass(frozen=True)
class StoredFile:
    key: str
    filename: str
    content_type: str
    size_bytes: int


class StorageProvider(ABC):
    @abstractmethod
    async def save(
        self, *, category: str, filename: str, content_type: str, content: bytes
    ) -> StoredFile:
        """Persist file content under ``category``, returning its stored metadata."""
        raise NotImplementedError

    @abstractmethod
    async def load(self, key: str) -> bytes:
        """Return the raw content previously stored under ``key``."""
        raise NotImplementedError

    @abstractmethod
    async def delete(self, key: str) -> None:
        """Remove a previously stored file. No-op if it doesn't exist."""
        raise NotImplementedError


class LocalStorageProvider(StorageProvider):
    """Stores files on the local filesystem, under a configurable root.

    Keys are generated (``uuid4``) rather than derived from the original
    filename, so user-supplied names never influence the resulting path.
    """

    def __init__(self, root_dir: Path) -> None:
        self._root = root_dir
        self._root.mkdir(parents=True, exist_ok=True)

    async def save(
        self, *, category: str, filename: str, content_type: str, content: bytes
    ) -> StoredFile:
        extension = Path(filename).suffix.lower()
        key = f"{category}/{uuid4().hex}{extension}"
        destination = self._root / key
        destination.parent.mkdir(parents=True, exist_ok=True)
        await asyncio.to_thread(destination.write_bytes, content)
        return StoredFile(
            key=key, filename=filename, content_type=content_type, size_bytes=len(content)
        )

    async def load(self, key: str) -> bytes:
        return await asyncio.to_thread((self._root / key).read_bytes)

    async def delete(self, key: str) -> None:
        path = self._root / key
        if path.exists():
            await asyncio.to_thread(path.unlink)


@lru_cache
def get_storage_provider() -> StorageProvider:
    if settings.STORAGE_PROVIDER == "local":
        return LocalStorageProvider(Path(settings.STORAGE_LOCAL_ROOT))
    if settings.STORAGE_PROVIDER == "s3":
        # Lazy import: boto3 is only pulled in when object storage is actually
        # selected, so the default "local" mode stays dependency-light.
        from app.storage_s3 import S3StorageProvider

        return S3StorageProvider(
            endpoint_url=settings.STORAGE_S3_ENDPOINT_URL,
            region=settings.STORAGE_S3_REGION,
            bucket=settings.STORAGE_S3_BUCKET,
            access_key=settings.STORAGE_S3_ACCESS_KEY,
            secret_key=settings.STORAGE_S3_SECRET_KEY,
        )
    raise ValueError(f"Unsupported storage provider: {settings.STORAGE_PROVIDER}")


#: Moved here from ``branding/deps.py`` when ``quotes`` became the second
#: module needing it — the same "second consumer = infrastructure signal"
#: that pulled ``storage.py`` itself out of ``branding/`` in step 3, and
#: upload validation after it. One module needing something is not a
#: signal; two is. ``branding/deps.py`` re-exports it so nothing that
#: already imported it from there has to change.
StorageDep = Annotated[StorageProvider, Depends(get_storage_provider)]
