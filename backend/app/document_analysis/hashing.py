"""SHA-256 hashing for uploaded documents.

The hash is stored on ``DocumentAnalysis.file_hash`` and will later back
duplicate detection, versioning and fast document lookup — none of that
is implemented yet, only the hash itself (see the Étape 3 spec).
"""

import hashlib


def sha256_hex(content: bytes) -> str:
    return hashlib.sha256(content).hexdigest()
