# Flow Principles — Règles communes à tout flux

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** flows/ — **Niveau:** 2 · Architecture

## Objective
Fixer les règles que **tout** Business Flow respecte, pour qu'aucun ne dépende d'une interprétation.

## Les 9 règles d'un flux
1. **Début & fin explicites** — un déclencheur, un état final (souvent : archivé).
2. **Traçable de bout en bout** — chaque étape est journalisée (History).
3. **Événements publiés** — chaque transition significative émet un événement (jamais silencieux).
4. **Historisation** — actions horodatées, utilisateur, action (append-only, Loi 5).
5. **Respect du Domain Model** — invariants des objets (Step 2) jamais violés.
6. **Respect des Engine Specifications** — franchissement de frontière par événement/contrat (Step 3).
7. **L'artisan décide** — le logiciel prépare/propose ; aucune validation implicite (Loi 7/18).
8. **Confirmation des actions irréversibles** — suppression, envoi, signature… jamais sans confirmation.
9. **Réversibilité par défaut** — tant que possible, une étape est annulable/compensable.

## Objectifs UX communs
- Un objectif utilisateur clair par flux ; **nombre d'étapes minimal**.
- Retour utilisateur immédiat : progression, chargement, confirmation, possibilité d'**annuler**.
- Langage artisan (aucun terme d'ingénierie) — voir [../ui/README.md](../ui/README.md).

## Objectifs de performance communs
- Étapes **synchrones** = ce que l'artisan attend (création, calcul du total) : réponse rapide.
- Étapes **asynchrones** = analyse IA/OCR, envois, indexation : différées, avec notification.
- Aucun blocage : un traitement long ne gèle jamais l'interface.

## Acceptance Criteria
Chaque flux applique les 9 règles ; ses étapes synchrones/asynchrones sont identifiées.

## Related Documents
[FLOW_STATES.md](FLOW_STATES.md) · [FLOW_PATTERNS.md](FLOW_PATTERNS.md) · [FLOW_ANTI_PATTERNS.md](FLOW_ANTI_PATTERNS.md)

## Next Reading
[FLOW_STATES.md](FLOW_STATES.md)

## Changelog
- 1.0 (2026-08-02) — Principes initiaux.
