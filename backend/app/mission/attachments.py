"""Attachment manager — attach photos, documents and notes to a mission.

Pure and DB-free. V1 records *references* (a note text, or a reference/URL to a
photo/document owned elsewhere) — it does not upload files (storage/media own
that). Each attachment is {kind, label, reference, text, at}.
"""

from datetime import datetime, timezone

from app.mission.exceptions import MissionError

ATTACHMENT_KINDS: tuple[str, ...] = ("photo", "document", "note")


class AttachmentManager:
    @staticmethod
    def build(kind: str, *, label: str = "", reference: str = "", text: str = "") -> dict:
        if kind not in ATTACHMENT_KINDS:
            raise MissionError(
                f"Unknown attachment kind '{kind}' (expected one of {ATTACHMENT_KINDS})."
            )
        if kind == "note" and not text.strip():
            raise MissionError("A note attachment requires text.")
        if kind in ("photo", "document") and not reference.strip():
            raise MissionError(f"A {kind} attachment requires a reference.")
        return {
            "kind": kind,
            "label": label,
            "reference": reference,
            "text": text,
            "at": datetime.now(timezone.utc).isoformat(),
        }

    @staticmethod
    def add(attachments: list, entry: dict) -> None:
        attachments.append(entry)
