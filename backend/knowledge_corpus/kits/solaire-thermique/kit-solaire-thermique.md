# Kit solaire thermique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-solaire-thermique` |
| Titre | Kit solaire thermique |
| Profession | `metier:solaire-thermique` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:solaire-thermique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- **Fluide caloporteur** (glycol) + réfractomètre (point de congélation) + testeur pH. `[C]`
- Pompe de remplissage/rinçage, manomètre, purgeurs ; calorifuge **haute température/UV**. `[C]`
- Sondes/appareil de réglage de la régulation. `[C]`
- **EPI** : antichute (toiture), gants anti-chaleur/anti-produit, lunettes. `[A]`

## Cadre
- **Normes** : installations de capteurs solaires à circulation de liquide **DTU 65.12** ; électricité de la régulation/circulateur **NF C 15-100** ; capteurs **NF EN 12975**, systèmes **NF EN 12976**, certification **Solar Keymark** / label **RGE QualiSol** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [mise-en-service-solaire](../../procedures/solaire-thermique/mise-en-service-solaire.md).
- **Tags** : `metier:solaire-thermique famille:fluides sous-famille:solaire-thermique type:kit cluster:fluide-caloporteur cluster:regulation equipement:refractometre`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
