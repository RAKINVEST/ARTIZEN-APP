# Principe de la charpente (traditionnelle / industrielle)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-charpente` |
| Titre | Principe de la charpente (traditionnelle / industrielle) |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre les types de charpente (traditionnelle vs industrielle/fermettes) et leurs éléments (fermes, pannes, chevrons). `[C]`
- **Résumé** : la charpente **traditionnelle** (bois massif assemblé) et la charpente **industrielle** (fermettes assemblées par connecteurs) reprennent les charges de la couverture jusqu'aux murs ; éléments : **fermes, pannes, chevrons, liteaux/voliges**. `[C]` ⟦schémas selon ouvrage à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Fermes** : structure porteuse principale. `[C]` → [renforcer-panne-ferme](renforcer-panne-ferme.md)
  2. **Pannes / chevrons** : reprennent la couverture. `[C]` → [remplacer-chevron](remplacer-chevron.md)
  3. **Liteaux / voliges** : support de couverture. `[C]` → [controler-liteaux-voliges](controler-liteaux-voliges.md)
  4. **Assemblages** (tenon-mortaise, connecteurs, boulonnage). `[C]` → [controler-assemblages](controler-assemblages.md)
  5. Bois **massif** ou **lamellé-collé** selon portées/ouvrage. `[C]`
- **Points critiques** : ne jamais modifier une structure porteuse sans **étude/étaiement** ; identifier le type avant intervention.
- **Sécurité** : structure porteuse : toute modification engage la **stabilité**. **Travail en **hauteur** : risque de **chute** — EPI antichute, protections/échafaudage, **météo** (vent/gel/pluie) surveillée. **Stabilité de l'ouvrage** : évaluer **charges** et prévoir l'**étaiement** avant toute dépose/coupe d'un élément porteur — ne jamais affaiblir la structure sans étaiement/étude. **Arrêt immédiat en cas de danger** (fissuration, mouvement, doute structurel). Une intervention structurelle relève de **compétences charpente adaptées**.** `[A]`

## Cadre & suites
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Inspection** : `cite-carte` → [inspecter-charpente](inspecter-charpente.md)

## Relations & tags
- **Tags** : `metier:charpente equipement:ferme equipement:panne equipement:chevron famille:enveloppe sous-famille:charpente intervention:comprendre cluster:fermes cluster:pannes cluster:chevrons cluster:bois-massif cluster:bois-lamelle-colle cluster:charpente-traditionnelle cluster:charpente-industrielle type:principe securite:hauteur securite:structure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
