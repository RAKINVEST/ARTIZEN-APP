# Kit de diagnostic charpente (inspection, pas application)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-diagnostic-charpente` |
| Titre | Kit de diagnostic charpente (inspection, pas application) |
| Profession | `metier:traitement-charpente` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:traitement-charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée (**inspection / diagnostic** — pas d'application de biocides)
- **Humidimètre** (bois), **poinçon/tournevis** de sondage, **lampe**, appareil photo, miroir d'inspection. `[C]`
- Loupe, fiches d'identification (xylophages/champignons), règle, marqueurs de zones. `[C]`
- **EPI** : masque **poussière de bois**, gants, lunettes, **harnais** (combles/hauteur), éclairage. `[A]`

> **Ce kit ne contient aucun matériel d'application de biocides** (injecteurs, pulvérisateurs pro) : l'application relève d'un **applicateur qualifié** (Certibiocide). `[A]`

## Cadre
- **Normes** : charpente / structure bois traitée (**interface** charpente) **DTU 31.1** ; humidité / remédiation du bâti (**interface** maçonnerie) **DTU 20.1** ; classes d'emploi / risque biologique **NF EN 335**, durabilité **NF EN 350**, efficacité des produits de préservation **NF EN 599**, diagnostic **termites** (Code de la construction, déclaration en mairie), **mérule** (obligation d'information) et **Règlement Biocides UE 528/2012 / Certibiocide** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [inspecter-surveiller-charpente](../../professions/traitement-charpente/cards/inspecter-surveiller-charpente.md).
- **Tags** : `metier:traitement-charpente famille:specialises sous-famille:traitement-charpente type:kit cluster:inspection cluster:diagnostic equipement:humidimetre`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
