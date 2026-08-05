# Principe de la façade (enduits, bardages, ITE, revêtements)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-facade` |
| Titre | Principe de la façade (enduits, bardages, ITE, revêtements) |
| Profession | `metier:facade` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:facade` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le rôle de la façade (protection, esthétique, thermique) et ses grands types de traitement sur support maçonné. `[C]`
- **Résumé** : la façade protège le bâti et participe au confort thermique ; principaux traitements : **enduit**, **bardage rapporté**, **ITE** (isolation par l'extérieur) et **revêtements** d'imperméabilité, sur **support maçonné**. `[C]` ⟦systèmes selon support/climat à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Façades enduites** (mortier/monocouche). `[C]` → [reprendre-enduit-facade](reprendre-enduit-facade.md)
  2. **Bardage rapporté** (revêtement ventilé, angle façade). `[C]` → [poser-bardage-rapporte](poser-bardage-rapporte.md)
  3. **ITE** : le cœur isolant relève du Livre **Isolation** (`relation:isolation`) ; ici, finition/contrôle. `[C]` → [controler-ite-facade](controler-ite-facade.md)
  4. **Support maçonné** : diagnostic préalable indispensable. `[C]` → [diagnostiquer-facade](diagnostiquer-facade.md)
- **Points critiques** : adhérence/état du support ; compatibilité du système ; gestion des **ponts thermiques** et de l'eau.
- **Sécurité** : hauteur ; stabilité du support ; produits. **Travail en **hauteur** : risque de **chute** — protections **collectives** (échafaudage/garde-corps) prioritaires, **EPI adaptés**, **météo** (vent/gel/pluie) surveillée. **Stabilité du support** : évaluer l'état du support (purge des parties non adhérentes) avant intervention. **Produits chimiques** (nettoyants, hydrofuges, traitements) : EPI, ventilation, protection de l'environnement. **Arrêt immédiat en cas de danger.** Une intervention en façade relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : enduits de mortiers **DTU 26.1** ; réfection de façades par revêtements d'imperméabilité **DTU 42.1** ; maçonnerie de petits éléments **DTU 20.1** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Charpente (support/ossature)** : `cite-carte` → [inspecter-charpente](../../../professions/charpente/cards/inspecter-charpente.md)

## Relations & tags
- **Tags** : `metier:facade equipement:enduit equipement:bardage famille:enveloppe sous-famille:facade intervention:comprendre cluster:facades-enduites cluster:bardages cluster:ite cluster:revetements cluster:supports-maconnes cluster:ponts-thermiques type:principe securite:hauteur relation:isolation relation:etancheite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
