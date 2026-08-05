# Poser une crédence

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-credence` |
| Titre | Poser une crédence |
| Profession | `metier:cuisine` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:cuisine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser une **crédence** (protection murale entre plan et meubles hauts) avec ses découpes (prises). `[C]`
- **Résumé** : choisir la crédence (stratifié, verre, inox, panneau) et la poser (collée/fixée) entre le plan et les meubles hauts, en réalisant les **découpes** (prises, sorties) — dont l'appareillage électrique relève de l'**Électricité** — et en étanchéifiant la jonction avec le plan (joint souple). `[C]` ⟦matériau/fixation selon crédence à confirmer⟧

## Réalisation
- **Étapes** :
  1. Choisir la crédence ; préparer le support. `[C]`
  2. Poser (collée/fixée) ; **découpes** (prises). `[C]` → [remplacer-prise-courant](../../../professions/electricite-generale/cards/remplacer-prise-courant.md)
  3. Étanchéifier la jonction plan/crédence (joint souple). `[C]`
  4. Contrôler l'aspect/les raccords. `[C]` → [poser-plan-travail](poser-plan-travail.md)
- **Points critiques** : découpes prises (appareillage = Électricité) ; **étanchéité** plan/crédence ; jonctions soignées.
- **Sécurité** : découpes/poussières ; électricité (prises) ; — **Manutention des plans de travail** (lourds, surtout **pierre/quartz**) : ventouses/binôme/levage — écrasement/dos. **Découpes** : **stratifié/bois** (poussières de bois cancérogènes → aspiration), **pierre/quartz** (poussières de **silice** → coupe à l'eau/aspiration, masque). **Machines électroportatives** : capots/contrôle. **Repérage des réseaux avant percement** (fixation des meubles hauts, découpe du plan) : repérer/consigner élec/eau/gaz — ne pas percer un câble/tube. **Risques électriques** : le **raccordement électrique** de l'électroménager (circuits spécialisés) est **réservé à un électricien** → voir Électricité ; ici, seule la **pose/l'encastrement**. **Raccordements eau / évacuation** de l'évier : **interface** → le raccordement détaillé relève de la **Plomberie**. **Ventilation des appareils** (hotte/four ; table **gaz** = évacuation/ventilation adaptée). **Amiante** (ouvrages anciens) : diagnostic ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : meubles / caissons (menuiserie intérieure) **DTU 36.2** ; électricité de la cuisine (circuits spécialisés, **interface**) **NF C 15-100** ; plomberie évier / robinetterie (**interface**) **DTU 60.1** ; diagnostic **amiante** (ouvrages anciens) et **ventilation** des appareils ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Évier / électroménager** : `cite-carte` → [integrer-evier-electromenager](integrer-evier-electromenager.md)

## Relations & tags
- **Tags** : `metier:cuisine famille:finition sous-famille:cuisine intervention:realiser cluster:credences cluster:decoupes complexite:moyenne type:installation securite:manutention relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
