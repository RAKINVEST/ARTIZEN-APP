# Préparer le support avant pose de sol souple

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `preparer-support-sol` |
| Titre | Préparer le support avant pose de sol souple |
| Profession | `metier:revetements-sol` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:revetements-sol` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : préparer le support : contrôle, **ragréage** (interface) et primaire avant pose — en vérifiant l'amiante en rénovation. `[C]`
- **Résumé** : contrôler le support (planéité, **cohésion**, **humiditérésiduelle** — mesure), appliquer un **primaire** et un **ragréage** (interface commune avec le carrelage) pour un fond lisse ; en rénovation, **diagnostic amiante** de l'ancien revêtement/colle avant toute dépose. `[C]` ⟦ragréage/humidité admissible selon revêtement à confirmer⟧

## Réalisation
- **Étapes** :
  1. Contrôler support (planéité/cohésion/**humidité**). `[C]`
  2. **Primaire** + **ragréage** (interface, fond lisse). `[C]` → [preparer-support-ragreage](../../../professions/carrelage/cards/preparer-support-ragreage.md)
  3. Rénovation : **diagnostic amiante** avant dépose. `[A]` → [diagnostic-amiante-depose-ancien-sol](../../../procedures/revetements-sol/diagnostic-amiante-depose-ancien-sol.md)
  4. Support **sec/lisse** avant pose. `[C]`
- **Points critiques** : **humidité résiduelle** maîtrisée (sinon décollement) ; fond lisse (les défauts marquent le souple) ; **amiante** en rénovation.
- **Sécurité** : poussières (ragréage/silice) ; amiante ; COV (primaire). **Amiante des anciens revêtements** : anciennes **dalles vinyle-amiante** et **colles bitumineuses** (bâti ancien) = source fréquente d'amiante → **diagnostic amiante avant travaux obligatoire** ; en présence d'amiante, **ne pas déposer / poncer / gratter**, **arrêt** → retrait réservé à une **entreprise certifiée** (**jamais ici**). **Poussières** (préparation/ragréage/ponçage = silice) : masque/aspiration. **Colles et COV / solvants** : produits **faible COV**, **ventilation** pendant/après (locaux confinés), EPI — risque respiratoire / **inflammabilité** (certaines colles). **Manutention** (rouleaux/dalles lourds) : binôme — **TMS** ; **travail à genoux** (genouillères). **Découpes** (cutter/guillotine) : coupures (gants). **Électricité** : avant découper/percer (sols techniques, gaines), repérer/consigner (NF C 15-100). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : revêtements de sol PVC collés **DTU 53.2** ; revêtements textiles / moquettes **DTU 53.1** ; pose flottante des sols stratifiés **DTU 51.11** (interface) ; électricité (avant découpe/percement, sols techniques) **NF C 15-100** ; classement **UPEC**, étiquetage **COV** et diagnostic **amiante** (anciennes dalles/colles) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Pose collée** : `cite-carte` → [poser-sol-pvc-vinyle-colle](poser-sol-pvc-vinyle-colle.md)

## Relations & tags
- **Tags** : `metier:revetements-sol famille:finition sous-famille:revetements-sol intervention:realiser cluster:preparation-des-supports cluster:ragreage complexite:moyenne type:realisation securite:amiante relation:carrelage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
