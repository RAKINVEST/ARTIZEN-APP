# Principe de la pose de cuisine (implantation)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-cuisine` |
| Titre | Principe de la pose de cuisine (implantation) |
| Profession | `metier:cuisine` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:cuisine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre l'**implantation** d'une cuisine et l'ordre de pose (caissons → plan → évier/électroménager → façades). `[C]`
- **Résumé** : poser une cuisine, c'est **implanter** les meubles selon l'ergonomie (**triangle** évier/cuisson/froid) et les arrivées (eau/évacuation/élec/gaz déjà en place), puis assembler **caissons** (bas/hauts), **plan de travail**, **crédence**, intégrer **évier** et **électroménager** (raccordements = **interfaces** Plomberie/Électricité) et régler les **façades**. `[C]` ⟦implantation/arrivées selon plans à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Implanter** (triangle d'activité, arrivées existantes). `[C]` → [implanter-poser-caissons](implanter-poser-caissons.md)
  2. **Plan de travail** + **crédence**. `[C]` → [poser-plan-travail](poser-plan-travail.md)
  3. **Évier / électroménager** (raccordements = interfaces). `[C]` → [integrer-evier-electromenager](integrer-evier-electromenager.md)
  4. **Réglage des façades**. `[C]` → [regler-facades-quincaillerie](regler-facades-quincaillerie.md)
- **Points critiques** : implantation ergonomique ; arrivées **vérifiées** (réalisées par Plomberie/Élec) ; ordre de pose ; **raccordements = interfaces**.
- **Sécurité** : manutention (plans) ; découpes/poussières ; électrique/eau (interfaces). **Manutention des plans de travail** (lourds, surtout **pierre/quartz**) : ventouses/binôme/levage — écrasement/dos. **Découpes** : **stratifié/bois** (poussières de bois cancérogènes → aspiration), **pierre/quartz** (poussières de **silice** → coupe à l'eau/aspiration, masque). **Machines électroportatives** : capots/contrôle. **Repérage des réseaux avant percement** (fixation des meubles hauts, découpe du plan) : repérer/consigner élec/eau/gaz — ne pas percer un câble/tube. **Risques électriques** : le **raccordement électrique** de l'électroménager (circuits spécialisés) est **réservé à un électricien** → voir Électricité ; ici, seule la **pose/l'encastrement**. **Raccordements eau / évacuation** de l'évier : **interface** → le raccordement détaillé relève de la **Plomberie**. **Ventilation des appareils** (hotte/four ; table **gaz** = évacuation/ventilation adaptée). **Amiante** (ouvrages anciens) : diagnostic ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : meubles / caissons (menuiserie intérieure) **DTU 36.2** ; électricité de la cuisine (circuits spécialisés, **interface**) **NF C 15-100** ; plomberie évier / robinetterie (**interface**) **DTU 60.1** ; diagnostic **amiante** (ouvrages anciens) et **ventilation** des appareils ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic / contrôle** : `cite-carte` → [entretenir-diagnostiquer-cuisine](entretenir-diagnostiquer-cuisine.md)

## Relations & tags
- **Tags** : `metier:cuisine famille:finition sous-famille:cuisine intervention:comprendre cluster:implantation-de-cuisine cluster:caissons cluster:meubles-bas cluster:plans-de-travail type:principe securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
