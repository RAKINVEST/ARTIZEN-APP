#!/usr/bin/env python
"""Brique Q1 CLI — ``python benchmark.py``.

Runs the Benchmark Engine over the whole corpus and:

* prints the consolidated Markdown report to stdout;
* writes ``Corpus/benchmark/report.md`` and ``report.json``;
* appends this run to ``Corpus/benchmark_history.json`` (the trend + regression
  record).

Meant to be run in the backend container::

    docker compose exec backend python benchmark.py --label v0.5
"""

import argparse
import json
from pathlib import Path

from app.document_clone.benchmark import (
    append_history,
    regression_gate,
    run_benchmark,
    to_json,
    to_markdown,
    verify_replay,
)

_DEFAULT_CORPUS = Path(__file__).parent / "Corpus"


def main() -> None:
    parser = argparse.ArgumentParser(description="ARTIZEN Benchmark Engine (Brique Q1)")
    parser.add_argument("--corpus", type=Path, default=_DEFAULT_CORPUS)
    parser.add_argument("--label", default="dev", help="run label, e.g. v0.5")
    parser.add_argument(
        "--no-history", action="store_true", help="do not append to the history file"
    )
    parser.add_argument(
        "--replay",
        action="store_true",
        help="re-run and check it reproduces the last recorded run exactly",
    )
    parser.add_argument(
        "--official",
        action="store_true",
        help="restrict to certified references only (the official benchmark)",
    )
    parser.add_argument(
        "--gate",
        action="store_true",
        help="fail if any family regressed beyond the allowed drop vs the last run",
    )
    args = parser.parse_args()

    history_path = args.corpus / "benchmark_history.json"
    history = (
        json.loads(history_path.read_text(encoding="utf-8"))
        if history_path.exists()
        else None
    )

    report = run_benchmark(
        args.corpus, label=args.label, history=history, official_only=args.official
    )

    if args.replay:
        ok, message = verify_replay(history, report)
        print(("✓ " if ok else "✗ ") + message)
        return

    if args.gate:
        passed, offenders = regression_gate(history, report)
        if passed:
            print("✓ Garde-fou : aucune famille ne régresse au-delà du seuil.")
        else:
            drops = ", ".join(f"{src} {delta:+.1f}" for src, delta in offenders)
            print(f"✗ Garde-fou : régression refusée → {drops}")
        raise SystemExit(0 if passed else 1)

    markdown = to_markdown(report)
    print(markdown)

    out_dir = args.corpus / "benchmark"
    out_dir.mkdir(parents=True, exist_ok=True)
    (out_dir / "report.md").write_text(markdown, encoding="utf-8")
    (out_dir / "report.json").write_text(to_json(report), encoding="utf-8")

    if not args.no_history and report.total_documents:
        updated = append_history(history, report)
        history_path.write_text(
            json.dumps(updated, ensure_ascii=False, indent=2), encoding="utf-8"
        )


if __name__ == "__main__":
    main()
