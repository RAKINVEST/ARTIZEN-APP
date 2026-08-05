# Entretenir / diagnostiquer une cuisine

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-diagnostiquer-cuisine` |
| Titre | Entretenir / diagnostiquer une cuisine |
| Profession | `metier:cuisine` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:cuisine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir une cuisine et diagnostiquer les défauts (façades, plan, fixations, joints). `[C]`
- **Résumé** : contrôler et **régler** les façades/tiroirs, vérifier l'état du **plan de travail** et des **joints** (étanchéité évier/crédence), la tenue des **fixations** (meubles hauts), lubrifier la quincaillerie, et adapter l'entretien aux matériaux ; en rénovation, **diagnostic amiante** des éléments anciens. `[C]`

## Réalisation
- **Étapes** :
  1. Régler façades/tiroirs ; lubrifier la quincaillerie. `[C]` → [facade-desalignee-charniere](../../../diagnostics/cuisine/facade-desalignee-charniere.md)
  2. Vérifier **plan/joints** (étanchéité). `[C]` → [plan-travail-degrade-joint](../../../diagnostics/cuisine/plan-travail-degrade-joint.md)
  3. Contrôler la **fixation** des meubles hauts. `[A]` → [meuble-descelle-fixation](../../../diagnostics/cuisine/meuble-descelle-fixation.md)
  4. Entretien adapté ; rénovation → **amiante**. `[C]`
- **Points critiques** : joints étanches (évier) ; fixations sûres (meubles hauts) ; quincaillerie réglée/lubrifiée ; **amiante** en rénovation.
- **Sécurité** : manutention ; eau (joints) ; amiante (rénovation). **Manutention des plans de travail** (lourds, surtout **pierre/quartz**) : ventouses/binôme/levage — écrasement/dos. **Découpes** : **stratifié/bois** (poussières de bois cancérogènes → aspiration), **pierre/quartz** (poussières de **silice** → coupe à l'eau/aspiration, masque). **Machines électroportatives** : capots/contrôle. **Repérage des réseaux avant percement** (fixation des meubles hauts, découpe du plan) : repérer/consigner élec/eau/gaz — ne pas percer un câble/tube. **Risques électriques** : le **raccordement électrique** de l'électroménager (circuits spécialisés) est **réservé à un électricien** → voir Électricité ; ici, seule la **pose/l'encastrement**. **Raccordements eau / évacuation** de l'évier : **interface** → le raccordement détaillé relève de la **Plomberie**. **Ventilation des appareils** (hotte/four ; table **gaz** = évacuation/ventilation adaptée). **Amiante** (ouvrages anciens) : diagnostic ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : meubles / caissons (menuiserie intérieure) **DTU 36.2** ; électricité de la cuisine (circuits spécialisés, **interface**) **NF C 15-100** ; plomberie évier / robinetterie (**interface**) **DTU 60.1** ; diagnostic **amiante** (ouvrages anciens) et **ventilation** des appareils ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-cuisiniste](../../../kits/cuisine/kit-cuisiniste.md)

## Relations & tags
- **Tags** : `metier:cuisine famille:finition sous-famille:cuisine intervention:entretenir intervention:controler cluster:entretien cluster:maintenance cluster:diagnostic complexite:moyenne type:entretien securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
