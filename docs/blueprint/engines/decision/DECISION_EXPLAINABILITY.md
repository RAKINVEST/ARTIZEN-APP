# Decision Explainability — Explicabilité

> **Version** 1.0 — **Status** Validated — **Owner** Decision — **Last Update** 2026-08-02
> **Depends On:** [DECISION_SCORING.md](DECISION_SCORING.md) — **Used By:** UX, confiance utilisateur — **Niveau:** 2 · Architecture

## Objective
Garantir que **chaque** élément proposé est **justifiable** et **traçable** à ses sources (Loi 6).

## Chaque proposition répond à « pourquoi ? »
| Question | Réponse fondée sur |
|---|---|
| Pourquoi **cette intervention** ? | intention comprise + activité + contexte (équipement/problème) |
| Pourquoi **ce kit** ? | relation `utilise-kit` de la carte retenue |
| Pourquoi **cette phrase** ? | relation `cite-phrase` (garantie/mention pertinente) |
| Pourquoi **cette garantie** ? | relation carte → `Warranty` + contexte |
| Pourquoi **cette procédure** ? | relation carte → procédure (sécurité/étapes) |
| Pourquoi **ce diagnostic** ? | relation `traite-diagnostic` + symptôme du contexte |
| Pourquoi **cette check-list** ? | relation `a-checklist` (contrôle du geste) |
| Pourquoi **cette photo attendue** ? | preuve/contrôle exigé par la carte |

## Exigences
- Toute réponse **cite** la ou les **sources** (carte + version, tag, préférence, règle) — traçabilité.
- L'explication indique le **niveau de confiance** ([../../../knowledge/factory/CONFIDENCE_MODEL.md](../../../knowledge/factory/CONFIDENCE_MODEL.md)) et signale les éléments **à confirmer** (D).
- Une proposition **sans explication** n'est **pas** présentée (pas de « boîte noire »).
- L'explication est en **langage artisan** (deux langues).

## Conformité
Traçable jusqu'aux données du Knowledge Engine ; aucune boîte noire ; confiance affichée. ✅

## Changelog
- 1.0 (2026-08-02) — Explicabilité initiale.
