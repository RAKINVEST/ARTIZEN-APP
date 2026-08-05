# Intégrer l'évier et l'électroménager (interfaces)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `integrer-evier-electromenager` |
| Titre | Intégrer l'évier et l'électroménager (interfaces) |
| Profession | `metier:cuisine` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:cuisine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser/encastrer l'**évier** et l'**électroménager** — les **raccordements** eau et électrique sont des **interfaces** (Livres dédiés). `[C]`
- **Résumé** : poser l'évier dans la découpe (étanchéité au plan), présenter la **robinetterie**, et **encastrer** l'électroménager (four/plaque/lave-vaisselle/hotte) en respectant les **jeux de ventilation** ; le **raccordement eau/évacuation** relève de la **Plomberie**, le **raccordement électrique** (circuits spécialisés) de l'**Électricité** — **non traités ici**. `[C]` ⟦jeux de ventilation/encastrement selon appareil à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser l'évier (étanchéité au plan) ; présenter la robinetterie. `[C]`
  2. **Raccordement eau/évacuation** = **Plomberie** (interface). `[C]` → [poser-mitigeur-evier](../../../professions/plomberie/cards/poser-mitigeur-evier.md)
  3. **Encastrer** l'électroménager (jeux de **ventilation**). `[C]`
  4. **Raccordement électrique** = **Électricité** (réservé). `[C]` → [remplacer-prise-courant](../../../professions/electricite-generale/cards/remplacer-prise-courant.md)
- **Points critiques** : étanchéité de l'évier ; **jeux de ventilation** (four/hotte ; gaz) ; **raccordements = interfaces** (Plomberie/Élec), jamais improvisés.
- **Sécurité** : eau (interface plomberie) ; électrique (interface) ; ventilation (appareils). **Manutention des plans de travail** (lourds, surtout **pierre/quartz**) : ventouses/binôme/levage — écrasement/dos. **Découpes** : **stratifié/bois** (poussières de bois cancérogènes → aspiration), **pierre/quartz** (poussières de **silice** → coupe à l'eau/aspiration, masque). **Machines électroportatives** : capots/contrôle. **Repérage des réseaux avant percement** (fixation des meubles hauts, découpe du plan) : repérer/consigner élec/eau/gaz — ne pas percer un câble/tube. **Risques électriques** : le **raccordement électrique** de l'électroménager (circuits spécialisés) est **réservé à un électricien** → voir Électricité ; ici, seule la **pose/l'encastrement**. **Raccordements eau / évacuation** de l'évier : **interface** → le raccordement détaillé relève de la **Plomberie**. **Ventilation des appareils** (hotte/four ; table **gaz** = évacuation/ventilation adaptée). **Amiante** (ouvrages anciens) : diagnostic ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : meubles / caissons (menuiserie intérieure) **DTU 36.2** ; électricité de la cuisine (circuits spécialisés, **interface**) **NF C 15-100** ; plomberie évier / robinetterie (**interface**) **DTU 60.1** ; diagnostic **amiante** (ouvrages anciens) et **ventilation** des appareils ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Réglage des façades** : `cite-carte` → [regler-facades-quincaillerie](regler-facades-quincaillerie.md)

## Relations & tags
- **Tags** : `metier:cuisine famille:finition sous-famille:cuisine intervention:realiser cluster:evier cluster:robinetterie cluster:electromenager-encastre complexite:avancee type:installation securite:electrique relation:plomberie relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
