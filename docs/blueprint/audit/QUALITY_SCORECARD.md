# Quality Scorecard — Carte de notation

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** tous les rapports d'audit — **Used By:** gouvernance — **Niveau:** 2 · Architecture

## Objective
Attribuer une note justifiée par domaine et un score global.

## Échelle
Note sur 10. ≥ 9 excellent · 7–8 solide · 5–6 à consolider · < 5 à reprendre.

## Notation
| Domaine | Note | Justification |
|---|---|---|
| **Architecture** | 9 / 10 | monolithe modulaire + read-side événementiel cohérents ; 1 cycle de code borné (`users↔branding`) |
| **Domain** | 8 / 10 | 39 objets, 0 orphelin, invariants présents ; familles adjacentes (journal, document) à clarifier |
| **Engines** | 8 / 10 | 40 moteurs, frontières nettes ; 3 alias de responsabilité à consolider (Analytics/OCR/Conversation) |
| **Flows** | 9 / 10 | 40 flux, diagrammes + états + erreurs + permissions complets |
| **Contracts** | 9 / 10 | 26 catégories, enveloppe d'erreur unique, cohérence code↔contrat vérifiée ; profondeur endpoint à enrichir |
| **Documentation** | 10 / 10 | format unique, 252/252 métadonnées, 0 lien cassé |
| **Navigation** | 10 / 10 | README + INDEX + Next Reading partout ; 1725 liens valides |
| **Maintenabilité** | 9 / 10 | Constitution technique complète (DoD, checklists, templates) ; standards ancrés dans le code réel |
| **Traçabilité** | 9 / 10 | chaîne Vision→Tests complète ; colonne « tests » = intention (pas de code en STEP 7) |
| **Cohérence** | 8 / 10 | 0 règle contradictoire ; ambiguïtés résiduelles = alias tracés (OD-1..7) |

## Score global
**Moyenne : 8,7 / 10 — « solide à excellent ».**
Le Blueprint est apte à piloter plusieurs années de développement. Les points < 9 sont tous des
**consolidations sémantiques** différées, aucun n'est bloquant.

## Justification du non-10 global
Honnêteté d'audit : les notes de Domain/Engines/Cohérence intègrent les 7 chevauchements réels
(S1–S7). Ils sont documentés, non résolus par suppression (interdiction respectée) — donc comptés
comme dette ouverte, pas comme perfection.

## Acceptance Criteria
Chaque domaine a une note justifiée ; le score global est calculé et argumenté.

## Related Documents
[GLOBAL_AUDIT.md](GLOBAL_AUDIT.md) · [TECHNICAL_DEBT.md](TECHNICAL_DEBT.md)

## Next Reading
[TECHNICAL_DEBT.md](TECHNICAL_DEBT.md)

## Changelog
- 1.0 (2026-08-02) — Notation initiale.
