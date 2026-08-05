# Robinet qui goutte

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `robinet-qui-goutte` |
| Titre | Robinet qui goutte |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Écoulement goutte-à-goutte au bec **robinet fermé**, ou suintement à la base de la manette. `[C]`

## Causes probables
1. Cartouche/tête céramique **usée** (mitigeur). `[C]` → [remplacer-cartouche-mitigeur](../../professions/plomberie/cards/remplacer-cartouche-mitigeur.md)
2. Joint/clapet de tête durci (robinet à tête classique). `[C]`
3. Portée de siège piquée par le calcaire. `[C]`

## Démarche de diagnostic
- Fermer les arrêts et observer : goutte au bec = organe de coupure ; fuite base = joint de corps. `[C]`
- Identifier le type (mitigeur monocommande vs mélangeur à têtes). `[C]`

## Résolution
- Mitigeur : remplacer la cartouche. → [remplacer-cartouche-mitigeur](../../professions/plomberie/cards/remplacer-cartouche-mitigeur.md)
- Robinet neuf si corps piqué. → [poser-mitigeur-evier](../../professions/plomberie/cards/poser-mitigeur-evier.md)

## Cadre
- **Normes** : installation sanitaire — **DTU 60.1** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` (résolu par les cartes ci-dessus).
- **Tags** : `metier:plomberie famille:fluides probleme:fuite probleme:usure equipement:mitigeur equipement:robinet type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-03 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
