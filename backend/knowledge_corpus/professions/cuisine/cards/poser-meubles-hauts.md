# Poser les meubles hauts

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-meubles-hauts` |
| Titre | Poser les meubles hauts |
| Profession | `metier:cuisine` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:cuisine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser les **meubles hauts** à hauteur/alignement, avec une **fixation murale sécurisée** (charge). `[C]`
- **Résumé** : tracer la ligne des meubles hauts, choisir la **fixation adaptée au support** (rail/suspensions + chevilles selon plaque de plâtre/maçonnerie), poser en alignant et de niveau, **solidariser** les caissons, et vérifier la tenue (les meubles chargés de vaisselle sont **lourds** — un meuble haut mal fixé chute) ; repérer les réseaux avant perçage. `[C]` ⟦fixation/charge selon support à confirmer⟧

## Réalisation
- **Étapes** :
  1. Tracer la ligne ; **repérer les réseaux** avant perçage. `[A]` → [remplacer-prise-courant](../../../professions/electricite-generale/cards/remplacer-prise-courant.md)
  2. **Fixation adaptée au support** (rail/chevilles) — charge. `[A]`
  3. Poser aligné/de niveau ; **solidariser** les caissons. `[C]`
  4. Vérifier la **tenue** (meuble chargé = lourd). `[A]` → [meuble-descelle-fixation](../../../diagnostics/cuisine/meuble-descelle-fixation.md)
- **Points critiques** : **fixation dimensionnée** (charge/support — danger de chute) ; alignement/niveau ; caissons solidarisés ; repérage réseaux.
- **Sécurité** : **chute d'un meuble haut** (fixation) ; manutention ; électricité (perçage). **Manutention des plans de travail** (lourds, surtout **pierre/quartz**) : ventouses/binôme/levage — écrasement/dos. **Découpes** : **stratifié/bois** (poussières de bois cancérogènes → aspiration), **pierre/quartz** (poussières de **silice** → coupe à l'eau/aspiration, masque). **Machines électroportatives** : capots/contrôle. **Repérage des réseaux avant percement** (fixation des meubles hauts, découpe du plan) : repérer/consigner élec/eau/gaz — ne pas percer un câble/tube. **Risques électriques** : le **raccordement électrique** de l'électroménager (circuits spécialisés) est **réservé à un électricien** → voir Électricité ; ici, seule la **pose/l'encastrement**. **Raccordements eau / évacuation** de l'évier : **interface** → le raccordement détaillé relève de la **Plomberie**. **Ventilation des appareils** (hotte/four ; table **gaz** = évacuation/ventilation adaptée). **Amiante** (ouvrages anciens) : diagnostic ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : meubles / caissons (menuiserie intérieure) **DTU 36.2** ; électricité de la cuisine (circuits spécialisés, **interface**) **NF C 15-100** ; plomberie évier / robinetterie (**interface**) **DTU 60.1** ; diagnostic **amiante** (ouvrages anciens) et **ventilation** des appareils ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Plan de travail** : `cite-carte` → [poser-plan-travail](poser-plan-travail.md)

## Relations & tags
- **Tags** : `metier:cuisine famille:finition sous-famille:cuisine intervention:realiser cluster:meubles-hauts complexite:moyenne type:installation securite:manutention relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
