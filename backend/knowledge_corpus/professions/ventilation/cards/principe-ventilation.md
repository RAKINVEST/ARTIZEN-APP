# Principe de la ventilation (simple / double flux)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-ventilation` |
| Titre | Principe de la ventilation (simple / double flux) |
| Profession | `metier:ventilation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:ventilation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre les systèmes de ventilation d'un logement : **simple flux** (auto/hygroréglable) et **double flux**. `[C]`
- **Résumé** : la ventilation renouvelle l'air : en **simple flux**, un caisson extrait l'air vicié (cuisine, SdB) et l'air neuf entre par les entrées d'air ; en **double flux**, l'air entrant est filtré et préchauffé par un **échangeur**. `[C]` ⟦schémas/débits selon logement à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Simple flux auto ou hygroréglable** : extraction pilotée (humidité). `[C]` → [entretenir-vmc-simple-flux](entretenir-vmc-simple-flux.md)
  2. **Double flux** : insufflation + extraction avec **échangeur** et **filtres**. `[C]` → [entretenir-vmc-double-flux](entretenir-vmc-double-flux.md)
  3. **Réseau aéraulique** : caisson, conduits, bouches. `[C]` → [controler-reseau-aeraulique](controler-reseau-aeraulique.md)
  4. **Équilibrage** des débits selon les pièces. `[C]` → [equilibrer-debits-ventilation](equilibrer-debits-ventilation.md)
- **Points critiques** : choisir le système selon le bâti ; respecter les **débits réglementaires** ; étanchéité des conduits.
- **Sécurité** : ne jamais raccorder la VMC sur un conduit de fumée ; qualité de l'air. **Raccordement électrique du caisson : intervenant **habilité** (NF C 15-100) ; travail en **hauteur** (combles/toiture) sécurisé ; **ne jamais raccorder une VMC sur un conduit de fumée** ; hygiène (filtres/réseaux — qualité de l'air).** `[B]`

## Cadre & suites
- **Normes** : installations de ventilation mécanique **DTU 68.3** ; aération des logements (**arrêté du 24 mars 1982**) ; installation électrique **NF C 15-100** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Relations Climatisation** : `cite-carte` → [entretenir-climatiseur](../../../professions/climatisation/cards/entretenir-climatiseur.md)

## Relations & tags
- **Tags** : `metier:ventilation equipement:vmc equipement:caisson famille:fluides sous-famille:ventilation intervention:comprendre cluster:ventilation-simple-flux cluster:ventilation-double-flux cluster:vmc cluster:reseaux-aerauliques type:principe`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
