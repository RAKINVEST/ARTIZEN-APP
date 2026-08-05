"""Tests for the Knowledge Production Factory (no DB, no HTTP).

Build a tiny throwaway corpus in ``tmp_path`` and exercise the toolchain:
validators + gate, duplicates, metrics, generator, release lifecycle and bulk
import. Read-only over content; the factory never modifies existing cards.
Run with ``pytest --noconftest`` (in the container — it imports app config).
"""

from datetime import date
from pathlib import Path

import pytest

from app.knowledge_factory.corpus import load_factory_corpus, load_single_card
from app.knowledge_factory.generator import generate_card
from app.knowledge_factory.importers import import_bytes
from app.knowledge_factory.metrics import compute_metrics
from app.knowledge_factory.quality import (
    blocking_issues,
    validate_corpus,
    validate_single,
)
from app.knowledge_factory.release import ReleaseError, can_transition, transition
from app.knowledge_factory.report import dashboard_data, quality_report, render_html

_TODAY = date(2026, 8, 3)


def _valid_card(*, slug: str = "valid-card", relation: str = "other") -> str:
    return f"""# Remplacer un joint

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `{slug}` |
| Titre | Remplacer un joint |
| Profession | `metier:plomberie` |
| Version | v1.0 |
| Auteur | Jean |
| Validateur | Marie |
| Statut | Brouillon |
| Indice de confiance | **A** |

## Cadrage
- **Objectif** : rétablir l'étanchéité.
- **Résumé** : couper l'eau, remplacer le joint, contrôler.

## Réalisation
- **Étapes** : 1. couper 2. remplacer 3. contrôler.
- **Points critiques** : serrage.
- **Sécurité** : couper l'eau.

## Cadre & suites
- **Normes** : DTU 60.1.
- **Relations** : [{relation}]({relation}.md)

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v1.0 | 2026-08-03 | Jean | Marie | création |
"""


def _corpus(tmp_path: Path, cards: dict[str, str]) -> Path:
    root = tmp_path / "professions" / "plomberie" / "cards"
    root.mkdir(parents=True)
    for name, text in cards.items():
        (root / f"{name}.md").write_text(text, encoding="utf-8")
    return tmp_path


# --- validators + gate ------------------------------------------------------

def test_complete_card_passes_the_gate(tmp_path: Path) -> None:
    _corpus(tmp_path, {"valid-card": _valid_card(), "other": _valid_card(slug="other", relation="valid-card")})
    cards = load_factory_corpus(tmp_path)
    issues = validate_corpus(cards)
    valid = [c for c in cards if c.item.slug == "valid-card"][0]
    card_blockers = [i for i in blocking_issues(issues) if i.card == valid.rel_path]
    assert card_blockers == []


@pytest.mark.parametrize(
    ("mutation", "expected_code"),
    [
        (lambda t: t.replace("DTU 60.1", "réseau"), "source_absente"),
        (lambda t: t.replace("`metier:plomberie`", "⟦à préciser⟧"), "taxonomie_absente"),
        (lambda t: t.replace("**A**", "⟦à préciser⟧"), "confiance_absente"),
        (lambda t: t.replace("- **Relations** : [other](other.md)", "- **Relations** :"), "relations_absentes"),
        (lambda t: t.replace("| Version | v1.0 |", "| Version | ⟦à préciser⟧ |"), "champ_obligatoire_manquant"),
        (lambda t: t.replace("[other](other.md)", "[cassé](inexistant.md)"), "lien_casse"),
    ],
)
def test_gate_refuses_each_defect(tmp_path: Path, mutation, expected_code) -> None:
    _corpus(tmp_path, {"card": mutation(_valid_card(slug="card")), "other": _valid_card(slug="other")})
    issues = validate_single((tmp_path / "professions/plomberie/cards/card.md"))
    codes = {i.code for i in blocking_issues(issues)}
    assert expected_code in codes


def test_duplicate_slug_is_blocking(tmp_path: Path) -> None:
    root_a = tmp_path / "professions/plomberie/cards"
    root_b = tmp_path / "professions/chauffage/cards"
    root_a.mkdir(parents=True)
    root_b.mkdir(parents=True)
    (root_a / "dup.md").write_text(_valid_card(slug="dup"), encoding="utf-8")
    (root_b / "dup.md").write_text(_valid_card(slug="dup"), encoding="utf-8")
    issues = validate_corpus(load_factory_corpus(tmp_path))
    assert any(i.code == "doublon_slug" for i in blocking_issues(issues))


# --- metrics ----------------------------------------------------------------

