# Équilibrer un circuit de chauffage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `equilibrer-circuit-chauffage` |
| Titre | Équilibrer un circuit de chauffage |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:reseau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : répartir le débit entre émetteurs pour une chauffe homogène et un bon rendement. `[C]`
- **Résumé** : régler les tés de réglage / débiteurs par émetteur ou boucle, mesurer les écarts de température départ/retour, ajuster itérativement jusqu'à homogénéité. `[C]` ⟦méthode/valeurs à confirmer⟧

## Réalisation
- **Étapes** :
  1. S'assurer d'un circuit **purgé** et **désemboué**. `[C]` → [desembouer-circuit-chauffage](desembouer-circuit-chauffage.md)
  2. Repérer tés de réglage / débiteurs (radiateurs ou collecteur plancher). `[C]`
  3. Mesurer l'écart départ/retour par émetteur/boucle. `[C]`
  4. Ajuster itérativement pour homogénéiser (les plus proches plus fermés). `[C]`
  5. Contrôler le confort et le rendement. `[C]` → [controle-avant-saison-chauffe](../../../checklists/chauffage/controle-avant-saison-chauffe.md)
- **Points critiques** : circuit propre préalable ; réglage itératif ; ne pas trop étrangler (bruit/débit). `[C]`
- **Sécurité** : eau chaude ; éléments chauds. `[B]`

## Cadre & suites
- **Normes** : sécurité chauffage central **DTU 65.11** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Interventions liées** : `cite-carte` → [purger-radiateur](purger-radiateur.md)

## Relations & tags
- **Tags** : `metier:chauffage famille:fluides sous-famille:reseau intervention:regler intervention:equilibrer equipement:circuit probleme:desequilibre complexite:avancee type:reglage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
