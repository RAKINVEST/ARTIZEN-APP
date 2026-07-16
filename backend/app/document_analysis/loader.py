"""First pipeline stage: fetches the raw bytes of a previously uploaded
document from storage. Deliberately dumb — it knows nothing about PDFs,
only how to turn a storage key into bytes.
"""

from app.storage import StorageProvider


class DocumentLoader:
    def __init__(self, storage: StorageProvider) -> None:
        self._storage = storage

    async def load(self, storage_key: str) -> bytes:
        return await self._storage.load(storage_key)
