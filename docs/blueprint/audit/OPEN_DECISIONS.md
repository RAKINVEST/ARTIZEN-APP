# Open Decisions — Décisions différées

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [CONSISTENCY_REPORT.md](CONSISTENCY_REPORT.md) — **Used By:** gouvernance V2 — **Niveau:** 2 · Architecture

## Objective
Consigner les décisions d'architecture à trancher **plus tard**, sans les exécuter (interdiction de
modifier le périmètre : aucun moteur/objet supprimé ou inventé en STEP 7).

## Registre
| # | Décision | Options | Recommandation (non exécutée) | Échéance |
|---|---|---|---|---|
| **OD-1** | `Analytics`/`Reporting` vs `Performance` | (a) fusionner en `Performance` avec façades ; (b) garder 3 moteurs distincts | (a) — un socle de métriques, deux vues | V2 |
| **OD-2** | `OCR`/`Import-Export` vs `Document-Analysis`/`Quote-Extraction` | (a) sous-capacités d'un pipeline d'analyse ; (b) moteurs autonomes | (a) — pipeline unique, étapes nommées | V2 |
| **OD-3** | Famille journal `Event`/`History`/`Audit` | (a) graver 3 frontières explicites ; (b) unifier | (a) — trois journaux distincts, jamais interchangeables | V2 |
| **OD-4** | `Catalog` : objet ou contexte | (a) contexte « Business Library », fiche = racine d'agrégat ; (b) objet simple | (a) | V2 |
| **OD-5** | `Conversation` (moteur) vs `AIConversation` (objet) | (a) capacité du moteur `AI`, objet `AIConversation` ; (b) moteur `Conversation` autonome | (a) | V2 |
| **OD-6** | Cycle `users ↔ branding` | (a) déplacer `Company` hors `branding` ; (b) l'assumer | (a) — refactor V2, coûteux à retarder | V2 |
| **OD-7** | Famille document `Document`/`Attachment`/`Photo`/`Invoice`/`PurchaseOrder`/`Quote`/`Report` | (a) `Document` super-type documentaire ; (b) objets indépendants | (a) | V2 |

## Règle
Ces décisions **n'affectent pas** la capacité du Blueprint à piloter le développement immédiat :
elles optimisent la cohérence, elles ne débloquent rien. Chaque exécution future passera par un **ADR**.

## Acceptance Criteria
Chaque ambiguïté résiduelle a une décision ouverte, une recommandation et une échéance ; aucune n'est exécutée en STEP 7.

## Related Documents
[TECHNICAL_DEBT.md](TECHNICAL_DEBT.md) · [../adr/](../adr/) · [ACTION_PLAN.md](ACTION_PLAN.md)

## Next Reading
[ACTION_PLAN.md](ACTION_PLAN.md)

## Changelog
- 1.0 (2026-08-02) — Registre initial.
