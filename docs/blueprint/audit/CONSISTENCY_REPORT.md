# Consistency Report — Rapport de cohérence

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [GLOBAL_AUDIT.md](GLOBAL_AUDIT.md) — **Used By:** gouvernance — **Niveau:** 2 · Architecture

## Objective
Lister toutes les incohérences détectées, les classer, et statuer sur chacune.

## Classement
- **Résolu ✅** — corrigé ou confirmé conforme pendant l'audit.
- **Différé ⏳** — chevauchement réel, non supprimable (interdiction de retirer un moteur/objet) → arbitrage V2.
- **Dette 📌** — écart cosmétique/structurel sans impact fonctionnel.

## Incohérences de comptage
| Point | Vérification | Statut |
|---|---|---|
| « 40 objets » (vision initiale) vs fiches | 39 fiches + `_TEMPLATE` ; le narratif dit **39** | ✅ conforme |
| Comptage manuel des moteurs | script confirme **40** (l'humain avait oublié `Customer`) | ✅ conforme |
| Flux / contrats | 40 / 26, conformes aux déclarations | ✅ conforme |

## Doublons & chevauchements de responsabilité
| # | Éléments | Analyse | Statut |
|---|---|---|---|
| S1 | `Analytics` / `Performance` | même finalité (KPIs, lecture de métriques) ; Analytics est une **façade** de Performance | ⏳ OD-1 |
| S2 | `OCR` / `Document-Analysis` | OCR est une **étape** de l'analyse documentaire | ⏳ OD-2 |
| S3 | `Event` / `History` / `Audit` | trois journaux : événement de domaine / journal métier append-only / trace de sécurité — **distincts mais adjacents** | ⏳ OD-3 |
| S4 | `Reporting` / `Report` / `Analytics` | reporting recoupe l'analytique | ⏳ OD-1 |
| S5 | `Import-Export` / `Quote-Extraction` / `Document-Analysis` | pipeline d'import à responsabilités superposées | ⏳ OD-2 |

## Responsabilités ambiguës
| # | Élément | Ambiguïté | Statut |
|---|---|---|---|
| S6 | `Catalog` | présent comme **objet** ET désigné **contexte** (Business Library) | ⏳ OD-4 |
| S7 | `Customer` / `Contact` / `Company` | frontière client / interlocuteur / entité | ✅ frontières documentées, confirmées |

## Conflits de terminologie
| # | Termes | Problème | Statut |
|---|---|---|---|
| S8 | `Conversation` (moteur) / `AIConversation` (objet) | même concept, deux noms | ⏳ OD-5, terme canonique fixé en [GLOSSARY_VALIDATION](GLOSSARY_VALIDATION.md) |
| S9 | `Devis` / `Quote` | français produit / anglais code | ✅ conforme (règle deux langues) |

## Règles contradictoires
Aucune règle contradictoire détectée entre la Constitution (20 lois), les invariants produit
(CLAUDE.md) et la Constitution technique (STEP 6). Points de vigilance confirmés **cohérents** :
un seul lieu calcule (ADR-023), l'artisan décide (Loi 7/18), pas de destruction (Loi 5),
tenant mismatch → 404.

## Liens & références
**0 lien cassé sur 1725.** Quelques libellés de lien portent un chemin d'affichage différent de la
cible réelle (ex. texte `DOMAIN_RULES.md` → href `OBJECT_RULES.md`) : la **cible est correcte**,
seul le libellé diffère → 📌 dette cosmétique D3, sans impact de navigation.

## Corrections effectuées pendant l'audit
1. Réconciliation des comptes (39/40/40/26) — **confirmés**, narratif aligné.
2. Terme canonique tranché pour S8 (voir GLOSSARY_VALIDATION).
3. Tous les chevauchements consignés en [OPEN_DECISIONS.md](OPEN_DECISIONS.md) (traçabilité de décision).

## Forbidden (rappel mission)
Aucune suppression/invention de moteur ou d'objet. Les chevauchements sont **documentés**, pas résolus par retrait.

## Acceptance Criteria
Toute incohérence est listée, classée et statuée ; aucune incohérence majeure ne reste sans traitement.

## Related Documents
[OPEN_DECISIONS.md](OPEN_DECISIONS.md) · [TECHNICAL_DEBT.md](TECHNICAL_DEBT.md) · [ENGINE_VALIDATION.md](ENGINE_VALIDATION.md)

## Next Reading
[DEPENDENCY_REPORT.md](DEPENDENCY_REPORT.md)

## Changelog
- 1.0 (2026-08-02) — Rapport initial.
