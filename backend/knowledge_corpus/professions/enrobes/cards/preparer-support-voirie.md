# Préparer le support (voirie)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `preparer-support-voirie` |
| Titre | Préparer le support (voirie) |
| Profession | `metier:enrobes` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:enrobes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : préparer le support avant enrobé : plateforme portante, propreté, couche d'accrochage. `[C]`
- **Résumé** : vérifier la **portance** et la planéité de la plateforme (terrassement), nettoyer/**raboter** si réfection, régler l'altimétrie et les **pentes**, puis appliquer une **couche d'accrochage** (émulsion) avant l'enrobé. `[C]` ⟦portance/couche d'accrochage selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. Vérifier **portance/planéité** de la plateforme. `[C]` → [niveler-plateforme](../../../professions/terrassement/cards/niveler-plateforme.md)
  2. Nettoyer / **raboter** l'existant (réfection) ; évacuer. `[C]`
  3. Régler **altimétrie / pentes** d'écoulement. `[C]`
  4. Appliquer la **couche d'accrochage** (émulsion). `[C]` ⟦à confirmer⟧
- **Points critiques** : support **portant et propre** ; pentes d'écoulement ; couche d'accrochage (adhérence des couches) ; sinon décollement.
- **Sécurité** : engins (rabotage) ; trafic ; poussières. **Chantier routier sous circulation** : **signalisation temporaire** (IISR 8e partie) et **balisage** obligatoires ; **travail à proximité du trafic** = **risque n° 1** (vêtements haute visibilité, séparation physique, réduction de vitesse), **visibilité** maîtrisée. **Enrobés à chaud** : **température élevée** (~150–180 °C) → **brûlures graves** (EPI : gants, chaussures montantes) et **fumées de bitume** (VLEP, ventilation, réduction d'exposition). **Compacteurs / engins** : angles morts, marche arrière, personne dans le rayon. **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, autorisations et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : support/plateforme **DTU 12** ; voirie légère en béton (dallage) **DTU 13.3** ; enrobés hydrocarbonés **NF P 98-150** / mélanges bitumineux **NF EN 13108** et signalisation temporaire (**IISR 8e partie**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Pose enrobé** : `cite-carte` → [poser-enrobes-chaud](poser-enrobes-chaud.md)

## Relations & tags
- **Tags** : `metier:enrobes famille:gros-oeuvre sous-famille:enrobes intervention:realiser cluster:preparation-des-supports complexite:moyenne type:realisation securite:trafic relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
