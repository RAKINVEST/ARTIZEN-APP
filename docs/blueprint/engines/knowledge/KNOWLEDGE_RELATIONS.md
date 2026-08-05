# Knowledge Relations — Relations documentées

> **Version** 1.0 — **Status** Validated — **Owner** Knowledge — **Last Update** 2026-08-02
> **Depends On:** [KNOWLEDGE_GRAPH.md](KNOWLEDGE_GRAPH.md) — **Used By:** IA, recherche — **Niveau:** 2 · Architecture

## Objective
Documenter **chaque relation** du graphe : sens, cardinalité, mode d'accès. Toutes portées par la
Card `Knowledge` ; toutes en **lecture seule par id**.

## Table des relations
| # | De → Vers | Cardinalité | Sens | Accès | Source (fiche gelée) |
|---|---|---|---|---|---|
| R1 | Knowledge → Mission | n..1 | Card référence sa mission d'origine | lecture par id | objets liés `Knowledge` |
| R2 | Knowledge → Intervention | n..1 | Card référence l'opération concernée | lecture par id | objets liés `Knowledge` |
| R3 | Knowledge → Photo | 1..n | Card illustrée par des photos terrain | lecture par id | objets liés `Knowledge` |
| R4 | Knowledge → Document | 1..n | Card liée à des documents (rapport, notice) | lecture par id | objets liés `Knowledge` |
| R5 | Knowledge → Media | 1..n | Card attache des médias | référence/attache | « Objets utilisés » fiche moteur |
| R6 | Mission ⇢ Knowledge | événement | `MissionClosed` déclenche l'apprentissage | événement consommé | fiche moteur |

## Règles communes (invariants gelés)
- Toute relation est **par id** (Loi 1/11) — la Card ne **contient** pas les objets liés.
- Aucune relation n'autorise une **écriture** de l'objet cible (interdit `écrire Mission`).
- Une relation cassée (objet cible archivé/supprimé côté propriétaire) laisse la Card **intacte** :
  la Card conserve la référence historique (append-only, Loi 5).

## Relations volontairement NON créées (éviteraient un ADR)
- Knowledge → `Client`, `Quote`, `Warranty`, `Equipment`, `Room` : **non ajoutées**. Elles ne
  figurent pas dans les objets liés gelés ; les introduire exigerait un **ADR** (voir OPEN POINTS
  de [README.md](README.md) et [KNOWLEDGE_VIEWS.md](KNOWLEDGE_VIEWS.md)).

## Conformité (STEP 1–8)
- R1–R5 = « Objets liés/utilisés » gelés ; R6 = événement consommé gelé. ✅
- Aucune relation hors périmètre gelé. ✅

## Related Documents
[KNOWLEDGE_EVENTS.md](KNOWLEDGE_EVENTS.md) · [KNOWLEDGE_GRAPH.md](KNOWLEDGE_GRAPH.md)

## Next Reading
[KNOWLEDGE_EVENTS.md](KNOWLEDGE_EVENTS.md)

## Changelog
- 1.0 (2026-08-02) — Relations initiales.
