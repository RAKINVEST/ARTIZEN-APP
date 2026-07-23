# `extraction/` — la zone expérimentale

Tout le code du moteur n'a pas le même statut. On distingue **deux natures** :

## Code d'infrastructure — stable, modifié rarement

Il forme les fondations mesurées de la plateforme. On n'y touche qu'avec de
bonnes raisons, et toute modification est un ADR.

- `renderer.py` — rendu déterministe
- `comparator.py` — l'oracle
- `benchmark.py` — pilotage + replay + garde-fous
- `ingest.py`, `gold_standard.py` — corpus, manifeste, certification
- `artizen_format.py`, `ai_contract.py`, `extract_report.py`, `anonymizer.py`

## Code expérimental — ce dossier, destiné à évoluer souvent

Les **heuristiques d'extraction** du *Programme expérimental d'extraction*
(ex-« Brique 4 ») vivent **ici, et nulle part ailleurs**. Elles changeront à
chaque expérience du corpus. Les isoler empêche qu'une expérimentation contamine
les fondations. Cycle : *Hypothèse → Expérience → Mesure → Décision → ADR/spec*
(pas *idée → code → correction*).

### Règles d'entrée (rappel, cf [`../DECISION_LOG.md`](../DECISION_LOG.md) ADR-011/013)

1. Conforme à la [constitution d'extraction](../EXTRACTION_SPEC.md) (v1.0).
2. Prototypage libre en **branche de travail**.
3. **Merge dans `main` interdit** sans : justification par le Starter Corpus réel
   **et** validation par `python benchmark.py` (reproductible) — sans régression
   d'une autre famille au-delà du seuil (`--gate`), sur références **certifiées**.

Vide aujourd'hui : aucune heuristique n'est écrite sans un vrai document qui la
justifie.
