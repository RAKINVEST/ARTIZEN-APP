# Flow Patterns — Patrons de flux

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [FLOW_PRINCIPLES.md](FLOW_PRINCIPLES.md) — **Used By:** flows/ — **Niveau:** 2 · Architecture

## Objective
Les formes récurrentes de flux, à réutiliser plutôt qu'à réinventer.

## Patrons
| Patron | Forme | Exemple |
|---|---|---|
| **Créer → valider → publier** | saisie → invariants → événement | Créer un client |
| **Proposer → décider** | le moteur suggère, l'artisan choisit | Ajouter une intervention (suggestions) |
| **Pipeline d'import** | upload → analyse → extraction → révision → validation | Importer/Extraire un devis |
| **Transition d'état** | action → transition → événement | Envoyer/Signer un devis |
| **Composition** | assembler des blocs réutilisables, puis éditer | Utiliser un kit |
| **Archiver, pas détruire** | fin de vie sans perte (Loi 5) | Archiver / Restaurer |
| **Asynchrone + notification** | traitement long différé, retour par Notification | Extraction IA, envoi e-mail |
| **Compensation** | annuler par une action inverse tracée | Avoir (annule une facture) |

## Règles
Tout flux cite le(s) patron(s) qu'il applique. Un flux d'action irréversible inclut toujours une étape de confirmation.

## Acceptance Criteria
Chaque patron a une forme et un exemple réel.

## Related Documents
[FLOW_ANTI_PATTERNS.md](FLOW_ANTI_PATTERNS.md)

## Next Reading
[FLOW_ANTI_PATTERNS.md](FLOW_ANTI_PATTERNS.md)

## Changelog
- 1.0 (2026-08-02) — Patrons initiaux.
