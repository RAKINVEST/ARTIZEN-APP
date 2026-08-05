# Déboucher une évacuation sanitaire

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Confiance : A normes/fabricant · B technique · C terrain · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `deboucher-evacuation-sanitaire` |
| Titre | Déboucher une évacuation sanitaire |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:evacuation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : Rétablir l'écoulement d'une évacuation obstruée (siphon, canalisation) sans dégrader le réseau. `[C]`
- **Résumé** : Identifier la localisation du bouchon, tenter le démontage/nettoyage du siphon puis le furet ; proscrire les produits agressifs sur certains matériaux ; contrôler l'écoulement. `[C]`
- **Pré-requis** : accès au siphon / regard ; identification du matériau (`materiau:pvc`, `materiau:pehd`…). `[C]`
- **Difficulté** : `simple` à `moyenne` `[C]`
- **Temps moyen** : ~15–45 min `[C]` ⟦à confirmer⟧

## Ressources
- **Outillage** : `outil:nettoyage` (furet, ventouse), `outil:manuel`. `[C]`
- **Consommables** : sacs, protections, chiffons. `[C]`
- **Kit conseillé** : `utilise-kit` → [kit-evacuation](../../../kits/plomberie/kit-evacuation.md)

## Réalisation
- **Étapes** :
  1. Protéger la zone ; identifier le point d'accès (siphon, culotte, regard). `[C]`
  2. Démonter et nettoyer le **siphon** si accessible. `[C]`
  3. Sinon, passer le **furet** progressivement ; ne pas forcer sur les coudes. `[C]`
  4. Rincer abondamment et **contrôler l'écoulement**. `[C]`
  5. Remonter le siphon avec joints en bon état ; vérifier l'étanchéité. `[C]`
- **Contrôles** : `a-checklist` → [controle-etancheite](../../../checklists/plomberie/controle-etancheite.md)
- **Points critiques** : ne pas employer de **produit chimique agressif** sur certains plastiques/joints ; risque de projection. `[C]` ⟦à valider⟧
- **Sécurité** : EPI (gants, lunettes) ; ventilation ; risque biologique (eaux usées). `[B]`

## Cadre & suites
- **Normes** : évacuation des eaux usées — **DTU 60.1 / 60.11** (dimensionnement, pentes) `[B]` ⟦référence exacte/version à confirmer⟧.
- **Diagnostics liés** : `traite-diagnostic` → [evacuation-lente](../../../diagnostics/plomberie/evacuation-lente.md)
- **Maintenance** : nettoyage périodique des siphons. `[C]`

## Langage & réutilisation
- **Phrases associées** : `cite-phrase` → [reserve-acces-intervention](../../../phrases/plomberie/reserve-acces-intervention.md)
- **Retours terrain** : ⟦à collecter⟧

## Relations & tags
- **Relations** : `utilise-kit`, `a-checklist`, `traite-diagnostic`, `cite-phrase`.
- **Tags** : `metier:plomberie famille:fluides sous-famille:evacuation intervention:depanner intervention:nettoyer probleme:obstruction equipement:evier equipement:lavabo piece:cuisine piece:salle-de-bain urgence:rapide complexite:simple type:depannage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-02 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
