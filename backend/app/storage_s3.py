"""S3-compatible object storage — the production ``StorageProvider`` for a PaaS,
whose container filesystem is ephemeral (``LocalStorageProvider`` would lose every
uploaded logo/document on each redeploy).

Endpoint-driven: any S3-compatible EU provider works (Scaleway, OVH Object
Storage, MinIO…) by setting ``STORAGE_S3_ENDPOINT_URL``. The host is a
configuration value, never a code dependency (DECISIONS.md §9). ``boto3`` is
synchronous, so calls run off the event loop via ``asyncio.to_thread`` — the same
pattern ``LocalStorageProvider`` uses for its blocking file IO.
"""

import asyncio
from pathlib import Path
from uuid import uuid4

import boto3
from botocore.config import Config

from app.storage import StorageProvider, StoredFile


class S3StorageProvider(StorageProvider):
    def __init__(
        self,
        *,
        endpoint_url: str,
        region: str,
        bucket: str,
        access_key: str,
        secret_key: str,
    ) -> None:
        self._bucket = bucket
        # Empty strings → None so boto3 falls back to its own resolution (useful
        # for AWS itself); real EU providers always set an explicit endpoint.
        self._client = boto3.client(
            "s3",
            endpoint_url=endpoint_url or None,
            region_name=region or None,
            aws_access_key_id=access_key or None,
            aws_secret_access_key=secret_key or None,
            config=Config(signature_version="s3v4"),
        )

    async def save(
        self, *, category: str, filename: str, content_type: str, content: bytes
    ) -> StoredFile:
        # Keys are generated (uuid4), never derived from the user-supplied name —
        # identical rule to LocalStorageProvider, so switching provider is invisible.
        extension = Path(filename).suffix.lower()
        key = f"{category}/{uuid4().hex}{extension}"
        await asyncio.to_thread(
            self._client.put_object,
            Bucket=self._bucket,
            Key=key,
            Body=content,
            ContentType=content_type,
        )
        return StoredFile(
            key=key, filename=filename, content_type=content_type, size_bytes=len(content)
        )

    async def load(self, key: str) -> bytes:
        response = await asyncio.to_thread(
            self._client.get_object, Bucket=self._bucket, Key=key
        )
        return response["Body"].read()

    async def delete(self, key: str) -> None:
        # S3 delete is idempotent (a missing key still returns success), so this
        # honours the "no-op if it doesn't exist" contract without extra handling.
        await asyncio.to_thread(
            self._client.delete_object, Bucket=self._bucket, Key=key
        )
