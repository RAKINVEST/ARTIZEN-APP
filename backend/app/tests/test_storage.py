"""Tests for LocalStorageProvider.

Pure filesystem, no database and no HTTP — the provider takes bytes and a
category and writes a file. These use a throwaway temp dir rather than the
configured storage root, so they never touch real uploads.

The subdirectory-ownership bug that motivated
``test_save_creates_the_category_subdirectory`` could only be *fully*
reproduced in Docker (a non-root process against a root-owned volume
subdir). What can be pinned here is the behaviour that made it possible:
``save`` silently creates a per-category subdirectory, which the container
entrypoint must therefore chown alongside the root. See
``backend/entrypoint.sh`` phase 1.
"""

import uuid
from pathlib import Path

import pytest

from app.storage import LocalStorageProvider


@pytest.fixture
def storage(tmp_path: Path) -> LocalStorageProvider:
    return LocalStorageProvider(tmp_path / f"root-{uuid.uuid4().hex}")


async def test_save_writes_the_bytes_under_a_generated_key(
    storage: LocalStorageProvider,
) -> None:
    stored = await storage.save(
        category="logos", filename="logo.png", content_type="image/png", content=b"PNGDATA"
    )

    assert stored.key.startswith("logos/")
    assert stored.size_bytes == len(b"PNGDATA")
    assert await storage.load(stored.key) == b"PNGDATA"


async def test_save_creates_the_category_subdirectory(
    storage: LocalStorageProvider,
) -> None:
    """``save`` creates ``logos/`` (or ``templates/``, ...) on demand.

    This is exactly what bit us in Docker: the subdirectory is created by
    whatever process runs first, and if that was a root container, a later
    non-root one could not write into it. The entrypoint now chowns the
    whole tree, not just the root — this test documents *why* the tree has
    subdirectories to chown in the first place.
    """
    root = storage._root  # noqa: SLF001 — asserting the on-disk layout is the point

    await storage.save(
        category="templates", filename="old.pdf", content_type="application/pdf", content=b"%PDF-"
    )

    assert (root / "templates").is_dir()


async def test_the_key_never_derives_from_the_user_filename(
    storage: LocalStorageProvider,
) -> None:
    """A path-traversal filename must not influence where the file lands —
    the key is a uuid4, the original name is only metadata."""
    stored = await storage.save(
        category="logos",
        filename="../../etc/passwd",
        content_type="image/png",
        content=b"x",
    )

    assert ".." not in stored.key
    assert stored.key.startswith("logos/")


async def test_delete_removes_the_file(storage: LocalStorageProvider) -> None:
    stored = await storage.save(
        category="logos", filename="l.png", content_type="image/png", content=b"x"
    )

    await storage.delete(stored.key)

    with pytest.raises(OSError):
        await storage.load(stored.key)


async def test_deleting_a_missing_key_is_a_no_op(storage: LocalStorageProvider) -> None:
    """Deleting the previous logo on re-upload must not fail if the file is
    already gone — the caller treats delete as best-effort cleanup."""
    await storage.delete("logos/does-not-exist.png")
