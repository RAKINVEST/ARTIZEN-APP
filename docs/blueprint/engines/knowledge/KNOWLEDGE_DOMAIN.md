# Knowledge Domain — Le domaine du savoir

> **Version** 1.0 — **Status** Validated — **Owner** Knowledge — **Last Update** 2026-08-02
> **Depends On:** [../../domain/objects/Knowledge.md](../../domain/objects/Knowledge.md) — **Used By:** KNOWLEDGE_OBJECTS, KNOWLEDGE_VIEWS — **Niveau:** 2 · Architecture

## Objective
Décrire le **domaine métier** couvert par le moteur, en s'appuyant sur l'objet `Knowledge` **gelé**.

## Le savoir capitalisé (Loi 10 — patrimoine technique)
Le domaine du Knowledge Engine est la **mémoire technique** de l'entreprise : ce qu'un artisan
apprend en faisant, et qui doit servir la prochaine fois. L'objet `Knowledge` en est l'unité :
une **fiche d'expérience**, une **bonne pratique**, une **erreur à éviter**, une **variante**.

## La Knowledge Card = l'objet `Knowledge`
La « Knowledge Card » de cette spécification **n'est pas un nouvel objet** : c'est la **projection
lisible de l'objet `Knowledge` existant**. Une Card représente **une opération métier** (un savoir-faire
sur une intervention/mission), **jamais un produit** (le produit vit dans `Catalog`/`Article`).

## Ce que la Card porte (attributs de l'objet `Knowledge`, inchangés)
- Identité : `id` (UUID), propriétaire `Company` (tenant).
- Nature : fiche d'expérience / bonne pratique / erreur à éviter / variante.
- **Visibility** (valeur métier gelée de l'objet) : portée de visibilité de la fiche.
- Références **par id** vers le contexte : `Mission`, `Intervention`, `Photo`, `Document` (voir RELATIONS).
- Pièces jointes : `Media` (objet utilisé par le moteur).
- Cycle de vie : **Brouillon → Validé → Archivé** ; **append-only** (Loi 5).

## Frontière avec les objets voisins (aucun empiètement)
| Voisin | Différence |
|---|---|
| `Phrase` (Business Library) | texte réutilisable (garantie, mention) — **pas** un savoir d'expérience |
| `Article`/`Kit` (Catalog) | un **produit/prestation** vendable — la Card décrit **l'opération**, pas le produit |
| `Report` | un compte rendu ponctuel — la Card est **capitalisée et réutilisable** |
| `Mission`/`Intervention` | l'exécution réelle — la Card en **tire** le savoir, sans les écrire |

## Conformité (STEP 1–8)
- Aucun objet créé ; `Knowledge` (STEP 2) repris tel quel. ✅
- Distinctions ci-dessus alignées sur les fiches gelées `Phrase`, `Article`, `Report`. ✅
- Loi 10 (patrimoine), Loi 5 (append-only) respectées. ✅

## Related Documents
[KNOWLEDGE_OBJECTS.md](KNOWLEDGE_OBJECTS.md) · [KNOWLEDGE_GOVERNANCE.md](KNOWLEDGE_GOVERNANCE.md)

## Next Reading
[KNOWLEDGE_OBJECTS.md](KNOWLEDGE_OBJECTS.md)

## Changelog
- 1.0 (2026-08-02) — Spécification initiale.
