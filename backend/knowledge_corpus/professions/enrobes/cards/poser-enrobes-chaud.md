# Poser des enrobés à chaud

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-enrobes-chaud` |
| Titre | Poser des enrobés à chaud |
| Profession | `metier:enrobes` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:enrobes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : mettre en œuvre des enrobés à chaud (finisseur ou manuel) en respectant température et épaisseur. `[C]`
- **Résumé** : approvisionner l'enrobé à la **température** requise, le répandre (**finisseur** ou manuel) à l'épaisseur/aux pentes visées, puis **compacter immédiatement** dans la fenêtre de température ; risque de **brûlures** (~150-180 °C) et **fumées**. `[C]` ⟦température/épaisseur selon formule à confirmer⟧

## Réalisation
- **Étapes** :
  1. Approvisionner à la **température** requise (bâché). `[C]` ⟦à confirmer⟧
  2. Répandre (**finisseur**/manuel) à l'épaisseur/pentes visées. `[C]`
  3. **Compacter immédiatement** (fenêtre de température). `[C]` → [compacter-enrobes](compacter-enrobes.md)
  4. Traiter les **joints** de bande/reprise. `[C]` → [traiter-joints-reprises](traiter-joints-reprises.md)
- **Points critiques** : **température** dans la fenêtre (compactage) ; épaisseur/pentes ; joints soignés ; **brûlures/fumées** (EPI).
- **Sécurité** : **température élevée (brûlures)** ; **fumées de bitume** ; trafic ; engins. **Chantier routier sous circulation** : **signalisation temporaire** (IISR 8e partie) et **balisage** obligatoires ; **travail à proximité du trafic** = **risque n° 1** (vêtements haute visibilité, séparation physique, réduction de vitesse), **visibilité** maîtrisée. **Enrobés à chaud** : **température élevée** (~150–180 °C) → **brûlures graves** (EPI : gants, chaussures montantes) et **fumées de bitume** (VLEP, ventilation, réduction d'exposition). **Compacteurs / engins** : angles morts, marche arrière, personne dans le rayon. **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, autorisations et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : support/plateforme **DTU 12** ; voirie légère en béton (dallage) **DTU 13.3** ; enrobés hydrocarbonés **NF P 98-150** / mélanges bitumineux **NF EN 13108** et signalisation temporaire (**IISR 8e partie**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Enrobés à froid (réparation)** : `cite-carte` → [poser-enrobes-froid](poser-enrobes-froid.md)

## Relations & tags
- **Tags** : `metier:enrobes famille:gros-oeuvre sous-famille:enrobes intervention:realiser cluster:enrobes-a-chaud cluster:couches-de-roulement complexite:avancee type:realisation securite:brulure securite:trafic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