def test_metrics_are_computed_and_never_mutate(tmp_path: Path) -> None:
    _corpus(tmp_path, {"a": _valid_card(slug="a", relation="b"), "b": _valid_card(slug="b", relation="a")})
    cards = load_factory_corpus(tmp_path)
    before = [c.text for c in cards]
    metrics = compute_metrics(cards, validate_corpus(cards), today=_TODAY)
    assert metrics.total == 2
    assert metrics.quality == 1.0  # both complete
    assert metrics.density == 1.0  # one relation each
    assert metrics.duplication == 0
    assert metrics.fresh == 2
    assert 0.0 <= metrics.coverage_metier <= 1.0
    assert [c.text for c in cards] == before  # read-only


# --- generator --------------------------------------------------------------

def test_generator_produces_conforming_draft() -> None:
    text = generate_card(slug="poser-siphon", title="Poser un siphon", profession="plomberie", date="2026-08-03")
    assert "Statut | Brouillon" in text
    assert "**Objectif**" in text and "**Sécurité**" in text
    assert "metier:plomberie" in text


# --- release lifecycle ------------------------------------------------------

def test_transitions_are_forward_only() -> None:
    assert can_transition("brouillon", "relecture")
    assert not can_transition("brouillon", "publication")
    assert not can_transition("publication", "brouillon")


def test_release_is_append_only(tmp_path: Path) -> None:
    text = _valid_card(slug="x")
    updated = transition(text, from_stage="brouillon", to_stage="relecture", actor="ed", date="2026-08-03")
    assert text.strip() in updated.replace("Brouillon", "Brouillon")  # original preserved
    assert updated.count("| — ") == 1  # one new history row appended
    assert "passage → relecture" in updated


def test_publication_blocked_by_gate(tmp_path: Path) -> None:
    incomplete = generate_card(slug="draft", title="Brouillon", profession="plomberie", date="2026-08-03")
    path = tmp_path / "draft.md"
    path.write_text(incomplete, encoding="utf-8")
    with pytest.raises(ReleaseError):
        transition(
            incomplete, from_stage="validation", to_stage="publication",
            actor="ed", date="2026-08-03", issues=validate_single(path),
        )


def test_publication_allowed_when_clean(tmp_path: Path) -> None:
    _corpus(tmp_path, {"ok": _valid_card(slug="ok"), "other": _valid_card(slug="other")})
    path = tmp_path / "professions/plomberie/cards/ok.md"
    text = path.read_text(encoding="utf-8")
    published = transition(
        text, from_stage="validation", to_stage="publication",
        actor="Marie", date="2026-08-03", issues=validate_single(path),
    )
    assert "Statut | Validé" in published


# --- bulk import ------------------------------------------------------------

def test_import_csv_produces_drafts() -> None:
    csv_bytes = b"title,profession,description\nPurger un radiateur,plomberie,Ouvrir la purge\n"
    drafts, unsupported = import_bytes("src.csv", csv_bytes)
    assert unsupported is None
    assert len(drafts) == 1
    assert "Statut | Brouillon" in drafts[0].text  # never published
    assert drafts[0].slug == "purger-un-radiateur"


def test_import_json_produces_drafts() -> None:
    drafts, _ = import_bytes("src.json", b'[{"title": "Test", "profession": "plomberie"}]')
    assert len(drafts) == 1
    assert "Statut | Brouillon" in drafts[0].text


def test_import_unsupported_is_graceful() -> None:
    drafts, unsupported = import_bytes("weird.xyz", b"data")
    assert drafts == []
    assert unsupported is not None


def test_import_markdown_passthrough() -> None:
    drafts, _ = import_bytes("note.md", b"# Mon titre\n\nContenu.")
    assert drafts[0].text.count("Mon titre") >= 1
    assert "## Import" in drafts[0].text


# --- report / dashboard -----------------------------------------------------

def test_report_and_dashboard_render(tmp_path: Path) -> None:
    _corpus(tmp_path, {"a": _valid_card(slug="a"), "other": _valid_card(slug="other")})
    cards = load_factory_corpus(tmp_path)
    issues = validate_corpus(cards)
    report = quality_report(cards, issues)
    assert report["total_cards"] == 2
    metrics = compute_metrics(cards, issues, today=_TODAY)
    html = render_html(dashboard_data(cards, metrics, issues))
    assert "Tableau de bord éditorial" in html
    assert "Couverture métier" in html


def test_load_single_card_defaults_type() -> None:
    # A file outside the tree still gets checked (type falls back to card).
    text = generate_card(slug="x", title="X", profession="plomberie", date="2026-08-03")
    from tempfile import NamedTemporaryFile

    with NamedTemporaryFile("w", suffix=".md", delete=False, encoding="utf-8") as handle:
        handle.write(text)
        handle_path = Path(handle.name)
    card = load_single_card(handle_path)
    assert card.item.type == "card"
