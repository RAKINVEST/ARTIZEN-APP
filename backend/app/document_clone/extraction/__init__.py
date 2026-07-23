"""The **experimental** tier of the clone engine — home of the *Programme
expérimental d'extraction* (formerly "Brique 4"), and *only* its heuristics.

Its objective is not "ship a feature" but to turn open questions (UNKNOWNS.md)
into validated knowledge, on the cycle:
Hypothèse → Expérience → Mesure → Décision → ADR (ou évolution de la spec).

Deliberately isolated from the stable infrastructure (renderer, comparator,
benchmark, replay, manifest, gold_standard) so that an experiment can never
contaminate the foundations. Code here is expected to change often; code outside
here is expected to change rarely. See ``README.md`` in this package and
``DECISION_LOG.md`` (ADR-013).

Empty by design until the Starter Corpus exists: no extraction heuristic is
written here without a real document to justify it, and none is merged to the
main branch without passing the reproducible benchmark on certified references.
"""
