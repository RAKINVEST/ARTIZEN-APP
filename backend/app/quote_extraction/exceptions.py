"""Errors raised by the V2 quote-extraction pipeline.

All subclass ``AppException`` so the API returns the project's single stable
error envelope. Each one exists to make a failure *honest and visible* rather
than papered over with a fabricated fallback.
"""

from app.core.exceptions import AppException


class ExtractionProviderUnavailableError(AppException):
    """No real AI provider is configured, so extraction cannot run.

    Deliberately an error, never a silent fall back to the deterministic mock:
    the mock cannot read a quote, and returning invented data would violate the
    one rule of this engine — the imported PDF is the only source of truth.
    """

    status_code = 503
    error_code = "extraction_provider_unavailable"


class ExtractionResponseError(AppException):
    """The AI provider answered, but its response was not valid extraction JSON
    (unparseable, or failed schema validation). We refuse to guess what it
    meant."""

    status_code = 502
    error_code = "extraction_response_invalid"


class FabricatedDataError(AppException):
    """A hard safety net: the extraction contains a known demonstration literal
    (the V1 ``sample_document`` values). This must never reach a user, so we
    fail loudly instead of rendering it."""

    status_code = 500
    error_code = "extraction_fabricated_data"


class NotAQuoteDocumentError(AppException):
    """The target analysis is not a quote (e.g. an invoice), so it cannot be
    reconstructed as an editable devis. 400 — a client sent the wrong id."""

    status_code = 400
    error_code = "not_a_quote_document"


class DocumentTextUnavailableError(AppException):
    """The analysis carries no extracted text yet — it was never processed, or
    processing failed. 409: run ``/document-analysis/{id}/process`` first."""

    status_code = 409
    error_code = "document_text_unavailable"


class IncompleteExtractionError(AppException):
    """The extraction is missing a field required to render a faithful document
    (e.g. the quote number or its date). Reported with the exact missing fields
    so the artisan can complete them — never invented."""

    status_code = 422
    error_code = "extraction_incomplete"

    def __init__(self, missing: list[str]) -> None:
        self.missing = missing
        super().__init__(
            "Le document importé n'a pas pu être lu complètement : "
            f"champ(s) manquant(s) — {', '.join(missing)}."
        )
