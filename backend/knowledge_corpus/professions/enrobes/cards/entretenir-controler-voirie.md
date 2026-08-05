# Entretenir / contrôler une voirie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-controler-voirie` |
| Titre | Entretenir / contrôler une voirie |
| Profession | `metier:enrobes` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:enrobes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir et contrôler une voirie en enrobé (uni, dégradations, drainage) pour prévenir la ruine. `[C]`
- **Résumé** : contrôler l'**uni** et les **dégradations** (fissures, ornières, nids-de-poule, ressuage), vérifier le **drainage** (écoulement/caniveaux), réaliser l'entretien préventif (colmatage de fissures, réparations localisées) et planifier les réfections. `[C]`

## Réalisation
- **Étapes** :
  1. Contrôler l'**uni** et repérer les dégradations. `[C]` → [degradation-enrobe-fissures](../../../diagnostics/enrobes/degradation-enrobe-fissures.md)
  2. Vérifier le **drainage** (écoulement / caniveaux VRD). `[C]`
  3. Entretien préventif (colmatage fissures, purges). `[C]` → [reparer-nid-de-poule](reparer-nid-de-poule.md)
  4. Planifier les réfections (couche de roulement). `[C]`
- **Points critiques** : traiter tôt (l'eau accélère la ruine) ; drainage ; entretien préventif moins coûteux que la réfection.
- **Sécurité** : trafic ; température (si réparation à chaud) ; engins. **Chantier routier sous circulation** : **signalisation temporaire** (IISR 8e partie) et **balisage** obligatoires ; **travail à proximité du trafic** = **risque n° 1** (vêtements haute visibilité, séparation physique, réduction de vitesse), **visibilité** maîtrisée. **Enrobés à chaud** : **température élevée** (~150–180 °C) → **brûlures graves** (EPI : gants, chaussures montantes) et **fumées de bitume** (VLEP, ventilation, réduction d'exposition). **Compacteurs / engins** : angles morts, marche arrière, personne dans le rayon. **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, autorisations et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : support/plateforme **DTU 12** ; voirie légère en béton (dallage) **DTU 13.3** ; enrobés hydrocarbonés **NF P 98-150** / mélanges bitumineux **NF EN 13108** et signalisation temporaire (**IISR 8e partie**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-enrobes-voirie](../../../kits/enrobes/kit-enrobes-voirie.md)

## Relations & tags
- **Tags** : `metier:enrobes famille:gros-oeuvre sous-famille:enrobes intervention:entretenir intervention:controler cluster:entretien cluster:controle cluster:voirie-legere complexite:moyenne type:entretien securite:trafic relation:vrd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
