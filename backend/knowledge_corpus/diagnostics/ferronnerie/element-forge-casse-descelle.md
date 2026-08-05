# Élément forgé cassé / descellé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `element-forge-casse-descelle` |
| Titre | Élément forgé cassé / descellé |
| Profession | `metier:ferronnerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ferronnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Élément forgé **cassé/fissuré**, assemblage desserré, ouvrage **descellé** du support. `[C]`

> Garde-corps/rampe descellé = **danger de chute** → sécuriser. `[A]`

## Causes probables
1. **Assemblage** (soudure/rivet/collier) rompu ou fatigué. `[C]` → [assembler-souder-ouvrage](../../professions/ferronnerie/cards/assembler-souder-ouvrage.md)
2. **Scellement** dégradé (support/fixation). `[C]` → [poser-restaurer-ouvrage](../../professions/ferronnerie/cards/poser-restaurer-ouvrage.md)
3. Corrosion ayant fragilisé la section. `[C]` → [ouvrage-forge-corrode](ouvrage-forge-corrode.md)

## Résolution
- Reprendre l'assemblage (soudure/rivetage), refaire le scellement, remplacer l'élément forgé à l'identique ; contrôler la sécurité (garde-corps).

## Cadre
- **Normes** : ouvrages métalliques (mise en œuvre, **interface** métallerie) **DTU 37.1** ; garde-corps **NF P01-012** ; exécution des structures acier **NF EN 1090**, qualification de soudage **NF EN ISO 9606**, protection anticorrosion **NF EN ISO 12944** ; motorisation éventuelle d'un portail (**interface** Électricité) **NF C 15-100** ⟦EN 1090 / EN ISO 9606 / ISO 12944 et versions exactes en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [assembler-souder-ouvrage](../../professions/ferronnerie/cards/assembler-souder-ouvrage.md).
- **Tags** : `metier:ferronnerie famille:specialises sous-famille:ferronnerie probleme:casse cluster:assemblage-traditionnel cluster:diagnostic type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
