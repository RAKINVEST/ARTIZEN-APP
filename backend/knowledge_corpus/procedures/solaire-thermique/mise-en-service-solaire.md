# Mise en service d'une installation solaire

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mise-en-service-solaire` |
| Titre | Mise en service d'une installation solaire |
| Profession | `metier:solaire-thermique` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:solaire-thermique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Mettre en service le circuit solaire en sécurité (remplissage, purge, pression, contrôles). `[C]`

## Étapes
1. **Rincer** le circuit ; remplir en **fluide caloporteur** (concentration selon climat). `[C]` ⟦à confirmer⟧
2. **Purger** l'air ; régler la **pression** (vase/soupape). `[C]` → [raccorder-circuit-primaire](../../professions/solaire-thermique/cards/raccorder-circuit-primaire.md)
3. Régler la **régulation** (sondes/différentiel) ; vérifier le circulateur. `[C]` → [regler-regulation-solaire](../../professions/solaire-thermique/cards/regler-regulation-solaire.md)
4. Contrôler montée en température / sécurités surchauffe. `[C]`

> Éviter la mise en eau des capteurs en plein soleil (choc thermique) ; risque de **brûlure/pression**. `[A]`

## Cadre
- **Normes** : installations de capteurs solaires à circulation de liquide **DTU 65.12** ; électricité de la régulation/circulateur **NF C 15-100** ; capteurs **NF EN 12975**, systèmes **NF EN 12976**, certification **Solar Keymark** / label **RGE QualiSol** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [entretenir-controler-solaire](../../professions/solaire-thermique/cards/entretenir-controler-solaire.md).
- **Tags** : `metier:solaire-thermique famille:fluides sous-famille:solaire-thermique intervention:controler cluster:regulation cluster:fluide-caloporteur cluster:controle type:procedure securite:brulure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
