"""S3StorageProvider wiring — the production storage behind the StorageProvider
abstraction. boto3 is mocked (no real bucket): we assert it maps save/load/delete
onto the S3 API and returns portable StoredFile metadata identical to the local
provider, so switching STORAGE_PROVIDER is invisible to callers."""

import io
from unittest.mock import MagicMock, patch

from app.storage import StoredFile


def _provider():
    from app.storage_s3 import S3StorageProvider

    return S3StorageProvider(
        endpoint_url="https://s3.fr-par.example",
        region="fr-par",
        bucket="artizen-prod",
        access_key="k",
        secret_key="s",
    )


async def test_save_puts_object_and_returns_metadata() -> None:
    with patch("app.storage_s3.boto3.client") as client_factory:
        client = MagicMock()
        client_factory.return_value = client
        provider = _provider()

        stored = await provider.save(
            category="brand/logo",
            filename="Logo Final.PNG",
            content_type="image/png",
            content=b"\x89PNG",
        )

        assert isinstance(stored, StoredFile)
        assert stored.key.startswith("brand/logo/")
        assert stored.key.endswith(".png")  # extension taken from the name, lowercased
        assert stored.size_bytes == 4
        _, kwargs = client.put_object.call_args
        assert kwargs["Bucket"] == "artizen-prod"
        assert kwargs["Key"] == stored.key
        assert kwargs["Body"] == b"\x89PNG"
        assert kwargs["ContentType"] == "image/png"


async def test_load_reads_object_body() -> None:
    with patch("app.storage_s3.boto3.client") as client_factory:
        client = MagicMock()
        client.get_object.return_value = {"Body": io.BytesIO(b"data")}
        client_factory.return_value = client
        provider = _provider()

        content = await provider.load("brand/logo/abc.png")

        assert content == b"data"
        client.get_object.assert_called_once_with(
            Bucket="artizen-prod", Key="brand/logo/abc.png"
        )


async def test_delete_removes_object() -> None:
    with patch("app.storage_s3.boto3.client") as client_factory:
        client = MagicMock()
        client_factory.return_value = client
        provider = _provider()

        await provider.delete("brand/logo/abc.png")

        client.delete_object.assert_called_once_with(
            Bucket="artizen-prod", Key="brand/logo/abc.png"
        )
