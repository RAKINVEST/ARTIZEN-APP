# Traiter les joints et reprises

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `traiter-joints-reprises` |
| Titre | Traiter les joints et reprises |
| Profession | `metier:enrobes` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:enrobes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser les **joints** (de bande, de reprise) et les **reprises** d'enrobé pour assurer continuité et étanchéité. `[C]`
- **Résumé** : traiter les joints longitudinaux/transversaux (bord chaud/collage au **bitume**), scier proprement les reprises, coller les lèvres et compacter le joint, pour éviter les infiltrations et l'arrachement ; les joints sont les **points faibles** d'une chaussée. `[C]` ⟦traitement selon type de joint à confirmer⟧

## Réalisation
- **Étapes** :
  1. Scier/délimiter proprement la **reprise**. `[C]`
  2. **Coller** les lèvres (bitume) ; bord chaud si possible. `[C]`
  3. Répandre l'enrobé ; **compacter le joint**. `[C]` → [compacter-enrobes](compacter-enrobes.md)
  4. Vérifier l'étanchéité/l'uni du joint. `[C]`
- **Points critiques** : joints = **points faibles** (infiltration/arrachement) ; collage soigné ; compactage du joint ; uni respecté.
- **Sécurité** : température/brûlures ; trafic ; sciage (poussières). **Chantier routier sous circulation** : **signalisation temporaire** (IISR 8e partie) et **balisage** obligatoires ; **travail à proximité du trafic** = **risque n° 1** (vêtements haute visibilité, séparation physique, réduction de vitesse), **visibilité** maîtrisée. **Enrobés à chaud** : **température élevée** (~150–180 °C) → **brûlures graves** (EPI : gants, chaussures montantes) et **fumées de bitume** (VLEP, ventilation, réduction d'exposition). **Compacteurs / engins** : angles morts, marche arrière, personne dans le rayon. **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, autorisations et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : support/plateforme **DTU 12** ; voirie légère en béton (dallage) **DTU 13.3** ; enrobés hydrocarbonés **NF P 98-150** / mélanges bitumineux **NF EN 13108** et signalisation temporaire (**IISR 8e partie**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Dégradations** : `traite-diagnostic` → [degradation-enrobe-fissures](../../../diagnostics/enrobes/degradation-enrobe-fissures.md)

## Relations & tags
- **Tags** : `metier:enrobes famille:gros-oeuvre sous-famille:enrobes intervention:reparer cluster:joints cluster:reprises complexite:avancee type:reparation securite:brulure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
