# Réparer un nid-de-poule (réparation localisée)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `reparer-nid-de-poule` |
| Titre | Réparer un nid-de-poule (réparation localisée) |
| Profession | `metier:enrobes` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:enrobes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réparer un nid-de-poule / une dégradation localisée par purge et réfection. `[C]`
- **Résumé** : délimiter et **purger** la zone dégradée (découpe franche, retrait du non adhérent et de l'eau), appliquer la couche d'accrochage, remplir en enrobé (à chaud ou à froid selon moyens), **compacter** et raccorder à l'existant ; traiter la **cause** (support/eau) si récurrence. `[C]` ⟦méthode selon dégradation à confirmer⟧

## Réalisation
- **Étapes** :
  1. Délimiter/**purger** (découpe franche, sécher). `[C]` → [nid-de-poule-affaissement](../../../diagnostics/enrobes/nid-de-poule-affaissement.md)
  2. Couche d'accrochage ; remplir en **enrobé** (chaud/froid). `[C]` → [poser-enrobes-froid](poser-enrobes-froid.md)
  3. **Compacter** et raccorder à l'existant. `[C]`
  4. Traiter la **cause** (support/eau) si récurrence. `[C]`
- **Points critiques** : **purge franche** (sinon récidive) ; support sec ; compactage ; traiter la cause (eau/support) pas seulement le symptôme.
- **Sécurité** : trafic (intervention ponctuelle) ; température (à chaud) ; engins. **Chantier routier sous circulation** : **signalisation temporaire** (IISR 8e partie) et **balisage** obligatoires ; **travail à proximité du trafic** = **risque n° 1** (vêtements haute visibilité, séparation physique, réduction de vitesse), **visibilité** maîtrisée. **Enrobés à chaud** : **température élevée** (~150–180 °C) → **brûlures graves** (EPI : gants, chaussures montantes) et **fumées de bitume** (VLEP, ventilation, réduction d'exposition). **Compacteurs / engins** : angles morts, marche arrière, personne dans le rayon. **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, autorisations et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : support/plateforme **DTU 12** ; voirie légère en béton (dallage) **DTU 13.3** ; enrobés hydrocarbonés **NF P 98-150** / mélanges bitumineux **NF EN 13108** et signalisation temporaire (**IISR 8e partie**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle/entretien** : `cite-carte` → [entretenir-controler-voirie](entretenir-controler-voirie.md)

## Relations & tags
- **Tags** : `metier:enrobes famille:gros-oeuvre sous-famille:enrobes intervention:reparer cluster:reparations-localisees cluster:enrobes-a-froid complexite:moyenne type:reparation securite:trafic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
