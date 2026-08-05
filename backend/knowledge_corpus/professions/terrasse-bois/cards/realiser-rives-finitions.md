# Réaliser les rives et finitions (jeux périphériques)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `realiser-rives-finitions` |
| Titre | Réaliser les rives et finitions (jeux périphériques) |
| Profession | `metier:terrasse-bois` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:terrasse-bois` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : traiter les **rives**, les **jeux périphériques** et les finitions (plinthes, habillages, seuils). `[C]`
- **Résumé** : finir les **rives** (bandeaux, plinthes de rive, profilés), respecter les **jeux périphériques** (contre murs/seuils — le bois se dilate), traiter les **seuils** de porte-fenêtre (garde à l'eau, sans bloquer l'ouvrant — frontière **Menuiserie extérieure**) et prévoir l'éventuel **éclairage intégré** dont le raccordement relève de l'**Électricité** ; garde-corps de terrasse surélevée = métier concerné. `[C]` ⟦finitions/seuils selon projet à confirmer⟧

## Réalisation
- **Étapes** :
  1. Finir les **rives** (bandeaux/plinthes/profilés). `[C]`
  2. Respecter les **jeux périphériques** (murs/seuils). `[A]`
  3. **Seuils** de porte-fenêtre = Menuiserie ext (frontière). `[C]` → [principe-menuiserie-exterieure](../../../professions/menuiserie-exterieure/cards/principe-menuiserie-exterieure.md)
  4. **Éclairage intégré** éventuel = Électricité (interface). `[C]` → [remplacer-prise-courant](../../../professions/electricite-generale/cards/remplacer-prise-courant.md)
- **Points critiques** : **jeux périphériques** (dilatation) ; garde à l'eau aux seuils ; rives soignées ; éclairage = interface Élec.
- **Sécurité** : découpe ; manutention ; électrique (interface). **Outils électroportatifs / découpe** : scie circulaire/sauteuse, visseuse — **coupures**, projections → lunettes/gants, capot/guide ; **poussières de bois cancérogènes** (surtout exotiques/composite) → aspiration/masque. **Manutention** (lames, lambourdes, plots, colis lourds) : binôme/moyens — dos/écrasement ; **échardes** (bois brut). **Repérage des réseaux avant ancrage/terrassement** (**DT-DICT**) : scellement de plots, fixations dans dalle → ne pas percer un câble/tuyau. **Terrasse surélevée** : **garde-corps** (métier concerné) et risque de chute pendant la pose. **Glissance** (bois humide) ; intempéries. **Risques électriques** : un éventuel **éclairage intégré** (spots LED) → **raccordement réservé à un électricien** (interface). **Amiante** (rénovation, ancien support/revêtement) : diagnostic ; retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : platelages extérieurs en bois **DTU 51.4** ; dalle / support béton (**interface** maçonnerie) **DTU 21** ; classes d'emploi du bois **NF EN 335**, durabilité **NF EN 350**, bois composite **NF EN 15534**, éclairage intégré (**interface** électricité) **NF C 15-100** et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Entretien** : `cite-carte` → [entretenir-renover-terrasse](entretenir-renover-terrasse.md)

## Relations & tags
- **Tags** : `metier:terrasse-bois famille:specialises sous-famille:terrasse-bois intervention:realiser cluster:jeux-peripheriques cluster:finitions complexite:moyenne type:finition securite:coupure relation:menuiserie-exterieure relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
