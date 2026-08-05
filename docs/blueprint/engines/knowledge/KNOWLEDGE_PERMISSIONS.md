# Knowledge Permissions — Droits & visibilité

> **Version** 1.0 — **Status** Validated — **Owner** Knowledge — **Last Update** 2026-08-02
> **Depends On:** [../../contracts/SECURITY_CONTRACTS.md](../../contracts/SECURITY_CONTRACTS.md) — **Used By:** implémentation future — **Niveau:** 2 · Architecture

## Objective
Spécifier les permissions du moteur, en réutilisant les règles gelées (tenant, gardes, visibilité).

## Isolation multi-tenant (invariant gelé)
- Tenant **Company** ; `company_id` **du contexte d'auth (JWT)**, jamais du client.
- Un accès à une Card d'une autre entreprise → **404** (jamais 403 : ne pas confirmer l'existence).
- Gardes **Authentication** + **Authorization** en amont (fiche moteur).

## Visibilité (valeur métier `Visibility` de l'objet `Knowledge`)
La Card porte une **Visibility** (attribut gelé). Elle module qui, **au sein de l'entreprise**, voit
la Card. La spécification **n'invente pas** de niveaux : les valeurs concrètes de `Visibility` seront
fixées à l'implémentation (et tout partage **inter-entreprises** relèverait d'un ADR — cf. évolution
« Bibliothèque partagée (Community) » notée sur `Phrase`, hors périmètre ici).

## Lecture par les autres moteurs
Les moteurs read-side (Decision, Companion/IA, Performance) lisent la Card **en lecture seule, via
événements/contrats** (Loi 7). Aucun n'écrit `Knowledge`.

## Écriture
- Seul le **Knowledge Engine** écrit `Knowledge`.
- La transition **Validé** exige un **acteur humain** (Loi 7/18) — aucune validation automatique.

## Conformité (STEP 1–8)
- Tenant/404/gardes = SECURITY_CONTRACTS (STEP 5) et fiche moteur (STEP 3). ✅
- `Visibility` = valeur gelée de l'objet ; niveaux non inventés. ✅

## Related Documents
[KNOWLEDGE_GOVERNANCE.md](KNOWLEDGE_GOVERNANCE.md) · [../../contracts/SECURITY_CONTRACTS.md](../../contracts/SECURITY_CONTRACTS.md)

## Next Reading
[KNOWLEDGE_GOVERNANCE.md](KNOWLEDGE_GOVERNANCE.md)

## Changelog
- 1.0 (2026-08-02) — Permissions initiales.
