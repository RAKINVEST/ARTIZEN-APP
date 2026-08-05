# Défaut d'isolement / arc DC

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `defaut-isolement-arc-dc` |
| Titre | Défaut d'isolement / arc DC |
| Profession | `metier:photovoltaique` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:photovoltaique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Défaut d'isolement** signalé par l'onduleur, trace de **brûlure**/arc à la connectique, odeur. `[C]`

> **DANGER : arc DC auto-entretenu + risque d'incendie.** Ne pas débrancher à chaud ; sécuriser ; intervention **habilitée**. `[A]`

## Causes probables
1. **Connectique** DC dégradée / non compatible / mal sertie. `[C]` → [cabler-chaines-dc](../../professions/photovoltaique/cards/cabler-chaines-dc.md)
2. Câble endommagé / entrée d'eau / isolement dégradé. `[C]`
3. Mise à la terre/équipotentialité défaillante. `[C]` → [poser-modules-toiture](../../professions/photovoltaique/cards/poser-modules-toiture.md)

## Résolution
- **Sécuriser** (couper l'AC, appliquer la procédure DC), diagnostiquer l'isolement, reprendre la connectique — par un **professionnel habilité**. `[A]` → [consignation-securite-dc-pv](../../procedures/photovoltaique/consignation-securite-dc-pv.md)

## Cadre
- **Normes** : installations photovoltaïques raccordées au réseau **NF C 15-712-1** ; installation électrique BT (raccordement AC) **NF C 15-100** ; opérations / habilitation photovoltaïque (**NF C 18-510**, habilitation **BP/BR**) ; contrôle/mise en service **IEC 62446**, attestation **Consuel**, raccordement **Enedis**, label **RGE QualiPV** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [consignation-securite-dc-pv](../../procedures/photovoltaique/consignation-securite-dc-pv.md).
- **Tags** : `metier:photovoltaique famille:electricite sous-famille:photovoltaique probleme:arc cluster:chaines-dc cluster:diagnostic type:diagnostic securite:dc securite:incendie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
