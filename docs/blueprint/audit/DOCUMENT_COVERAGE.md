# Document Coverage — Couverture documentaire

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** gouvernance — **Niveau:** 2 · Architecture

## Objective
Mesurer le taux de couverture du Blueprint par rapport au périmètre déclaré aux STEP 1–6.

## Couverture par domaine (mesurée)
| Domaine | Déclaré | Documenté | Taux |
|---|---|---|---|
| Objets métier | 39 | 39 (+ `_TEMPLATE`) | **100 %** |
| Moteurs | 40 | 40 | **100 %** |
| Flux métier | 40 | 40 | **100 %** |
| Contrats (catégories) | 26 | 26 | **100 %** |
| Documents-cœur d'implémentation | 20 | 20 (+ ANTI_PATTERNS + CHECKLISTS) | **100 %** |
| Modèles de développement | 13 | 13 (+ index) | **100 %** |
| Templates canoniques (racine) | 10 + doc | 11 | **100 %** |
| Glossaire | 1 système | présent (racine + domaine) | **100 %** |
| ADR (système) | 1 amorce | ADR-0000 + README | **100 %** |

## Couverture qualitative (complétude des fiches)
| Contrôle | Résultat |
|---|---|
| Fiches avec entête de métadonnées | **252/252 (100 %)** |
| Liens internes valides | **1725/1725 (100 %)** |
| Fiches flux avec diagramme de séquence | 40/40 |
| Sections moteurs avec diagrammes Mermaid | présentes (STEP 3) |
| Chaîne de traçabilité complète | 100 % (0 fonctionnalité non traçable) |

## Taux global de couverture
**Périmètre déclaré : 100 % documenté.** Aucun objet, moteur, flux ni contrat annoncé n'est absent.

## Nuance honnête (couverture ≠ profondeur)
La couverture mesure la **présence** et la **complétude structurelle**, pas la profondeur métier de
chaque fiche. Les fiches générées en série (objets, moteurs, contrats) sont **complètes en structure**
mais volontairement synthétiques ; leur enrichissement métier est une action de consolidation continue,
listée en [TECHNICAL_DEBT.md](TECHNICAL_DEBT.md) (D4), sans impact sur le périmètre.

## Acceptance Criteria
Le taux de couverture du périmètre déclaré est calculé et atteint 100 % ; les écarts de profondeur sont tracés.

## Related Documents
[TECHNICAL_DEBT.md](TECHNICAL_DEBT.md) · [QUALITY_SCORECARD.md](QUALITY_SCORECARD.md)

## Next Reading
[GLOSSARY_VALIDATION.md](GLOSSARY_VALIDATION.md)

## Changelog
- 1.0 (2026-08-02) — Couverture initiale.
