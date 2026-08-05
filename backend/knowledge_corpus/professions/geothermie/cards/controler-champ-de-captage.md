# Contrôler un champ de captage géothermique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-champ-de-captage` |
| Titre | Contrôler un champ de captage géothermique |
| Profession | `metier:geothermie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:captage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler l'état hydraulique d'un champ de captage (sondes verticales ou capteurs horizontaux) — hors forage. `[C]`
- **Résumé** : vérifier la pression du circuit de captage, l'équilibrage entre boucles au collecteur, le taux d'antigel et l'absence de fuite, sans intervenir sur le forage lui-même. `[C]` ⟦valeurs selon installation à confirmer⟧

## Réalisation
- **Étapes** :
  1. Vérifier la **pression** du circuit de captage. `[C]`
  2. Contrôler l'**équilibrage** des boucles au collecteur. `[C]` → [controler-collecteur-geothermie](controler-collecteur-geothermie.md)
  3. Contrôler le **fluide caloporteur** (taux d'antigel). `[C]` → [controler-fluide-caloporteur](controler-fluide-caloporteur.md)
  4. Rechercher toute **fuite** (pression en baisse). `[C]` → [captage-pression-basse](../../../diagnostics/geothermie/captage-pression-basse.md)
- **Points critiques** : ne pas altérer les sondes/forage (foreur) ; équilibrage entre boucles.
- **Sécurité** : captage sous pression ; forage réservé foreur. **Le **forage/captage vertical** relève d'un **foreur qualifié** (réglementation GMI / déclaration) ; la partie **PAC** (circuit frigorifique) est réservée à un **frigoriste attesté F-Gaz** ; le **raccordement électrique** à un intervenant **habilité**.** `[A]`

## Cadre & suites
- **Normes** : installation électrique **NF C 15-100** ; réglementation **géothermie de minime importance (GMI)** ; dimensionnement **NF EN 15450** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [captage-pression-basse](../../../diagnostics/geothermie/captage-pression-basse.md)

## Relations & tags
- **Tags** : `metier:geothermie equipement:sonde-geothermique equipement:capteur famille:fluides sous-famille:captage intervention:controler cluster:captage cluster:sondes-geothermiques cluster:geothermie-verticale cluster:geothermie-horizontale cluster:controle complexite:avancee type:controle`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
