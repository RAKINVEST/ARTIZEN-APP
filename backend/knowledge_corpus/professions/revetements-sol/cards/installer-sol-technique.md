# Installer un sol technique (plancher surélevé)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-sol-technique` |
| Titre | Installer un sol technique (plancher surélevé) |
| Profession | `metier:revetements-sol` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:revetements-sol` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer un **sol technique** (plancher surélevé à dalles amovibles) pour le passage des réseaux. `[C]`
- **Résumé** : poser les **vérins/plots** à niveau, les **dalles amovibles** (avec revêtement) formant un plenum pour les **réseaux** (élec/données/CVC), en assurant la stabilité, l'accessibilité et la mise à la terre éventuelle ; toute intervention électrique relève d'un **professionnel** (repérer/consigner avant découpe). `[C]` ⟦charge/hauteur de plenum selon usage à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser **vérins/plots** à niveau ; stabilité. `[C]`
  2. Poser **dalles amovibles** ; accès au **plenum** (réseaux). `[C]`
  3. Réseaux élec = **professionnel** ; repérer/consigner. `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
  4. Contrôler charge/planéité/accessibilité. `[C]`
- **Points critiques** : charge admissible / stabilité ; accessibilité des réseaux ; élec réservée (consignation avant découpe).
- **Sécurité** : **électricité** (réseaux) ; manutention (dalles) ; découpes. **Amiante des anciens revêtements** : anciennes **dalles vinyle-amiante** et **colles bitumineuses** (bâti ancien) = source fréquente d'amiante → **diagnostic amiante avant travaux obligatoire** ; en présence d'amiante, **ne pas déposer / poncer / gratter**, **arrêt** → retrait réservé à une **entreprise certifiée** (**jamais ici**). **Poussières** (préparation/ragréage/ponçage = silice) : masque/aspiration. **Colles et COV / solvants** : produits **faible COV**, **ventilation** pendant/après (locaux confinés), EPI — risque respiratoire / **inflammabilité** (certaines colles). **Manutention** (rouleaux/dalles lourds) : binôme — **TMS** ; **travail à genoux** (genouillères). **Découpes** (cutter/guillotine) : coupures (gants). **Électricité** : avant découper/percer (sols techniques, gaines), repérer/consigner (NF C 15-100). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : revêtements de sol PVC collés **DTU 53.2** ; revêtements textiles / moquettes **DTU 53.1** ; pose flottante des sols stratifiés **DTU 51.11** (interface) ; électricité (avant découpe/percement, sols techniques) **NF C 15-100** ; classement **UPEC**, étiquetage **COV** et diagnostic **amiante** (anciennes dalles/colles) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Support / niveau** : `cite-carte` → [preparer-support-sol](preparer-support-sol.md)

## Relations & tags
- **Tags** : `metier:revetements-sol famille:finition sous-famille:revetements-sol intervention:realiser cluster:sols-techniques complexite:avancee type:installation securite:electrique relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
