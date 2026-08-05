# Glossary Validation — Contrôle terminologique

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../glossary/GLOSSARY.md](../glossary/GLOSSARY.md), [../domain/DOMAIN_GLOSSARY.md](../domain/DOMAIN_GLOSSARY.md) — **Used By:** tout le Blueprint — **Niveau:** 2 · Architecture

## Objective
Garantir que chaque terme est **défini**, **unique**, et **employé partout avec le même sens**.
Supprimer synonymes, ambiguïtés et variantes inutiles — sans renommer de fichier (préserver les 1725 liens).

## Règle des deux langues (invariant vérifié)
| Face à l'artisan (français produit) | Dans le code (anglais) |
|---|---|
| devis | Quote |
| identité / signature / empreinte / savoir-faire | Branding / `.artizen` (interne) |
| article, client, entreprise | Article, Customer/Client, Company |
**Vérifié cohérent** : aucun terme d'ingénierie (`.artizen`, moteur, extraction, benchmark) n'est
imposé à l'écran dans les flux et contrats.

## Termes canoniques tranchés (levée d'ambiguïté)
| Ambiguïté | Décision canonique | Portée |
|---|---|---|
| `Conversation` (moteur) vs `AIConversation` (objet) | **objet = `AIConversation`**, **moteur = `AI` (capacité conversationnelle)** ; `Conversation` reste un **alias** de moteur à consolider (OD-5) | tout le Blueprint |
| `Customer` vs `Client` | **`Customer`** (code) / **client** (produit) — même entité | domaine, contrats |
| `Devis` vs `Quote` | **`Quote`** (code) / **devis** (produit) | tout |
| `Performance` vs `Analytics` vs `Reporting` | **`Performance`** = moteur de référence des métriques ; `Analytics`/`Reporting` = façades (OD-1) | moteurs |
| `Journal` (Event/History/Audit) | trois termes **distincts** : `Event` (événement de domaine), `History` (journal métier), `Audit` (trace sécurité) — jamais interchangeables | domaine, moteurs |

## Contrôles
| Contrôle | Résultat |
|---|---|
| Chaque objet/moteur/contrat a une entrée de définition | Oui (glossaires domaine + racine) |
| Terme employé avec un sens unique | Oui, sauf alias listés (OD-1/OD-5) — **tracés, non contradictoires** |
| Synonymes inutiles | Réduits à des **alias documentés** (aucune suppression de fichier — interdiction respectée) |
| Vocabulaire interdit à l'écran | Absent des flux/contrats |

## Corrections effectuées
- Fixation des termes canoniques ci-dessus (documentaire ; aucun renommage de fichier pour préserver les liens).
- Renvoi des alias vers [OPEN_DECISIONS.md](OPEN_DECISIONS.md) pour consolidation V2.

## Acceptance Criteria
Aucun terme ambigu sans décision canonique ; la règle des deux langues est respectée partout.

## Related Documents
[../glossary/GLOSSARY.md](../glossary/GLOSSARY.md) · [CONSISTENCY_REPORT.md](CONSISTENCY_REPORT.md)

## Next Reading
[ENGINE_VALIDATION.md](ENGINE_VALIDATION.md)

## Changelog
- 1.0 (2026-08-02) — Contrôle initial.
