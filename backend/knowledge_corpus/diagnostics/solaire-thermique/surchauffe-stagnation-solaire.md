# Surchauffe / stagnation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `surchauffe-stagnation-solaire` |
| Titre | Surchauffe / stagnation |
| Profession | `metier:solaire-thermique` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:solaire-thermique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Surchauffe** du circuit, **stagnation** (capteurs très chauds sans puisage), soupape qui crache. `[C]`

> Circuit **brûlant et sous pression** → ne pas ouvrir/intervenir à chaud ; **refroidir** d'abord. `[A]`

## Causes probables
1. **Absence de puisage** en été (surproduction). `[C]` → [gerer-surchauffe-antigel](../../professions/solaire-thermique/cards/gerer-surchauffe-antigel.md)
2. **Vase/soupape** sous-dimensionnés ou HS. `[C]` → [raccorder-circuit-primaire](../../professions/solaire-thermique/cards/raccorder-circuit-primaire.md)
3. Circulateur/régulation défaillants. `[C]`

## Résolution
- **Refroidir**, rétablir les protections (vase/soupape/dissipation), contrôler le fluide (dégradé par surchauffe). `[A]`

## Cadre
- **Normes** : installations de capteurs solaires à circulation de liquide **DTU 65.12** ; électricité de la régulation/circulateur **NF C 15-100** ; capteurs **NF EN 12975**, systèmes **NF EN 12976**, certification **Solar Keymark** / label **RGE QualiSol** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [remplacer-fluide-caloporteur](../../professions/solaire-thermique/cards/remplacer-fluide-caloporteur.md).
- **Tags** : `metier:solaire-thermique famille:fluides sous-famille:solaire-thermique probleme:surchauffe cluster:protection-contre-la-surchauffe cluster:diagnostic type:diagnostic securite:brulure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
