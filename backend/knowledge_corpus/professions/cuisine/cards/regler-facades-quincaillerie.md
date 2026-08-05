# Régler les façades et la quincaillerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `regler-facades-quincaillerie` |
| Titre | Régler les façades et la quincaillerie |
| Profession | `metier:cuisine` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:cuisine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser et **régler** les **façades** (portes/tiroirs), la **quincaillerie** (charnières/coulisses) et les finitions. `[C]`
- **Résumé** : poser les façades sur **charnières** invisibles et les tiroirs sur **coulisses**, **régler** l'alignement (3 axes), les jeux et l'aplomb pour des lignes régulières, poser poignées et **finitions** (plinthes de socle, joues, corniches) ; la quincaillerie d'ameublement rejoint la **Menuiserie intérieure**. `[C]` ⟦réglages selon quincaillerie à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser façades (**charnières**) et tiroirs (**coulisses**). `[C]`
  2. **Régler** l'alignement (3 axes), jeux, aplomb. `[C]` → [facade-desalignee-charniere](../../../diagnostics/cuisine/facade-desalignee-charniere.md)
  3. Poser poignées et **finitions** (plinthes de socle/joues). `[C]`
  4. Quincaillerie d'ameublement : voir **Menuiserie int**. `[C]` → [installer-quincaillerie-ferrures](../../../professions/menuiserie-interieure/cards/installer-quincaillerie-ferrures.md)
- **Points critiques** : alignement régulier (3 axes) ; jeux constants ; finitions (socle/joues) ; quincaillerie de qualité.
- **Sécurité** : pincement (charnières/tiroirs) ; — ; — **Manutention des plans de travail** (lourds, surtout **pierre/quartz**) : ventouses/binôme/levage — écrasement/dos. **Découpes** : **stratifié/bois** (poussières de bois cancérogènes → aspiration), **pierre/quartz** (poussières de **silice** → coupe à l'eau/aspiration, masque). **Machines électroportatives** : capots/contrôle. **Repérage des réseaux avant percement** (fixation des meubles hauts, découpe du plan) : repérer/consigner élec/eau/gaz — ne pas percer un câble/tube. **Risques électriques** : le **raccordement électrique** de l'électroménager (circuits spécialisés) est **réservé à un électricien** → voir Électricité ; ici, seule la **pose/l'encastrement**. **Raccordements eau / évacuation** de l'évier : **interface** → le raccordement détaillé relève de la **Plomberie**. **Ventilation des appareils** (hotte/four ; table **gaz** = évacuation/ventilation adaptée). **Amiante** (ouvrages anciens) : diagnostic ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : meubles / caissons (menuiserie intérieure) **DTU 36.2** ; électricité de la cuisine (circuits spécialisés, **interface**) **NF C 15-100** ; plomberie évier / robinetterie (**interface**) **DTU 60.1** ; diagnostic **amiante** (ouvrages anciens) et **ventilation** des appareils ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien** : `cite-carte` → [entretenir-diagnostiquer-cuisine](entretenir-diagnostiquer-cuisine.md)

## Relations & tags
- **Tags** : `metier:cuisine famille:finition sous-famille:cuisine intervention:regler cluster:reglages-de-facades cluster:quincaillerie cluster:finitions complexite:moyenne type:reglage securite:manutention relation:menuiserie-interieure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
