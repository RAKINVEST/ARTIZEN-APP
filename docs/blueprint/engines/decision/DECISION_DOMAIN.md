# Decision Domain — Domaine & intentions

> **Version** 1.0 — **Status** Validated — **Owner** Decision — **Last Update** 2026-08-02
> **Depends On:** [../../../knowledge/taxonomy/INTERVENTION_TYPES.md](../../../knowledge/taxonomy/INTERVENTION_TYPES.md) — **Used By:** DECISION_PIPELINE — **Niveau:** 2 · Architecture

## Objective
Décrire le domaine du moteur (le **copilote**) et la **taxonomie des intentions**.

## Le copilote
L'artisan **exprime une intention** ; Artizen **construit le reste**. Il ne cherche plus un article,
une phrase, un kit, une procédure, un diagnostic, une photo, une norme : le Decision Engine les
**assemble** et les **explique**, l'artisan **vérifie** et **envoie**.

## Taxonomie des intentions
Deux familles, **réutilisant l'existant** (pas de vocabulaire concurrent) :

### Intentions « geste » = axe `intervention:` (taxonomie gelée)
`installer` · `remplacer` · `reparer` · `diagnostiquer` · `entretenir` · `controler` (+ tout
[INTERVENTION_TYPES](../../../knowledge/taxonomy/INTERVENTION_TYPES.md)). Le Decision Engine les mappe
sur des Knowledge Cards.

### Intentions « parcours » (orchestration)
| Intention | Résultat proposé (sur validation) | Moteur propriétaire |
|---|---|---|
| Créer un devis | devis pré-rempli (lignes, kits, phrases) | Quote |
| Créer une facture | facture proposée | Billing |
| Planifier | créneau/tâche proposés | Planning |
| Commander | besoins de stock/fournisseur | Stock / Supplier |
| Relancer | relance proposée | Notification |
| Photographier | photos attendues listées | Media/Photo |
| Clôturer | clôture de mission proposée | Mission |
| Garantir | garantie associée proposée | Warranty |

## Règle
Une intention **ne crée rien** directement : elle produit une **proposition** ; la création reste un
**geste explicite** exécuté par le moteur propriétaire (Loi 7/18, invariant CLAUDE.md #1).

## Conformité
Intentions « geste » = axe `intervention:` gelé (aucune taxonomie nouvelle). Intentions « parcours »
= orchestration de moteurs existants (aucun nouveau moteur). ✅

## Changelog
- 1.0 (2026-08-02) — Domaine & intentions initiaux.
