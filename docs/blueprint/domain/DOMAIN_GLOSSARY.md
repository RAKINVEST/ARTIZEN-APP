# Domain Glossary — Langage ubiquitaire

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [OBJECT_CATALOG.md](OBJECT_CATALOG.md), [../glossary/GLOSSARY.md](../glossary/GLOSSARY.md) — **Used By:** toute l'application — **Niveau:** 2 · Architecture

## Objective
Le **vocabulaire officiel** du domaine. Toute l'application (code, docs, écrans) utilise exactement ces termes. Chaque terme : définition, synonymes **interdits**, contexte, exemple. Complète le glossaire produit ([../glossary/GLOSSARY.md](../glossary/GLOSSARY.md)).

## Termes
| Terme | Définition | Synonymes interdits | Contexte | Exemple |
|---|---|---|---|---|
| **Company** | L'entreprise artisanale, racine de tenant | compte, org, société | Identity | « Plomberie Bernard » |
| **Mission** | Unité de travail autour d'un chantier | dossier, affaire, projet, job | Mission | « Mission salle de bain Martin » |
| **Intervention** | Description réutilisable d'un travail (unité de pensée) | prestation-type, opération | Intervention | « Remplacement chauffe-eau » |
| **Kit** | Préparation : composition d'éléments | pack, bundle, lot | Business Library | « Kit PAC Atlantic » |
| **Article** | Produit/prestation réutilisable | produit, item, ligne | Business Library | « Chauffe-eau 200 L » |
| **Phrase** | Texte réutilisable (garantie, condition…) | note, libellé libre | Business Library | « Garantie 2 ans P&MO » |
| **Customer** | Le client de l'entreprise | prospect (état, pas objet), tiers | Client | « Mme Martin » |
| **Site** | Lieu d'intervention d'un Customer | adresse (VO), chantier (=Mission) | Client | « 3 rue des Lilas » |
| **Quote** | Devis : projection commerciale d'interventions | proposition, estimation | Commercial | « DEV-2026-… » |
| **Invoice** | Facture | note, reçu | Commercial | « FAC-2026-… » |
| **Document** | Pièce jointe (octets) | fichier, média (Photo est un cas) | Media | notice PDF |
| **Knowledge** | Savoir capitalisé (fiche d'expérience) | note interne, mémo | Knowledge | « PAC Mitsubishi : bruit → … » |
| **Event** | Fait de domaine immuable | log, message | Journal | `MissionCompleted` |
| **History** | Journal métier append-only d'un objet | audit (= sécurité), log | Journal | « Devis généré le … » |
| **Suggestion** | Proposition justifiée + confiance ∈ [0,1] | recommandation forcée, auto-ajout | Decision | « Vous ajoutez habituellement… » |
| **Visibility** | Privé / Entreprise / Groupe / Public | droit (=Role), partage social | Sharing | ressource « Public » |

## Rules
Un concept = un terme. Un synonyme interdit ne doit apparaître ni dans le code, ni dans les docs, ni à l'écran. Tout nouveau terme est ajouté ici **avant** usage.

## Forbidden
Employer un synonyme interdit ; réutiliser un terme pour deux concepts.

## Acceptance Criteria
Chaque objet du catalogue a un terme officiel et ses synonymes interdits.

## Related Documents
[../glossary/GLOSSARY.md](../glossary/GLOSSARY.md) · [OBJECT_CATALOG.md](OBJECT_CATALOG.md)

## Next Reading
[DOMAIN_PATTERNS.md](DOMAIN_PATTERNS.md)

## Changelog
- 1.0 (2026-08-02) — Langage ubiquitaire initial.
