# Concevoir et implanter un agencement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `concevoir-implanter-agencement` |
| Titre | Concevoir et implanter un agencement |
| Profession | `metier:agencement` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:agencement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : concevoir et implanter un **aménagement intérieur** sur mesure (relevé, calepinage, adaptation aux volumes). `[C]`
- **Résumé** : réaliser un **relevé** précis (murs non d'équerre, réservations, réseaux), concevoir le **calepinage** (modules, portes, tiroirs, étagères), prévoir les **réservations** (éclairage intégré, prises — interface Électricité) et l'**ancrage** possible, puis valider avec le client ; l'adaptation aux volumes réels est la valeur du sur-mesure. `[C]` ⟦cotes/modules selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Relevé** précis (équerrage, réservations). `[C]`
  2. **Calepinage** (modules/portes/tiroirs/étagères). `[C]`
  3. Prévoir réservations (**éclairage/prises** = interface Élec). `[C]` → [remplacer-prise-courant](../../../professions/electricite-generale/cards/remplacer-prise-courant.md)
  4. Valider l'ancrage/le support disponible. `[C]` → [reperage-fixation-amiante-avant-pose-agencement](../../../procedures/agencement/reperage-fixation-amiante-avant-pose-agencement.md)
- **Points critiques** : relevé précis (sur-mesure) ; réservations élec anticipées (interface) ; ancrage prévu ; validation client.
- **Sécurité** : — ; — ; électricité (réservations, interface). **Manutention des éléments volumineux** (panneaux, caissons de dressing/bibliothèque) : binôme/levage — écrasement/dos. **Fixation murale anti-basculement** : les meubles hauts/étroits (dressings, bibliothèques) doivent être **ancrés au mur** — un meuble non fixé peut **basculer** (danger, notamment pour les **enfants**). **Ancrages selon le support** : chevilles/rails adaptés (plaque de plâtre ≠ maçonnerie) — un ancrage sous-dimensionné cède. **Perçages et découpes** : coupures, projections ; **poussières de bois cancérogènes** → aspiration/masque. **Machines électroportatives** : capots/contrôle ; **bruit** : protection auditive. **Repérage des réseaux avant percement** : repérer/consigner élec/gaines (ne pas percer un câble). **Risques électriques / éclairage intégré** : le **raccordement électrique** (LED de niche/dressing) est **réservé à un électricien** → voir Électricité. **Amiante** (ouvrages anciens) : diagnostic ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : menuiseries intérieures / meubles en bois **DTU 36.2**, **DTU 36.1** ; électricité (éclairage intégré / percement, **interface**) **NF C 15-100** ; stabilité des meubles de rangement (**EN 14749**), anti-basculement et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Fabrication / pose** : `cite-carte` → [fabriquer-poser-caissons-dressing](fabriquer-poser-caissons-dressing.md)

## Relations & tags
- **Tags** : `metier:agencement famille:finition sous-famille:agencement intervention:comprendre cluster:amenagements-interieurs cluster:rangements-fixes complexite:moyenne type:conception securite:manutention relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
