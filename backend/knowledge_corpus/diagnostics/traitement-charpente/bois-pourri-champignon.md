# Bois pourri / champignon (mérule)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `bois-pourri-champignon` |
| Titre | Bois pourri / champignon (mérule) |
| Profession | `metier:traitement-charpente` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:traitement-charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Bois **mou/noirci**, **pourriture cubique**, filaments blancs/fructifications rouille, odeur de champignon. `[C]`

> **Mérule** possible : champignon qui se **propage** (bois + maçonnerie), obligation d'information → professionnel spécialisé. `[A]`

## Causes probables
1. **Humidité** persistante (infiltration/remontées/ventilation). `[A]` → [comprendre-role-humidite](../../professions/traitement-charpente/cards/comprendre-role-humidite.md)
2. **Champignons lignivores** / mérule. `[C]` → [identifier-champignons-merule](../../professions/traitement-charpente/cards/identifier-champignons-merule.md)
3. Bois de classe d'emploi inadaptée. `[C]`

## Conduite à tenir
- **Traiter la source d'humidité d'abord**, évaluer l'atteinte structurelle (Charpentier), recours spécialisé pour la mérule. `[A]`

## Cadre
- **Normes** : charpente / structure bois traitée (**interface** charpente) **DTU 31.1** ; humidité / remédiation du bâti (**interface** maçonnerie) **DTU 20.1** ; classes d'emploi / risque biologique **NF EN 335**, durabilité **NF EN 350**, efficacité des produits de préservation **NF EN 599**, diagnostic **termites** (Code de la construction, déclaration en mairie), **mérule** (obligation d'information) et **Règlement Biocides UE 528/2012 / Certibiocide** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [identifier-champignons-merule](../../professions/traitement-charpente/cards/identifier-champignons-merule.md).
- **Tags** : `metier:traitement-charpente famille:specialises sous-famille:traitement-charpente probleme:champignon cluster:champignons-lignivores cluster:diagnostic type:diagnostic securite:biocides relation:maconnerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
