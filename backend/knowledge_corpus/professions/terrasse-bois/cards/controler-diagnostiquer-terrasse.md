# Contrôler et diagnostiquer une terrasse bois

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-diagnostiquer-terrasse` |
| Titre | Contrôler et diagnostiquer une terrasse bois |
| Profession | `metier:terrasse-bois` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:terrasse-bois` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler l'état d'une terrasse bois et diagnostiquer les défauts (stabilité, pourriture, lames). `[C]`
- **Résumé** : inspecter la **stabilité** (plots/lambourdes, pas de mouvement), l'état des **lames** (fentes, échardes, grisaillement), la **pourriture** éventuelle (zones mal ventilées/drainées), la tenue des **fixations** et des rives, et vérifier les **jeux** ; en hauteur, contrôler la sécurité (garde-corps = métier concerné) ; hiérarchiser reprise ou rénovation. `[C]`

## Réalisation
- **Étapes** :
  1. Contrôler **stabilité** (plots/lambourdes). `[C]` → [terrasse-instable-plots](../../../diagnostics/terrasse-bois/terrasse-instable-plots.md)
  2. Inspecter **lames** (fentes/échardes) et **pourriture**. `[C]` → [bois-pourri-humidite](../../../diagnostics/terrasse-bois/bois-pourri-humidite.md)
  3. Vérifier fixations/rives/jeux. `[C]`
  4. Sécurité (garde-corps si surélevée) ; hiérarchiser. `[C]` → [controle-maintenance-terrasse-bois](../../../checklists/terrasse-bois/controle-maintenance-terrasse-bois.md)
- **Points critiques** : stabilité vérifiée ; pourriture détectée tôt (ventilation) ; fixations/jeux OK ; sécurité (garde-corps).
- **Sécurité** : échardes ; manutention ; hauteur (surélevée). **Outils électroportatifs / découpe** : scie circulaire/sauteuse, visseuse — **coupures**, projections → lunettes/gants, capot/guide ; **poussières de bois cancérogènes** (surtout exotiques/composite) → aspiration/masque. **Manutention** (lames, lambourdes, plots, colis lourds) : binôme/moyens — dos/écrasement ; **échardes** (bois brut). **Repérage des réseaux avant ancrage/terrassement** (**DT-DICT**) : scellement de plots, fixations dans dalle → ne pas percer un câble/tuyau. **Terrasse surélevée** : **garde-corps** (métier concerné) et risque de chute pendant la pose. **Glissance** (bois humide) ; intempéries. **Risques électriques** : un éventuel **éclairage intégré** (spots LED) → **raccordement réservé à un électricien** (interface). **Amiante** (rénovation, ancien support/revêtement) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : platelages extérieurs en bois **DTU 51.4** ; dalle / support béton (**interface** maçonnerie) **DTU 21** ; classes d'emploi du bois **NF EN 335**, durabilité **NF EN 350**, bois composite **NF EN 15534**, éclairage intégré (**interface** électricité) **NF C 15-100** et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostic pourriture** : `cite-diagnostic` → [bois-pourri-humidite](../../../diagnostics/terrasse-bois/bois-pourri-humidite.md)

## Relations & tags
- **Tags** : `metier:terrasse-bois famille:specialises sous-famille:terrasse-bois intervention:controler cluster:diagnostic cluster:maintenance complexite:moyenne type:entretien securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
