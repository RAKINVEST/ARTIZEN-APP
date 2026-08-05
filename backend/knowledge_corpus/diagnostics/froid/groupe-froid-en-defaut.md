# Groupe frigorifique en défaut

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `groupe-froid-en-defaut` |
| Titre | Groupe frigorifique en défaut |
| Profession | `metier:froid` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:froid-commercial` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Le groupe s'arrête / affiche un **défaut** (haute/basse pression, code). `[C]`

## Causes probables
1. **Condenseur** encrassé (haute pression). `[C]` → [nettoyer-condenseur](../../professions/froid/cards/nettoyer-condenseur.md)
2. Défaut électrique / pressostat. `[D]` ⟦selon installation à confirmer⟧
3. Charge / fuite → **frigoriste F-Gaz** (trace d'huile). `[D]`

## Résolution
- Contrôler condenseur/électrique accessible ; **pression/charge → frigoriste attesté**. `[C]`

## Cadre
- **Normes** : sécurité des systèmes frigorifiques **NF EN 378** ; installation électrique **NF C 15-100** ; réglementation **F-Gaz** (UE 517/2014) `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [principe-froid-commercial](../../professions/froid/cards/principe-froid-commercial.md).
- **Tags** : `metier:froid equipement:groupe-froid equipement:compresseur famille:fluides sous-famille:froid-commercial probleme:defaut probleme:pression cluster:diagnostic cluster:depannage cluster:compresseurs cluster:groupes type:diagnostic securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
