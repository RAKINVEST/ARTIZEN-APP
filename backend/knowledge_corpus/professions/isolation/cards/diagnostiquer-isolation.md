# Diagnostiquer une isolation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `diagnostiquer-isolation` |
| Titre | Diagnostiquer une isolation |
| Profession | `metier:isolation` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : diagnostiquer l'état et les défauts d'une isolation (déperditions, tassement, humidité, ponts thermiques). `[C]`
- **Résumé** : observer les indices (parois froides, condensation, factures), repérer tassement/dégradation et ponts thermiques (au besoin **thermographie**), qualifier la cause et orienter la reprise. `[C]` ⟦méthode/thermographie à confirmer⟧

## Réalisation
- **Étapes** :
  1. Rechercher **déperditions**/parois froides, condensation. `[C]` → [deperdition-pont-thermique](../../../diagnostics/isolation/deperdition-pont-thermique.md)
  2. Contrôler **tassement/dégradation** (combles). `[C]` → [isolant-tasse-degrade](../../../diagnostics/isolation/isolant-tasse-degrade.md)
  3. Rechercher **humidité/moisissure** (pare-vapeur défaillant). `[C]` → [condensation-moisissure-isolation](../../../diagnostics/isolation/condensation-moisissure-isolation.md)
  4. Orienter la reprise (continuité, remplacement). `[C]`
- **Points critiques** : distinguer défaut d'isolant, de pare-vapeur ou de **ventilation** ; ne pas isoler sur désordre d'humidité.
- **Sécurité** : poussières/fibres ; hauteur (combles) ; humidité/moisissures (respiratoire). **Poussières et fibres** (laines minérales/bois, ouate) : risque **respiratoire** — **EPI adaptés** (masque FFP adapté, combinaison, gants, lunettes), ventilation du chantier. **Travail en hauteur** (combles, murs) : **stabilité des supports** (circuler uniquement sur zones porteuses — risque de **chute à travers le plafond**). **Humidité / moisissures** : traiter la cause **avant** d'isoler (jamais isoler sur support humide/moisi). **Arrêt immédiat en cas de danger.** Une intervention relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : isolation des combles par soufflage **DTU 45.10** ; isolation thermique de combles **DTU 45.11** ; doublage / plaques de plâtre (isolation intérieure) **DTU 25.41** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [controle-maintenance-isolation](../../../checklists/isolation/controle-maintenance-isolation.md)

## Relations & tags
- **Tags** : `metier:isolation famille:enveloppe sous-famille:isolation intervention:diagnostiquer intervention:controler cluster:diagnostic cluster:controle cluster:ponts-thermiques complexite:moyenne type:diagnostic securite:respiratoire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
