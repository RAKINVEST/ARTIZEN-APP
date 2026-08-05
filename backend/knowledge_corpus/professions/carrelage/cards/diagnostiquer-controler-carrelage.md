# Diagnostiquer / contrôler un carrelage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `diagnostiquer-controler-carrelage` |
| Titre | Diagnostiquer / contrôler un carrelage |
| Profession | `metier:carrelage` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:carrelage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : diagnostiquer les désordres (décollement, fissures, joints) et contrôler planéité/glissance. `[C]`
- **Résumé** : repérer les **carreaux sonnant creux/décollés**, les **fissures** (carreau/joint), l'état des **joints** (souples/dégradés) et l'éventuelle **glissance**, qualifier la cause (collage, support, absence de joint souple, eau) et orienter la reprise. `[C]`

## Réalisation
- **Étapes** :
  1. Repérer **décollement** (sonne creux). `[C]` → [carreau-decolle-sonne-creux](../../../diagnostics/carrelage/carreau-decolle-sonne-creux.md)
  2. Contrôler **fissures** (carreau/joint). `[C]` → [fissure-carrelage-joint](../../../diagnostics/carrelage/fissure-carrelage-joint.md)
  3. Vérifier **joints** (souples/dégradés, étanchéité). `[C]` → [joint-degrade-infiltration](../../../diagnostics/carrelage/joint-degrade-infiltration.md)
  4. Contrôler planéité/glissance ; orienter la reprise. `[C]`
- **Points critiques** : distinguer défaut de collage / mouvement du support / absence de joint souple ; traiter la cause (eau/support).
- **Sécurité** : silice (reprise/découpe) ; genoux ; — **Poussières de découpe (silice cristalline)** : couper à l'**eau / aspiration**, masque adapté — risque respiratoire (silicose). **Projections** (éclats de carreau/colle) : lunettes. **Manutention des carreaux** (lourds, **grands formats**) : ventouses/binôme — TMS. **Coupures** (carreaux, coupe-carreaux, disque diamant) : gants. **Travail à genoux** (pose au sol prolongée) : genouillères — **TMS**. **Électricité** : avant d'intervenir en **zone équipée** (plancher chauffant, boîtes), repérer/consigner — ne pas percer un câble/tube chauffant (NF C 15-100). **Glissance** : sols mouillés/collés pendant les travaux → baliser, chaussures adaptées. **Amiante en rénovation** : d'anciennes **colles/ragréages** peuvent contenir de l'amiante → **diagnostic avant travaux** ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : pose collée des revêtements céramiques et pierres naturelles **DTU 52.2** ; pose scellée **DTU 52.1** ; électricité (plancher chauffant / zones équipées) **NF C 15-100** ; **CPT** CSTB (grands formats, SEL sous carrelage), classement **UPEC** et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-carreleur](../../../kits/carrelage/kit-carreleur.md)

## Relations & tags
- **Tags** : `metier:carrelage famille:finition sous-famille:carrelage intervention:diagnostiquer intervention:controler cluster:diagnostics cluster:joints complexite:moyenne type:diagnostic securite:silice`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
