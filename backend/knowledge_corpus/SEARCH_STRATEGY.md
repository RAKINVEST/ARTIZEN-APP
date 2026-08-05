# Search Strategy — Stratégie de recherche

> **Version** 1.0 — **Status** Validated — **Owner** Éditorial / Contenu métier — **Last Update** 2026-08-02
> **Depends On:** [TAGGING.md](TAGGING.md), [../blueprint/engines/knowledge/KNOWLEDGE_VIEWS.md](../blueprint/engines/knowledge/KNOWLEDGE_VIEWS.md) — **Used By:** contributeurs, IA, UI

## Objective
Permettre de **retrouver** une carte à l'échelle de dizaines de milliers d'entrées, et d'**éviter les
doublons** avant création. La recherche est **une projection en lecture** ; le contenu reste unique.

## Axes de recherche (projections)
Alignés sur [KNOWLEDGE_VIEWS](../blueprint/engines/knowledge/KNOWLEDGE_VIEWS.md) et [TAGGING.md](TAGGING.md) :
par **métier**, **famille/sous-famille**, **problème**, **équipement**, **matériau**, **pièce**,
**marque**, **complexité**, **urgence**, **saison**, **type d'intervention**, plus **plein-texte**
(titre, objectif, résumé) et **relations** (kit, diagnostic, norme…).

## Anti-doublon (avant création)
1. Recherche plein-texte sur le **titre** et l'**objectif**.
2. Filtrage par **profession + famille + tags** clés (équipement/matériau/problème).
3. Si une carte équivalente existe → **référence** ou **variante**, jamais un doublon.

## Principes
- Une carte est indexée par ses **champs** et ses **tags** (pas de métadonnée cachée).
- Les projections ne **dupliquent** pas le contenu ; elles ordonnent/filtrent (Loi 1).
- La recherche **ne modifie** jamais une carte.

## Portée & implémentation
La mécanique d'indexation (moteur de recherche, embeddings…) appartient à l'**implémentation**
(moteur `Search`/`Knowledge`) — hors périmètre de cette fondation éditoriale.

## Changelog
- 1.0 (2026-08-02) — Stratégie initiale.
