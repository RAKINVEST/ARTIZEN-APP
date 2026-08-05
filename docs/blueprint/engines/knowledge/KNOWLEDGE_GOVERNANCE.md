# Knowledge Governance — Gouvernance & intégration

> **Version** 1.0 — **Status** Validated — **Owner** Knowledge — **Last Update** 2026-08-02
> **Depends On:** [../ENGINE_DEPENDENCIES.md](../ENGINE_DEPENDENCIES.md), [../../contracts/VERSIONING_POLICY.md](../../contracts/VERSIONING_POLICY.md) — **Used By:** implémentation future — **Niveau:** 2 · Architecture

## Objective
Fixer la propriété, le versionnement, l'autorité de validation, et documenter l'intégration avec les
autres moteurs (interfaces **documentaires**, jamais des contrats de remplacement).

## Propriété & autorité
- **Propriétaire unique** : Knowledge Engine (Loi 1). Aucun autre moteur n'écrit `Knowledge`.
- **Autorité de validation** : un **humain** (l'artisan) ; le passage `Validé` n'est jamais automatique (Loi 7/18).

## Versionnement (append-only — Loi 5)
- Une fiche **validée** ne se modifie pas : elle est **remplacée** par une **nouvelle version** ;
  l'ancienne est **archivée**, jamais détruite.
- Chaque version conserve son **historique** (History, Loi 4/5) : auteur, date, motif.
- Le versionnement suit [../../contracts/VERSIONING_POLICY.md](../../contracts/VERSIONING_POLICY.md).

## Déclencheurs d'ADR (rien de tout cela n'est fait ici)
Créer/renommer/déplacer un objet · ajouter un objet de facette (Equipment, Room…) · ajouter un
événement hors `KnowledgeCaptured`/`BestPracticeValidated`/`MissionClosed` · partage inter-entreprises.

## Intégration inter-moteurs (interfaces documentaires)
> Ces interfaces **illustrent** les échanges ; elles **ne remplacent pas** les Contracts (STEP 5).
> Tout échange passe par **événement/contrat**, jamais par accès direct.

| Moteur | Sens | Interface (documentaire) |
|---|---|---|
| **Mission** | Mission → Knowledge | consomme `MissionClosed` (apprentissage) ; **n'écrit jamais** Mission |
| **Workflow** | Knowledge → Workflow | fournit des check-lists/étapes issues d'une Card (lecture) |
| **Catalog** | Knowledge ↔ Catalog | référence métiers/familles (lecture) ; ne modifie pas le catalogue |
| **Quote** | Knowledge → Quote | alimente le devis en savoir (lecture) ; **ne calcule aucun montant** (ADR-023) |
| **AI Companion** | Knowledge → IA | l'IA lit/croise les Cards (lecture seule, traçable — voir LEARNING §IA) |
| **Document Analysis** | Document Analysis → Knowledge | une analyse peut **proposer** une Card (Brouillon) |
| **Quote Extraction** | Quote Extraction → Knowledge | un import peut **proposer** un savoir (Brouillon) |
| **Planning** | Knowledge → Planning | fournit durées/étapes-type (lecture) |
| **Notification** | Knowledge → Notification | `BestPracticeValidated` peut déclencher une notification |

## Conformité (STEP 1–8)
- Propriété/versionnement/validation = fiches gelées + VERSIONING_POLICY. ✅
- Intégrations = **documentaires** ; renvoient aux Contracts STEP 5. ✅
- Interdits (écrire Mission, calculer un montant) rappelés. ✅

## Related Documents
[KNOWLEDGE_LEARNING.md](KNOWLEDGE_LEARNING.md) · [../ENGINE_DEPENDENCIES.md](../ENGINE_DEPENDENCIES.md)

## Next Reading
[KNOWLEDGE_LEARNING.md](KNOWLEDGE_LEARNING.md)

## Changelog
- 1.0 (2026-08-02) — Gouvernance & intégration initiales.
