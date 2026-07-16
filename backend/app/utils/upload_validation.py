"""Generic upload validation: file type and size checks, shared by every
upload endpoint across business modules (``branding``, ``document_analysis``, ...).
"""

from fastapi import UploadFile

from app.core.exceptions import FileTooLargeError, UnsupportedFileTypeError

_CHUNK_SIZE = 1024 * 1024


async def read_validated_upload(
    upload: UploadFile, *, allowed_content_types: set[str], max_size_bytes: int
) -> bytes:
    """Read ``upload`` fully into memory, enforcing content-type and size.

    Size is checked incrementally so an oversized file is rejected as soon
    as the limit is crossed, instead of being fully buffered first.
    """
    if upload.content_type not in allowed_content_types:
        raise UnsupportedFileTypeError(
            f"Unsupported file type '{upload.content_type}'. "
            f"Allowed: {', '.join(sorted(allowed_content_types))}."
        )

    chunks: list[bytes] = []
    total = 0
    while chunk := await upload.read(_CHUNK_SIZE):
        total += len(chunk)
        if total > max_size_bytes:
            raise FileTooLargeError(
                f"File exceeds the maximum allowed size of {max_size_bytes // (1024 * 1024)} MB."
            )
        chunks.append(chunk)
    return b"".join(chunks)
