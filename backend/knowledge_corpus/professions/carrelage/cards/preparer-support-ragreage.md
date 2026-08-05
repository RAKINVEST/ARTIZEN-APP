# Préparer le support (ragréage, primaire)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `preparer-support-ragreage` |
| Titre | Préparer le support (ragréage, primaire) |
| Profession | `metier:carrelage` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:carrelage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : préparer le support : contrôle, **ragréage local** et **primaire d'accrochage** avant la pose collée. `[C]`
- **Résumé** : contrôler le support (planéité, cohésion, humidité, âge/type), appliquer un **primaire d'accrochage**, réaliser un **ragréage** local (ou pleine surface) pour la planéité, en tenant compte d'un éventuel **plancher chauffant** (mise en chauffe préalable) ; en rénovation, **diagnostic amiante** (colles anciennes). `[C]` ⟦primaire/ragréage selon support à confirmer⟧

## Réalisation
- **Étapes** :
  1. Contrôler support (planéité/cohésion/humidité). `[C]` → [controle-support-amiante-avant-pose](../../../procedures/carrelage/controle-support-amiante-avant-pose.md)
  2. Appliquer **primaire d'accrochage** ; **ragréage** (planéité). `[C]`
  3. **Plancher chauffant** : mise en chauffe/arrêt préalables. `[C]` → [purger-plancher-chauffant](../../../professions/chauffage/cards/purger-plancher-chauffant.md)
  4. Rénovation : **diagnostic amiante** (colles). `[A]`
- **Points critiques** : support **plan/cohésif/sec** (85 % du résultat) ; primaire adapté ; plancher chauffant géré ; **amiante** en rénovation.
- **Sécurité** : poussières (ragréage/silice) ; électricité (plancher chauffant) ; amiante. **Poussières de découpe (silice cristalline)** : couper à l'**eau / aspiration**, masque adapté — risque respiratoire (silicose). **Projections** (éclats de carreau/colle) : lunettes. **Manutention des carreaux** (lourds, **grands formats**) : ventouses/binôme — TMS. **Coupures** (carreaux, coupe-carreaux, disque diamant) : gants. **Travail à genoux** (pose au sol prolongée) : genouillères — **TMS**. **Électricité** : avant d'intervenir en **zone équipée** (plancher chauffant, boîtes), repérer/consigner — ne pas percer un câble/tube chauffant (NF C 15-100). **Glissance** : sols mouillés/collés pendant les travaux → baliser, chaussures adaptées. **Amiante en rénovation** : d'anciennes **colles/ragréages** peuvent contenir de l'amiante → **diagnostic avant travaux** ; en présence d'amiante, **arrêt**, retrait réservé à une **entreprise certifiée** (**jamais ici**). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : pose collée des revêtements céramiques et pierres naturelles **DTU 52.2** ; pose scellée **DTU 52.1** ; électricité (plancher chauffant / zones équipées) **NF C 15-100** ; **CPT** CSTB (grands formats, SEL sous carrelage), classement **UPEC** et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Pose** : `cite-carte` → [poser-carrelage-colle](poser-carrelage-colle.md)

## Relations & tags
- **Tags** : `metier:carrelage famille:finition sous-famille:carrelage intervention:realiser cluster:preparation-des-supports cluster:ragreage-local cluster:primaire-d-accrochage complexite:moyenne type:realisation securite:silice relation:chauffage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
