"""Notification templates — pure, deterministic (subject + body rendering).

A small registry of built-in templates. ``render`` fills them from a context
and never invents a value (a missing variable is a clear error, not a guess).
"""

from app.notification.exceptions import NotificationError

# key -> (subject template, body template). Artisan-facing language.
_TEMPLATES: dict[str, tuple[str, str]] = {
    "mission_scheduled": (
        "Intervention planifiée",
        "Votre intervention « {title} » est planifiée le {date}.",
    ),
    "mission_cancelled": (
        "Intervention annulée",
        "L'intervention « {title} » a été annulée.",
    ),
    "quote_sent": (
        "Votre devis {number}",
        "Votre devis {number} est disponible.",
    ),
    "generic": ("{subject}", "{body}"),
}


def render(template_key: str, context: dict) -> tuple[str, str]:
    template = _TEMPLATES.get(template_key)
    if template is None:
        raise NotificationError(f"Unknown notification template '{template_key}'.")
    subject_tpl, body_tpl = template
    try:
        return subject_tpl.format(**context), body_tpl.format(**context)
    except KeyError as error:
        raise NotificationError(f"Missing template variable {error}.") from error


def available_templates() -> list[str]:
    return list(_TEMPLATES)
