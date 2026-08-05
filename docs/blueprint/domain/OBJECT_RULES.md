# Object Rules — Invariants & règles métier

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [OBJECT_LIFECYCLE.md](OBJECT_LIFECYCLE.md) — **Used By:** engines, contracts — **Niveau:** 2 · Architecture

## Objective
Rassembler les **invariants** (règles toujours vraies) et les règles transverses de validation, d'historisation et de permissions. Un invariant est non négociable : le code futur doit le garantir.

## Invariants par objet (les majeurs)
| Objet | Invariant |
|---|---|
| Company | Racine de tenant ; tout objet métier appartient à exactement une Company. |
| User | Rattaché à une seule Company ; ses droits viennent de son Role, jamais du client. |
| Customer | Un carnet unique par client ; jamais dupliqué. |
| Article | Prix et unité toujours définis ; désactivation en soft-delete (les devis passés restent intacts). |
| Kit / Intervention | Peuvent être **vides** ; ne calculent aucun montant ; référencent par id. |
| **Mission** | États en avant seulement ; une Mission `Terminée` ne revient jamais en brouillon. |
| **Quote** | `Draft` seul est modifiable/supprimable ; un devis **signé** devient immuable. |
| **Invoice** | Une facture **validée ne peut plus être modifiée** ; correction uniquement par avoir. |
| PurchaseOrder | Une commande envoyée ne se modifie plus ; on l'annule/recrée. |
| Knowledge | Append-only : une fiche validée s'archive/remplace, ne se détruit pas (Loi 5). |
| Document/Photo | Les octets ne changent pas après stockage ; une nouvelle version = nouvel objet. |
| Event/History/Audit | **Immuables et append-only** ; jamais modifiés ni supprimés. |
| Performance/Report | Aucune écriture cœur ; toute métrique est explicable (Loi 6). |
| Warranty | La date de fin ne recule jamais ; l'expiration déclenche une alerte **avant** (jamais après). |

## Validation (transverse)
- Un objet invalide n'est jamais persisté : les invariants sont vérifiés à la création et à chaque transition.
- Aucune donnée n'est **inventée** pour satisfaire une contrainte (cf. moteur d'import : le document est la seule vérité).

## Historisation (transverse, Loi 4/5)
- Toute création, modification et transition produit une entrée d'**History** (date, utilisateur, action, commentaire) et, si structurant, un **Event**.
- L'historique est append-only et consultable à tout moment.

## Permissions (transverse)
- `company_id` provient toujours du contexte d'authentification, jamais du client.
- Un mismatch de tenant renvoie « introuvable », jamais « interdit » (ne pas confirmer l'existence d'une ressource d'un autre tenant).
- La visibilité (Privé/Entreprise/Groupe/Public) conditionne le partage (Vol.7).

## Règle d'or (Constitution, Loi 7/18)
Aucune intelligence (règle, statistique, IA) ne **modifie** un objet sans validation de l'artisan. Les moteurs **proposent** ; l'utilisateur **décide**.

## Constraints
Un invariant ne se contourne pas : le modifier exige un **ADR** ([DOMAIN_ANTI_PATTERNS.md](DOMAIN_ANTI_PATTERNS.md)).

## Acceptance Criteria
Chaque objet à cycle commercial a ses invariants d'immutabilité ; validation, historisation et permissions sont couvertes.

## Related Documents
[OBJECT_LIFECYCLE.md](OBJECT_LIFECYCLE.md) · [DOMAIN_ANTI_PATTERNS.md](DOMAIN_ANTI_PATTERNS.md)

## Next Reading
[DOMAIN_GLOSSARY.md](DOMAIN_GLOSSARY.md)

## Changelog
- 1.0 (2026-08-02) — Invariants majeurs initiaux.
