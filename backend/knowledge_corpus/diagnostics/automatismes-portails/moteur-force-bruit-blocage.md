# Moteur qui force / bruit / point dur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `moteur-force-bruit-blocage` |
| Titre | Moteur qui force / bruit / point dur |
| Profession | `metier:automatismes-portails` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:automatismes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Moteur **qui force**, **bruit** anormal, **point dur**, portail qui n'atteint plus les butées. `[C]`

> **Consigner** avant intervention mécanique. `[A]`

## Causes probables
1. **Mécanique du portail** dure (gonds/galets/rail) → la reprise relève de la **Métallerie**. `[C]` → [poser-portail-grille-metallique](../../professions/serrurerie-metallerie/cards/poser-portail-grille-metallique.md)
2. **Crémaillère/pignon** : jeu incorrect, usure. `[C]` → [poser-motorisation-coulissant](../../professions/automatismes-portails/cards/poser-motorisation-coulissant.md)
3. **Effort** mal réglé / butées/fins de course. `[C]` → [regler-essayer-motorisation](../../professions/automatismes-portails/cards/regler-essayer-motorisation.md)

## Résolution
- Rétablir la mécanique du portail (Métallerie), corriger jeu/usure crémaillère, régler effort/fins de course, **re-tester**. `[C]`

## Cadre
- **Normes** : sécurité des portes/portails motorisés — **Directive Machines**, **marquage CE**, cellules / bords sensibles / limitation d'effort — **NF EN 12453 / NF EN 12445 / NF EN 13241** ; alimentation électrique (**interface**) **NF C 15-100** ; structure du portail (**interface** métallerie) **DTU 37.1** ⟦EN 12453/12445 et versions exactes en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-motorisation-coulissant](../../professions/automatismes-portails/cards/poser-motorisation-coulissant.md).
- **Tags** : `metier:automatismes-portails famille:specialises sous-famille:automatismes probleme:mecanique cluster:diagnostic cluster:reglages type:diagnostic securite:ecrasement relation:serrurerie-metallerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
