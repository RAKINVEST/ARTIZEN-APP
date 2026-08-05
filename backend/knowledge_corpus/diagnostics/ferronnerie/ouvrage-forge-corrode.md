# Ouvrage forgé corrodé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `ouvrage-forge-corrode` |
| Titre | Ouvrage forgé corrodé |
| Profession | `metier:ferronnerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ferronnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Rouille**, feuilletage, cloquage de la patine/peinture, corrosion aux assemblages. `[C]`

## Causes probables
1. **Protection anticorrosion** vieillie/absente. `[C]` → [proteger-patiner-finir](../../professions/ferronnerie/cards/proteger-patiner-finir.md)
2. **Rétention d'eau** (formes fermées, soudures non protégées). `[C]`
3. Ouvrage ancien exposé (restauration). `[C]` → [poser-restaurer-ouvrage](../../professions/ferronnerie/cards/poser-restaurer-ouvrage.md)

## Résolution
- Décaper/brosser, traiter (convertisseur/apprêt), reprendre la **protection + patine** ; éliminer les rétentions d'eau.

> Revêtement **ancien** (peinture au plomb / mastic amianté) : diagnostic avant décapage. `[A]`

## Cadre
- **Normes** : ouvrages métalliques (mise en œuvre, **interface** métallerie) **DTU 37.1** ; garde-corps **NF P01-012** ; exécution des structures acier **NF EN 1090**, qualification de soudage **NF EN ISO 9606**, protection anticorrosion **NF EN ISO 12944** ; motorisation éventuelle d'un portail (**interface** Électricité) **NF C 15-100** ⟦EN 1090 / EN ISO 9606 / ISO 12944 et versions exactes en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [proteger-patiner-finir](../../professions/ferronnerie/cards/proteger-patiner-finir.md).
- **Tags** : `metier:ferronnerie famille:specialises sous-famille:ferronnerie probleme:corrosion cluster:anticorrosion cluster:diagnostic type:diagnostic securite:produits-chimiques`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
