"""Shared multi-tenant ownership check (Étape 10).

Every business module's by-id routes (get/update/delete) fetch a
resource via their existing service unchanged, then call this to
confirm the resource actually belongs to the caller's company before
returning or mutating it. A mismatch raises the same ``NotFoundError``
a made-up id would — this API never confirms that another company's
resource exists, which a 403 would leak.

Kept here rather than duplicated per module: the very first two
consumers (``catalog`` and ``clients``) already needed the exact same
three lines, the same "second consumer = infrastructure signal" that
moved ``storage.py``/upload validation out of ``branding/`` in Étape 3.
"""

import uuid

from app.core.exceptions import NotFoundError


def ensure_same_company(
    resource_company_id: uuid.UUID, resource_id: uuid.UUID, current_company_id: uuid.UUID
) -> None:
    if resource_company_id != current_company_id:
        raise NotFoundError(f"Resource {resource_id} not found.")
