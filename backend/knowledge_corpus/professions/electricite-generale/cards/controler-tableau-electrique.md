# Contrôler un tableau électrique

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-tableau-electrique` |
| Titre | Contrôler un tableau électrique |
| Profession | `metier:electricite-generale` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:tableau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler l'état et la conformité apparente d'un tableau électrique (protections, repérage, serrage, GTL) — **par un électricien qualifié**. `[C]`
- **Résumé** : vérifier la présence des protections requises (différentiels, disjoncteurs), le repérage, le serrage des connexions et les traces d'échauffement, sans intervention sous tension. `[C]`

## Réalisation
- **Étapes** :
  1. Contrôle visuel : repérage, protections, absence d'échauffement. `[C]`
  2. Vérifier la présence des **différentiels 30 mA** et la répartition des circuits. `[B]` ⟦exigences NF C 15-100 à confirmer⟧
  3. Consigner pour contrôler le **serrage** des connexions. `[A]` → [consignation-electrique](../../../procedures/electricite-generale/consignation-electrique.md)
  4. Consigner les anomalies et proposer une mise en conformité. `[C]` → [controle-conformite-installation](../../../checklists/electricite-generale/controle-conformite-installation.md)
- **Points critiques** : protections des personnes (30 mA) ; repérage ; échauffements = risque incendie. `[B]`
- **Sécurité** : serrage = consignation ; qualification requise. **Intervention sur installation électrique : **consignation** et **habilitation électrique** requises (NF C 18-510) ; **vérifier l'absence de tension (VAT)** avant tout contact. Une opération au **tableau**, un **raccordement** ou toute opération **sous tension** relèvent d'un professionnel **habilité**.** `[A]`

## Cadre & suites
- **Normes** : installations électriques BT **NF C 15-100** ; opérations/consignation **NF C 18-510** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Protections** : `cite-carte` → [remplacer-disjoncteur](remplacer-disjoncteur.md)

## Relations & tags
- **Tags** : `metier:electricite-generale equipement:tableau famille:electricite sous-famille:tableau intervention:controler cluster:tableau cluster:conformite cluster:controle cluster:maintenance complexite:avancee type:controle securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
