"""Bibliothèque Métier — the Intervention core (V2 domain).

An artisan thinks in *interventions* ("remplacer un chauffe-eau"), not in
articles. This module makes the **Intervention** a first-class, reusable domain
object: a named, trade-tagged template that composes references to what the job
needs (articles, labour, travel, consumables, guarantees, conditions, phrases).

Deliberately additive and generic:

- It **reuses** the existing personal catalogue as the article store (an article
  component references a catalogue item by id only) — the catalogue is not torn
  down, and this library stays independent of its internals. No circular deps.
- It contains **no trade-specific logic**. "Chauffe-eau" is data, never code.
- It **computes no amount** and **persists nothing** here: expansion produces
  editable draft lines the quote builder drops in, and the artisan alone commits
  them (RÈGLE D'OR — no intelligence changes a devis without validation).

Other libraries named in the founding spec (Kits, Phrases, Guarantees, the
learning engine…) are added when a real consumer drives each — the same
"second consumer = infrastructure" discipline the rest of the codebase follows,
which is what keeps the model evolvable for ten years without a rewrite.
"""
