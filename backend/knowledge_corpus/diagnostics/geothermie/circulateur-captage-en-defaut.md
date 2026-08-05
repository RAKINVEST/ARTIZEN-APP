# Circulateur de captage en défaut

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `circulateur-captage-en-defaut` |
| Titre | Circulateur de captage en défaut |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:captage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Le circulateur du captage **bruyant** ou ne débite plus. `[C]`

## Causes probables
1. **Air** dans le circuit (cavitation). `[C]`
2. **Boues** / grippage. `[C]`
3. Circulateur usé / électrique. `[C]` → [controler-circulateur-captage](../../professions/geothermie/cards/controler-circulateur-captage.md)

## Résolution
- Purger, contrôler pression/caloporteur, remplacer si usé (raccordement électrique habilité). `[C]`

## Cadre
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [controler-circulateur-captage](../../professions/geothermie/cards/controler-circulateur-captage.md).
- **Tags** : `metier:geothermie equipement:circulateur famille:fluides sous-famille:captage probleme:bruit probleme:panne cluster:diagnostic cluster:depannage cluster:pompes-de-circulation type:diagnostic securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
