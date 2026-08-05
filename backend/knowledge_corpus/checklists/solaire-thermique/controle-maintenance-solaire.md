# Contrôle / maintenance solaire thermique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-solaire` |
| Titre | Contrôle / maintenance solaire thermique |
| Profession | `metier:solaire-thermique` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:solaire-thermique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Pression** du circuit + **vase d'expansion** OK. `[C]`
- [ ] **Fluide caloporteur** : antigel/pH corrects (non dégradé). `[C]`
- [ ] **Capteurs** propres/intègres ; fixations/étanchéité toiture. `[C]`
- [ ] **Circulateur / régulation** fonctionnels (différentiel). `[C]`
- [ ] **Protections** surchauffe (soupape) et antigel vérifiées. `[C]`
- [ ] **Appoint** coordonné ; ECS à bonne température (anti-brûlure). `[C]`

> Toiture : **protections/EPI** ; circuit **chaud/pression** : refroidir avant intervention.

## Cadre
- **Normes** : installations de capteurs solaires à circulation de liquide **DTU 65.12** ; électricité de la régulation/circulateur **NF C 15-100** ; capteurs **NF EN 12975**, systèmes **NF EN 12976**, certification **Solar Keymark** / label **RGE QualiSol** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [entretenir-controler-solaire](../../professions/solaire-thermique/cards/entretenir-controler-solaire.md).
- **Tags** : `metier:solaire-thermique famille:fluides sous-famille:solaire-thermique type:checklist cluster:controle cluster:maintenance cluster:protection-antigel securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
