"""Generic upload validation: file type and size checks, shared by every
upload endpoint across business modules (``branding``, ``document_analysis``, ...).
"""

from fastapi import UploadFile

from app.core.exceptions import FileTooLargeError, UnsupportedFileTypeError

_CHUNK_SIZE = 1024 * 1024

# A client sets `Content-Type` itself, so on its own it proves nothing:
# anything at all can be uploaded as "application/pdf" simply by saying so.
# Checking the bytes is what makes the declared type mean something.
#
# Types absent from these rules (image/svg+xml — XML, no fixed signature)
# are accepted on their declared type alone and must not be trusted by
# consumers on that basis.
_MAGIC_BYTES: dict[str, tuple[bytes, ...]] = {
    "image/png": (b"\x89PNG\r\n\x1a\n",),
    "image/jpeg": (b"\xff\xd8\xff",),
}

# PDF gets a search window rather than a strict prefix check: the spec puts
# %PDF- at offset 0, but real generators emit files with junk ahead of it,
# and every reader (pypdf included) accepts those. Matching that tolerance
# keeps a genuine — if sloppy — old quote importable, while still rejecting
# a file that merely claims to be a PDF.
_PDF_SIGNATURE = b"%PDF-"
_PDF_SIGNATURE_WINDOW = 1024


def _content_matches_declared_type(content: bytes, content_type: str | None) -> bool:
    if content_type == "application/pdf":
        return _PDF_SIGNATURE in content[:_PDF_SIGNATURE_WINDOW]
    signatures = _MAGIC_BYTES.get(content_type or "")
    if signatures is None:
        return True
    return content.startswith(signatures)


async def read_validated_upload(
    upload: UploadFile, *, allowed_content_types: set[str], max_size_bytes: int
) -> bytes:
    """Read ``upload`` fully into memory, enforcing content-type and size.

    Note on the size limit: by the time this runs, Starlette has already
    parsed the multipart body, so an oversized upload has been buffered
    (to a temp file past 1 MB) before we see it. This check bounds what
    the *application* then holds in memory and hands to pypdf/Pillow — it
    is not a defense against a caller sending a huge body, which needs a
    Content-Length guard ahead of form parsing.
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
    content = b"".join(chunks)

    if not _content_matches_declared_type(content, upload.content_type):
        raise UnsupportedFileTypeError(
            f"File content does not match the declared type '{upload.content_type}'."
        )
    return content
