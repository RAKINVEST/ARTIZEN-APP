# Engineering Guide — Vue d'ensemble

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** tout contributeur — **Niveau:** 3 · Implémentation

## Objective
Poser l'esprit et la règle d'or de l'ingénierie Artizen : **le code applique l'architecture, il ne la crée jamais.**

## Les 5 obligations de tout développement
1. respecter le **Blueprint** ;
2. respecter le **Domain Model** (Step 2) ;
3. respecter les **Engine Specifications** (Step 3) ;
4. respecter les **Business Flows** (Step 4) ;
5. respecter les **Contracts** (Step 5).

## Règle de réutilisation (avant toute implémentation)
Le contributeur **démontre** qu'il n'existe pas déjà :
- un **moteur** qui répond au besoin ;
- un **objet métier** équivalent ;
- un **contrat** équivalent ;
- un **événement** équivalent ;
- une **API** équivalente.

Si une solution existe → **l'étendre**, jamais la dupliquer (Loi 1/11). *(« Deuxième consommateur = signal d'infrastructure » : n'extraire un helper que lorsqu'un second module en a besoin — jamais par anticipation.)*

## Principe produit qui prime
*Build Product, Not Infrastructure* (Décision 9) + test des 10 ans : une architecture qui devrait être réécrite dans 10 ans est rejetée (Loi 17).

## Deux langues (rappel gelé)
Documentation du dépôt en **français**, commentaires de code en **anglais**. Aucun terme d'ingénierie face à l'artisan (à l'écran).

## Acceptance Criteria
Tout contributeur connaît les 5 obligations et applique la règle de réutilisation.

## Related Documents
[ARCHITECTURE_RULES.md](ARCHITECTURE_RULES.md) · [../constitution/README.md](../constitution/README.md)

## Next Reading
[CODING_STANDARDS.md](CODING_STANDARDS.md)

## Changelog
- 1.0 (2026-08-02) — Guide initial.
