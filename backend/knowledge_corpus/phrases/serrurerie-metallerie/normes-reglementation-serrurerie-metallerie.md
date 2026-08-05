# Phrase — normes & réglementation serrurerie/métallerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-serrurerie-metallerie` |
| Titre | Phrase — normes & réglementation serrurerie/métallerie |
| Profession | `metier:serrurerie-metallerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:serrurerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos ouvrages respectent les règles de l'art : menuiseries métalliques (**DTU 37.1**), garde-corps **anti-chute** (**NF P01-012**) et sécurité anti-effraction (serrures/cylindres **EN 12209 / EN 1303**, blocs-portes **EN 1627** / certification **A2P**). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Frontières** : le **verrouillage mécanique** (serrurerie) n'est **pas** du **contrôle d'accès** électronique (Livre existant) ; la **ferronnerie d'art**, les **automatismes de portail** et la **vitrerie** sont des **activités distinctes** (non encore construites) — jamais absorbées. `[C]`

> **Interfaces réservées** : tout **raccordement électrique** (gâche/serrure électrique, motorisation) relève de l'**Électricité** ; le **retrait d'amiante** (→ Désamiantage) n'est **jamais réalisé ici**. `[C]`

## Cadre
- **Normes** : menuiseries métalliques / ouvrages de métallerie **DTU 37.1** ; électricité (gâche / serrure électrique, **interface**) **NF C 15-100** ; garde-corps **NF P01-012**, serrures / cylindres / anti-effraction **EN 12209 / EN 1303 / EN 1627** et certification **A2P** (CNPP), issues de secours **EN 179 / EN 1125** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [poser-organe-verrouillage](../../professions/controle-acces/cards/poser-organe-verrouillage.md).
- **Tags** : `metier:serrurerie-metallerie famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:controle-acces relation:ferronnerie relation:automatismes-portails relation:vitrerie relation:electricite-generale relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
