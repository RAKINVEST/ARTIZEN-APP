# Mesurer la continuité d'un circuit

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mesurer-continuite-circuit` |
| Titre | Mesurer la continuité d'un circuit |
| Profession | `metier:electricite-generale` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:mesures` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : vérifier la continuité électrique d'un conducteur/circuit **hors tension** au multimètre/contrôleur. `[C]`
- **Résumé** : installation **consignée**, mesurer la continuité (ohmmètre) des conducteurs, notamment le **conducteur de protection**, pour localiser une coupure. `[C]`

## Réalisation
- **Étapes** :
  1. **Consigner** + VAT (mesure hors tension). `[A]` → [consignation-electrique](../../../procedures/electricite-generale/consignation-electrique.md)
  2. Sélectionner la fonction continuité/ohmmètre. `[C]`
  3. Mesurer entre extrémités ; une valeur faible = continuité. `[C]`
  4. Localiser une **coupure** (valeur infinie) et tracer. `[C]`
- **Points critiques** : mesure **hors tension** impérative ; distinguer continuité et isolement. `[B]`
- **Sécurité** : installation consignée ; jamais de mesure de continuité sous tension. **Intervention sur installation électrique : **consignation** et **habilitation électrique** requises (NF C 18-510) ; **vérifier l'absence de tension (VAT)** avant tout contact. Une opération au **tableau**, un **raccordement** ou toute opération **sous tension** relèvent d'un professionnel **habilité**.** `[A]`

## Cadre & suites
- **Normes** : installations électriques BT **NF C 15-100** ; opérations/consignation **NF C 18-510** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Mise à la terre** : `cite-carte` → [controler-mise-a-la-terre](controler-mise-a-la-terre.md)

## Relations & tags
- **Tags** : `metier:electricite-generale famille:electricite sous-famille:mesures intervention:controler intervention:mesurer cluster:continuite cluster:mesures cluster:diagnostic complexite:moyenne type:controle securite:electrique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
