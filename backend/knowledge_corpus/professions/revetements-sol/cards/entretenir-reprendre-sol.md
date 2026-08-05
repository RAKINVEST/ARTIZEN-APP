# Entretenir / reprendre un revêtement de sol

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-reprendre-sol` |
| Titre | Entretenir / reprendre un revêtement de sol |
| Profession | `metier:revetements-sol` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:revetements-sol` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir un revêtement et réaliser des **reprises** (remplacement de lé/de dalle, raccords). `[C]`
- **Résumé** : adapter l'**entretien** au revêtement (méthode/produits ; éviter l'excès d'eau sur stratifié), diagnostiquer les défauts (usure, décollement, joints), réaliser des **reprises** (découper/remplacer un lé ou une dalle, resouder un joint PVC) en respectant le même produit, et planifier la réfection ; en dalles amovibles, remplacement aisé. `[C]`

## Réalisation
- **Étapes** :
  1. **Entretien** adapté (méthode/produits ; pas d'excès d'eau). `[C]` → [controle-maintenance-sol](../../../checklists/revetements-sol/controle-maintenance-sol.md)
  2. Diagnostiquer les défauts (usure/décollement/joints). `[C]` → [usure-marque-revetement](../../../diagnostics/revetements-sol/usure-marque-revetement.md)
  3. **Reprises** : même produit ; ressouder joint PVC. `[C]`
  4. Planifier la réfection (usure/support). `[C]`
- **Points critiques** : entretien adapté au revêtement (l'eau nuit au stratifié) ; reprise avec le **même produit** ; traiter la cause des défauts.
- **Sécurité** : COV (produits) ; genoux/TMS ; coupures (reprise). **Amiante des anciens revêtements** : anciennes **dalles vinyle-amiante** et **colles bitumineuses** (bâti ancien) = source fréquente d'amiante → **diagnostic amiante avant travaux obligatoire** ; en présence d'amiante, **ne pas déposer / poncer / gratter**, **arrêt** → retrait réservé à une **entreprise certifiée** (**jamais ici**). **Poussières** (préparation/ragréage/ponçage = silice) : masque/aspiration. **Colles et COV / solvants** : produits **faible COV**, **ventilation** pendant/après (locaux confinés), EPI — risque respiratoire / **inflammabilité** (certaines colles). **Manutention** (rouleaux/dalles lourds) : binôme — **TMS** ; **travail à genoux** (genouillères). **Découpes** (cutter/guillotine) : coupures (gants). **Électricité** : avant découper/percer (sols techniques, gaines), repérer/consigner (NF C 15-100). **Arrêt immédiat en cas de danger.** `[A]`

## Cadre & suites
- **Normes** : revêtements de sol PVC collés **DTU 53.2** ; revêtements textiles / moquettes **DTU 53.1** ; pose flottante des sols stratifiés **DTU 51.11** (interface) ; électricité (avant découpe/percement, sols techniques) **NF C 15-100** ; classement **UPEC**, étiquetage **COV** et diagnostic **amiante** (anciennes dalles/colles) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-solier](../../../kits/revetements-sol/kit-solier.md)

## Relations & tags
- **Tags** : `metier:revetements-sol famille:finition sous-famille:revetements-sol intervention:entretenir intervention:reparer cluster:reprises cluster:entretien cluster:maintenance complexite:moyenne type:entretien securite:cov`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
