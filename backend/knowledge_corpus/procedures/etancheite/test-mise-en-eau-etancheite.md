# Test de mise en eau / contrôle d'étanchéité

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `test-mise-en-eau-etancheite` |
| Titre | Test de mise en eau / contrôle d'étanchéité |
| Profession | `metier:etancheite` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:etancheite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Vérifier l'étanchéité d'un ouvrage (réception ou recherche de fuite). `[C]`

## Étapes
1. Obturer les évacuations ; **mettre en eau** la surface (hauteur/durée maîtrisées). `[C]` ⟦protocole à confirmer⟧
2. Observer en sous-face l'apparition d'humidité. `[C]`
3. Contrôler soudures/relevés/points singuliers. `[C]` → [traiter-penetrations-points-singuliers](../../professions/etancheite/cards/traiter-penetrations-points-singuliers.md)
4. Vidanger ; consigner ; réparer si besoin. `[C]`

> **Attention surcharge** : la mise en eau ajoute un **poids** — vérifier la **stabilité du support**. `[B]`

## Cadre
- **Normes** : étanchéité des toitures-terrasses (support maçonnerie) **DTU 43.1** ; support acier **DTU 43.3** ; réfection des ouvrages d'étanchéité **DTU 43.5** ; SEL/résines sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [rechercher-fuite-etancheite](../../professions/etancheite/cards/rechercher-fuite-etancheite.md).
- **Tags** : `metier:etancheite famille:enveloppe sous-famille:etancheite intervention:controler cluster:controle cluster:recherche-de-fuite cluster:maintenance type:procedure securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
