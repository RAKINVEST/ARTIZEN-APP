# Contrôle de réception d'enrobés

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-reception-enrobes` |
| Titre | Contrôle de réception d'enrobés |
| Profession | `metier:enrobes` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:enrobes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Épaisseur** des couches conforme. `[C]`
- [ ] **Compacité** atteinte (contrôle). `[C]`
- [ ] **Uni** (règle/régularité) sans flaches/bosses. `[C]`
- [ ] **Pentes / écoulement** vers caniveaux (VRD). `[C]`
- [ ] **Joints** soignés (étanches, sans arrachement). `[C]`
- [ ] Surface sans **ressuage**/plumage ; adhérence correcte. `[C]`

> Chantier sous trafic : **signalisation** en place ; compacteurs balisés ; enrobé chaud = **brûlures/fumées**.

## Cadre
- **Normes** : support/plateforme **DTU 12** ; voirie légère en béton (dallage) **DTU 13.3** ; enrobés hydrocarbonés **NF P 98-150** / mélanges bitumineux **NF EN 13108** et signalisation temporaire (**IISR 8e partie**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [entretenir-controler-voirie](../../professions/enrobes/cards/entretenir-controler-voirie.md).
- **Tags** : `metier:enrobes famille:gros-oeuvre sous-famille:enrobes type:checklist cluster:controle cluster:compactage cluster:joints securite:trafic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
