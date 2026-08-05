"""Quality report (Phase 1) + editorial dashboard (Phase 4).

Pure rendering over the checks and metrics: structured data (for JSON / an API /
tests) plus text and a self-contained HTML dashboard. Reads only.
"""

import html
import json
from collections import Counter
from dataclasses import asdict

from app.knowledge_factory.corpus import FactoryCard
from app.knowledge_factory.metrics import KnowledgeMetrics
from app.knowledge_factory.quality import Issue, blocking_issues


def quality_report(cards: list[FactoryCard], issues: list[Issue]) -> dict:
    by_severity = Counter(i.severity for i in issues)
    by_code = Counter(i.code for i in issues)
    blocked = {i.card for i in blocking_issues(issues)}
    per_card = {
        card.rel_path: [
            {"code": i.code, "severity": i.severity, "message": i.message}
            for i in issues if i.card == card.rel_path
        ]
        for card in cards
    }
    return {
        "total_cards": len(cards),
        "cards_passing_gate": len(cards) - len(blocked),
        "cards_blocked": len(blocked),
        "issues_by_severity": dict(by_severity),
        "issues_by_code": dict(by_code),
        "per_card": per_card,
    }


def dashboard_data(
    cards: list[FactoryCard], metrics: KnowledgeMetrics, issues: list[Issue]
) -> dict:
    authors = Counter(c.metadata.get("auteur", "∅") for c in cards)
    validators = Counter(c.metadata.get("validateur", "∅") or "∅" for c in cards)
    return {
        "metrics": asdict(metrics),
        "by_type": metrics.by_type,
        "by_status": metrics.by_status,
        "by_confidence": metrics.by_confidence,
        "by_profession": metrics.by_profession,
        "by_author": dict(authors),
        "by_validator": dict(validators),
        "coverage": {
            "ratio": metrics.coverage_metier,
            "covered": metrics.covered_metiers,
            "missing": metrics.missing_metiers,
        },
        "obsolescence": {"fresh": metrics.fresh, "stale": metrics.stale, "undated": metrics.undated},
        "duplicates": metrics.duplication,
        "quality": quality_report(cards, issues),
    }


def render_text(report: dict, metrics: KnowledgeMetrics) -> str:
    lines = [
        "=== RAPPORT QUALITÉ — Knowledge Factory ===",
        f"Cartes            : {report['total_cards']}",
        f"Passent le gate   : {report['cards_passing_gate']}",
        f"Bloquées          : {report['cards_blocked']}",
        f"Couverture métier : {metrics.coverage_metier:.0%} "
        f"({len(metrics.covered_metiers)}/{len(metrics.covered_metiers) + len(metrics.missing_metiers)})",
        f"Complétude moyenne: {metrics.completeness:.0%}",
        f"Qualité (gate)    : {metrics.quality:.0%}",
        f"Densité relations : {metrics.density}",
        f"Doublons          : {metrics.duplication}",
        f"Fraîcheur         : {metrics.fresh} à jour · {metrics.stale} obsolètes · {metrics.undated} sans date",
        "",
        "Problèmes par code :",
    ]
    for code, count in sorted(report["issues_by_code"].items(), key=lambda kv: -kv[1]):
        lines.append(f"  - {code}: {count}")
    return "\n".join(lines)


def _bars(title: str, data: dict) -> str:
    if not data:
        return f"<section><h2>{html.escape(title)}</h2><p>—</p></section>"
    total = max(sum(data.values()), 1)
    rows = "".join(
        f'<div class="row"><span class="lbl">{html.escape(str(k))}</span>'
        f'<span class="bar" style="width:{round(v / total * 100)}%"></span>'
        f'<span class="val">{v}</span></div>'
        for k, v in sorted(data.items(), key=lambda kv: -kv[1])
    )
    return f"<section><h2>{html.escape(title)}</h2>{rows}</section>"


def render_html(dashboard: dict) -> str:
    m = dashboard["metrics"]
    kpis = [
        ("Cartes", m["total"]),
        ("Couverture métier", f"{m['coverage_metier']:.0%}"),
        ("Complétude", f"{m['completeness']:.0%}"),
        ("Qualité (gate)", f"{m['quality']:.0%}"),
        ("Doublons", m["duplication"]),
        ("Obsolètes", m["stale"]),
    ]
    kpi_html = "".join(
        f'<div class="kpi"><div class="k">{html.escape(str(v))}</div>'
        f'<div class="t">{html.escape(t)}</div></div>'
        for t, v in kpis
    )
    sections = "".join([
        _bars("Par type", dashboard["by_type"]),
        _bars("Par statut", dashboard["by_status"]),
        _bars("Par confiance", dashboard["by_confidence"]),
        _bars("Par métier", dashboard["by_profession"]),
        _bars("Par auteur", dashboard["by_author"]),
        _bars("Par validateur", dashboard["by_validator"]),
    ])
    data_json = html.escape(json.dumps(dashboard, ensure_ascii=False))
    return f"""<!doctype html><html lang="fr"><meta charset="utf-8">
<title>Knowledge Factory — Tableau de bord éditorial</title>
<style>
 body{{font-family:system-ui,sans-serif;margin:0;background:#faf9fc;color:#1e1b2e}}
 header{{padding:20px 24px;background:linear-gradient(120deg,#5b21b6,#7c3aed);color:#fff}}
 .kpis{{display:flex;flex-wrap:wrap;gap:12px;padding:16px 24px}}
 .kpi{{background:#fff;border-radius:12px;padding:14px 18px;box-shadow:0 1px 3px #0001;min-width:120px}}
 .kpi .k{{font-size:26px;font-weight:700}} .kpi .t{{font-size:12px;color:#6b7280}}
 section{{background:#fff;margin:12px 24px;padding:14px 18px;border-radius:12px;box-shadow:0 1px 3px #0001}}
 h2{{font-size:14px;margin:0 0 10px}}
 .row{{display:flex;align-items:center;gap:8px;margin:3px 0}}
 .lbl{{width:180px;font-size:13px}} .bar{{height:12px;background:#7c3aed;border-radius:6px;min-width:2px}}
 .val{{font-size:12px;color:#6b7280}}
</style>
<header><h1>Knowledge Factory — Tableau de bord éditorial</h1></header>
<div class="kpis">{kpi_html}</div>
{sections}
<script type="application/json" id="data">{data_json}</script>
</html>"""
