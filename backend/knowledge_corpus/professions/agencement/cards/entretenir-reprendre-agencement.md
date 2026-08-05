# Entretenir / reprendre un agencement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-reprendre-agencement` |
| Titre | Entretenir / reprendre un agencement |
| Profession | `metier:agencement` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:agencement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir un agencement et réaliser des **reprises** (quincaillerie, fixation, habillage). `[C]`
- **Résumé** : contrôler l'**ancrage** (anti-basculement) et les **fixations**, régler/lubrifier la quincaillerie, reprendre un panneau/habillage abîmé, vérifier la charge des tablettes, et adapter l'entretien aux matériaux ; en rénovation d'ouvrages anciens, **diagnostic amiante**. `[C]`

## Réalisation
- **Étapes** :
  1. Vérifier **ancrage** (anti-basculement) et fixations. `[A]` → [meuble-bascule-fixation](../../../diagnostics/agencement/meuble-bascule-fixation.md)
  2. Régler/lubrifier la quincaillerie. `[C]` → [installer-regler-quincaillerie-agencement](installer-regler-quincaillerie-agencement.md)
  3. Reprendre un panneau/habillage abîmé. `[C]`
  4. Rénovation ancienne : **diagnostic amiante**. `[C]`
- **Points critiques** : ancrage/fixation sûrs (anti-basculement) ; charge des tablettes ; quincaillerie réglée ; **amiante** en rénovation.
- **Sécurité** : manutention ; **basculement** (fixation) ; amiante (rénovation). **Manutention des éléments volumineux** (panneaux, caissons de dressing/bibliothèque) : binôme/levage — écrasement/dos. **Fixation murale anti-basculement** : les meubles hauts/étroits (dressings, bibliothèques) doivent être **ancrés au mur** — un meuble non fixé peut **basculer** (danger, notamment pour les **enfants**). **Ancrages selon le support** : chevilles/rails adaptés (plaque de plâtre ≠ maçonnerie) — un ancrage sous-dimensionné cède. **Perçages et découpes** : coupures, projections ; **poussières de bois cancérogènes** → aspiration/masque. **Machines électroportatives** : capots/contrôle ; **bruit** : protection auditive. **Repérage des réseaux avant percement** : repérer/consigner élec/gaines (ne pas percer un câble). **Risques électriques / éclairage intégré** : le **raccordement électrique** (LED de niche/dressing) est **réservé à un électricien** → voir Électricité. **Amiante** (ouvrages anciens) : diagnostic ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : menuiseries intérieures / meubles en bois **DTU 36.2**, **DTU 36.1** ; électricité (éclairage intégré / percement, **interface**) **NF C 15-100** ; stabilité des meubles de rangement (**EN 14749**), anti-basculement et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-agenceur](../../../kits/agencement/kit-agenceur.md)

## Relations & tags
- **Tags** : `metier:agencement famille:finition sous-famille:agencement intervention:entretenir intervention:reparer cluster:reprises cluster:entretien cluster:maintenance complexite:moyenne type:entretien securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
