# Poser un plan de travail (découpes)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-plan-travail` |
| Titre | Poser un plan de travail (découpes) |
| Profession | `metier:cuisine` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:cuisine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser un **plan de travail** (stratifié, bois, pierre/quartz) et réaliser les **découpes** (évier, plaque). `[C]`
- **Résumé** : poser le plan de niveau sur les caissons, réaliser les **découpes** (évier, plaque de cuisson) selon gabarit, traiter les **chants/jonctions** (profilés, joint), étanchéifier au niveau de l'évier et de la crédence ; **pierre/quartz** = manutention lourde + coupe à l'**eau** (silice). `[C]` ⟦matériau/découpes selon plan et électroménager à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser le plan de niveau ; fixer aux caissons. `[C]`
  2. **Découper** évier/plaque (gabarit) — coupe adaptée (silice pour pierre). `[A]`
  3. Traiter **chants/jonctions** ; étanchéifier (évier/crédence). `[C]` → [plan-travail-degrade-joint](../../../diagnostics/cuisine/plan-travail-degrade-joint.md)
  4. Contrôler affleurement/planéité. `[C]`
- **Points critiques** : découpes au gabarit ; **étanchéité** (évier/crédence — le plan craint l'eau) ; jonctions ; **pierre = silice/manutention**.
- **Sécurité** : **manutention (pierre)** ; **découpe silice/bois** ; machines. **Manutention des plans de travail** (lourds, surtout **pierre/quartz**) : ventouses/binôme/levage — écrasement/dos. **Découpes** : **stratifié/bois** (poussières de bois cancérogènes → aspiration), **pierre/quartz** (poussières de **silice** → coupe à l'eau/aspiration, masque). **Machines électroportatives** : capots/contrôle. **Repérage des réseaux avant percement** (fixation des meubles hauts, découpe du plan) : repérer/consigner élec/eau/gaz — ne pas percer un câble/tube. **Risques électriques** : le **raccordement électrique** de l'électroménager (circuits spécialisés) est **réservé à un électricien** → voir Électricité ; ici, seule la **pose/l'encastrement**. **Raccordements eau / évacuation** de l'évier : **interface** → le raccordement détaillé relève de la **Plomberie**. **Ventilation des appareils** (hotte/four ; table **gaz** = évacuation/ventilation adaptée). **Amiante** (ouvrages anciens) : diagnostic ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : meubles / caissons (menuiserie intérieure) **DTU 36.2** ; électricité de la cuisine (circuits spécialisés, **interface**) **NF C 15-100** ; plomberie évier / robinetterie (**interface**) **DTU 60.1** ; diagnostic **amiante** (ouvrages anciens) et **ventilation** des appareils ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Crédence** : `cite-carte` → [poser-credence](poser-credence.md)

## Relations & tags
- **Tags** : `metier:cuisine famille:finition sous-famille:cuisine intervention:realiser cluster:plans-de-travail cluster:decoupes complexite:avancee type:installation securite:silice`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
