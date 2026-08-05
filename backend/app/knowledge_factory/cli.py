"""Knowledge Factory CLI — the editorial team's entry point.

    python -m app.knowledge_factory.cli <command> [options]

Commands: validate · duplicates · metrics · report · dashboard · generate ·
import · release. All read-only except ``import`` (writes drafts to an output
folder) and ``release --write`` (rewrites one card in place) — neither ever
publishes automatically.
"""

import argparse
import json
import sys
from datetime import date
from pathlib import Path

from app.knowledge.source import corpus_root
from app.knowledge_factory.corpus import load_factory_corpus
from app.knowledge_factory.generator import generate_card
from app.knowledge_factory.importers import import_bytes
from app.knowledge_factory.metrics import compute_metrics
from app.knowledge_factory.quality import (
    blocking_issues,
    validate_corpus,
    validate_single,
)
from app.knowledge_factory.release import ReleaseError, transition
from app.knowledge_factory.report import (
    dashboard_data,
    quality_report,
    render_html,
    render_text,
)


def _root(args: argparse.Namespace) -> Path:
    return Path(args.root) if args.root else corpus_root()


def _cmd_validate(args: argparse.Namespace) -> int:
    cards = load_factory_corpus(_root(args))
    issues = validate_corpus(cards)
    blockers = blocking_issues(issues)
    if args.json:
        print(json.dumps([i.__dict__ for i in issues], ensure_ascii=False, indent=2))
    else:
        for issue in issues:
            print(f"[{issue.severity:7}] {issue.card}: {issue.message}")
        print(f"\n{len(cards)} cartes · {len(issues)} problèmes · {len(blockers)} bloquants")
    return 1 if blockers else 0


def _cmd_duplicates(args: argparse.Namespace) -> int:
    cards = load_factory_corpus(_root(args))
    issues = [i for i in validate_corpus(cards) if i.code in ("doublon_slug", "doublon_titre")]
    for issue in issues:
        print(f"{issue.card}: {issue.message}")
    print(f"\n{len(issues)} doublon(s)")
    return 0


def _cmd_metrics(args: argparse.Namespace) -> int:
    cards = load_factory_corpus(_root(args))
    issues = validate_corpus(cards)
    today = date.fromisoformat(args.today) if args.today else date.today()
    metrics = compute_metrics(cards, issues, today=today)
    print(json.dumps(metrics.__dict__, ensure_ascii=False, indent=2))
    return 0


def _cmd_report(args: argparse.Namespace) -> int:
    cards = load_factory_corpus(_root(args))
    issues = validate_corpus(cards)
    today = date.today()
    metrics = compute_metrics(cards, issues, today=today)
    report = quality_report(cards, issues)
    if args.json:
        print(json.dumps(report, ensure_ascii=False, indent=2))
    else:
        print(render_text(report, metrics))
    return 0


def _cmd_dashboard(args: argparse.Namespace) -> int:
    cards = load_factory_corpus(_root(args))
    issues = validate_corpus(cards)
    metrics = compute_metrics(cards, issues, today=date.today())
    data = dashboard_data(cards, metrics, issues)
    out = Path(args.out)
    out.write_text(render_html(data), encoding="utf-8")
    print(f"Tableau de bord écrit : {out}")
    return 0


def _cmd_generate(args: argparse.Namespace) -> int:
    text = generate_card(
        slug=args.slug, title=args.title, profession=args.profession,
        date=date.today().isoformat(),
    )
    if args.out:
        Path(args.out).write_text(text, encoding="utf-8")
        print(f"Brouillon écrit : {args.out}")
    else:
        print(text)
    return 0


def _cmd_import(args: argparse.Namespace) -> int:
    source = Path(args.input)
    drafts, unsupported = import_bytes(source.name, source.read_bytes())
    if unsupported:
        print(f"⚠ {unsupported}")
        return 2
    out_dir = Path(args.out)
    out_dir.mkdir(parents=True, exist_ok=True)
    for draft in drafts:
        (out_dir / f"{draft.slug}.md").write_text(draft.text, encoding="utf-8")
    print(f"{len(drafts)} brouillon(s) écrit(s) dans {out_dir} (statut Brouillon, aucune publication)")
    return 0


def _cmd_release(args: argparse.Namespace) -> int:
    path = Path(args.file)
    text = path.read_text(encoding="utf-8")
    issues = []
    if args.to == "publication":
        # Gate the publication on this specific card — validated directly, so a
        # file outside the corpus tree is still checked (never silently passed).
        issues = validate_single(path)
    try:
        updated = transition(
            text, from_stage=args.from_stage, to_stage=args.to,
            actor=args.actor, date=args.date or date.today().isoformat(), issues=issues,
        )
    except ReleaseError as error:
        print(f"✗ {error}")
        return 1
    if args.write:
        path.write_text(updated, encoding="utf-8")
        print(f"✓ {path} → {args.to}")
    else:
        print(updated)
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(prog="knowledge-factory", description=__doc__)
    parser.add_argument("--root", help="Racine du corpus (défaut : corpus embarqué).")
    sub = parser.add_subparsers(dest="command", required=True)

    for name, help_text in (
        ("validate", "Contrôle qualité de tout le corpus (sortie 1 si bloquants)."),
        ("duplicates", "Liste les doublons (slug + titre)."),
        ("report", "Rapport qualité (texte ou --json)."),
    ):
        p = sub.add_parser(name, help=help_text)
        p.add_argument("--json", action="store_true")

    sub.add_parser("metrics", help="Métriques du patrimoine (JSON).").add_argument("--today")

    p_dash = sub.add_parser("dashboard", help="Tableau de bord éditorial (HTML).")
    p_dash.add_argument("--out", default="knowledge_factory_dashboard.html")

    p_gen = sub.add_parser("generate", help="Générer un brouillon vierge conforme au modèle.")
    p_gen.add_argument("--slug", required=True)
    p_gen.add_argument("--title", required=True)
    p_gen.add_argument("--profession", required=True)
    p_gen.add_argument("--out")

    p_imp = sub.add_parser("import", help="Import massif → brouillons (jamais publié).")
    p_imp.add_argument("--input", required=True)
    p_imp.add_argument("--out", default="drafts")

    p_rel = sub.add_parser("release", help="Transition de cycle de vie (append-only).")
    p_rel.add_argument("--file", required=True)
    p_rel.add_argument("--from", dest="from_stage", required=True)
    p_rel.add_argument("--to", required=True)
    p_rel.add_argument("--actor", required=True)
    p_rel.add_argument("--date")
    p_rel.add_argument("--write", action="store_true")
    return parser


_HANDLERS = {
    "validate": _cmd_validate, "duplicates": _cmd_duplicates, "metrics": _cmd_metrics,
    "report": _cmd_report, "dashboard": _cmd_dashboard, "generate": _cmd_generate,
    "import": _cmd_import, "release": _cmd_release,
}


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    return _HANDLERS[args.command](args)


if __name__ == "__main__":
    sys.exit(main())
