# Contrôle / maintenance ferronnerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-ferronnerie` |
| Titre | Contrôle / maintenance ferronnerie |
| Profession | `metier:ferronnerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ferronnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Assemblages** (soudures/rivets/colliers) sains, pas de jeu. `[C]`
- [ ] **Corrosion** : points de rouille, rétentions d'eau. `[C]`
- [ ] **Protection / patine** : état, reprise éventuelle. `[C]`
- [ ] **Garde-corps / rampe** : **tenue** et sécurité (NF P01-012). `[A]`
- [ ] **Scellements/fixations** à la pose : contrôlés. `[C]`
- [ ] Interfaces (motorisation/vitrage/contrôle d'accès) = métiers distincts ; restauration : **amiante/plomb**. `[A]`

## Cadre
- **Normes** : ouvrages métalliques (mise en œuvre, **interface** métallerie) **DTU 37.1** ; garde-corps **NF P01-012** ; exécution des structures acier **NF EN 1090**, qualification de soudage **NF EN ISO 9606**, protection anticorrosion **NF EN ISO 12944** ; motorisation éventuelle d'un portail (**interface** Électricité) **NF C 15-100** ⟦EN 1090 / EN ISO 9606 / ISO 12944 et versions exactes en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [poser-restaurer-ouvrage](../../professions/ferronnerie/cards/poser-restaurer-ouvrage.md).
- **Tags** : `metier:ferronnerie famille:specialises sous-famille:ferronnerie type:checklist cluster:anticorrosion cluster:garde-corps securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
