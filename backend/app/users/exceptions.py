"""Users-specific errors, built on the shared ``AppException`` hierarchy
(see ``app/core/exceptions.py``). Invalid credentials and inactive
accounts reuse the existing ``UnauthorizedError`` (401) — no need for a
new class for something ``core/exceptions.py`` already models correctly.
"""

from app.core.exceptions import AppException


class EmailAlreadyRegisteredError(AppException):
    status_code = 409
    error_code = "email_already_registered"
