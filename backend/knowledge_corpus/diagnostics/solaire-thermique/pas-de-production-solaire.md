# Pas de production solaire (ECS)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `pas-de-production-solaire` |
| Titre | Pas de production solaire (ECS) |
| Profession | `metier:solaire-thermique` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:solaire-thermique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Le solaire **ne chauffe plus** le ballon malgré l'ensoleillement (appoint qui tourne). `[C]`

## Causes probables
1. **Circulateur** arrêté / régulation mal réglée ou HS. `[C]` → [regler-regulation-solaire](../../professions/solaire-thermique/cards/regler-regulation-solaire.md)
2. **Air** dans le circuit / pression basse (fuite). `[C]` → [fuite-baisse-pression-primaire](fuite-baisse-pression-primaire.md)
3. **Fluide dégradé** / échangeur entartré. `[C]` → [remplacer-fluide-caloporteur](../../professions/solaire-thermique/cards/remplacer-fluide-caloporteur.md)

## Résolution
- Vérifier circulateur/régulation/pression, purger l'air, contrôler le fluide ; remettre en service. `[C]`

## Cadre
- **Normes** : installations de capteurs solaires à circulation de liquide **DTU 65.12** ; électricité de la régulation/circulateur **NF C 15-100** ; capteurs **NF EN 12975**, systèmes **NF EN 12976**, certification **Solar Keymark** / label **RGE QualiSol** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-controler-solaire](../../professions/solaire-thermique/cards/entretenir-controler-solaire.md).
- **Tags** : `metier:solaire-thermique famille:fluides sous-famille:solaire-thermique probleme:panne cluster:circulateurs cluster:regulation cluster:diagnostic type:diagnostic securite:brulure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
