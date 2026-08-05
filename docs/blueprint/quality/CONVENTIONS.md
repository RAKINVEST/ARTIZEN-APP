# Conventions

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** tous les documents — **Niveau:** 3 · Implémentation

## Objective
Fixer les conventions de rédaction du Blueprint pour un référentiel homogène, navigable et lisible par les humains comme par les IA.

## Rules
- **Markdown** : GitHub-flavored. Un seul `# H1` par document (le titre). Sections en `##`.
- **Format** : tout document suit [../templates/DOCUMENT_TEMPLATE.md](../templates/DOCUMENT_TEMPLATE.md) (métadonnées + sections dans l'ordre).
- **Titres** : phrase courte, sans numéro dans le titre du fichier (la numérotation est réservée aux ADR : `ADR-NNNN-...`).
- **Liens** : toujours **relatifs** entre documents du Blueprint ; chaque document déclare `Depends On`, `Used By`, `Next Reading`.
- **Dossiers** : minuscules, un rôle par dossier (voir [INDEX](../INDEX.md)).
- **Fichiers** : `MAJUSCULES.md` pour les documents transverses (README, INDEX, CONVENTIONS…), `Nom-descriptif.md` pour un document de contenu.
- **Images** : dans `assets/` du dossier concerné, nommées `sujet-description.png`, jamais collées en base64.
- **Diagrammes** : préférer une table ou un schéma ASCII portable ; Mermaid autorisé si l'outil de rendu le supporte.
- **Exemples** : bloc de code annoté ; jamais de donnée client réelle.
- **Terminologie** : un concept = un terme, défini dans [../glossary/GLOSSARY.md](../glossary/GLOSSARY.md). À l'écran : vocabulaire artisan uniquement (deux langues).

## Forbidden
- Vocabulaire d'ingénierie dans un texte destiné à l'artisan.
- Liens absolus internes ; documents sans navigation.

## Acceptance Criteria
Un document conforme respecte le format unique, la navigation et la terminologie.

## Related Documents
[VERSIONING.md](VERSIONING.md) · [QUALITY_RULES.md](QUALITY_RULES.md)

## Next Reading
[VERSIONING.md](VERSIONING.md)

## Changelog
- 1.0 (2026-08-02) — Conventions initiales.
