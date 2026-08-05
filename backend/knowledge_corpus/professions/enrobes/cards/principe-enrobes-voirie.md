# Principe des enrobés / structure de chaussée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-enrobes-voirie` |
| Titre | Principe des enrobés / structure de chaussée |
| Profession | `metier:enrobes` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:enrobes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre la structure d'une chaussée (couches) et les familles d'enrobés (chaud/froid, grave-bitume). `[C]`
- **Résumé** : une chaussée est constituée de **couches** superposées — forme/**base** (souvent **grave-bitume**), **liaison** et **roulement** — mises en œuvre en **enrobés à chaud** (courant) ou **à froid** (réparations), sur un **support/plateforme** préparé ; la bordure/le caniveau relève de la **VRD**. `[C]` ⟦structure/épaisseurs selon trafic à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Support/plateforme** préparé (compacté, propre). `[C]` → [preparer-support-voirie](preparer-support-voirie.md)
  2. Couches **base (grave-bitume) / liaison / roulement**. `[C]` → [poser-enrobes-chaud](poser-enrobes-chaud.md)
  3. **Compactage** de chaque couche. `[C]` → [compacter-enrobes](compacter-enrobes.md)
  4. **Bordures / caniveaux** = VRD (frontière). `[C]` → [poser-bordures-caniveaux](../../../professions/vrd/cards/poser-bordures-caniveaux.md)
- **Points critiques** : structure adaptée au **trafic** ; support portant ; **compactage** de chaque couche ; écoulement (pentes) ; bordures = VRD.
- **Sécurité** : trafic ; température des enrobés ; engins. **Chantier routier sous circulation** : **signalisation temporaire** (IISR 8e partie) et **balisage** obligatoires ; **travail à proximité du trafic** = **risque n° 1** (vêtements haute visibilité, séparation physique, réduction de vitesse), **visibilité** maîtrisée. **Enrobés à chaud** : **température élevée** (~150–180 °C) → **brûlures graves** (EPI : gants, chaussures montantes) et **fumées de bitume** (VLEP, ventilation, réduction d'exposition). **Compacteurs / engins** : angles morts, marche arrière, personne dans le rayon. **Arrêt immédiat en cas de danger.** Ces opérations exigent compétences, autorisations et moyens adaptés.** `[A]`

## Cadre & suites
- **Normes** : support/plateforme **DTU 12** ; voirie légère en béton (dallage) **DTU 13.3** ; enrobés hydrocarbonés **NF P 98-150** / mélanges bitumineux **NF EN 13108** et signalisation temporaire (**IISR 8e partie**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic / contrôle** : `cite-carte` → [entretenir-controler-voirie](entretenir-controler-voirie.md)

## Relations & tags
- **Tags** : `metier:enrobes famille:gros-oeuvre sous-famille:enrobes intervention:comprendre cluster:enrobes-a-chaud cluster:grave-bitume cluster:couches-de-base cluster:couches-de-liaison cluster:couches-de-roulement type:principe securite:trafic relation:vrd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
