# Phrase — normes & réglementation bardage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-bardage-reference` |
| Titre | Phrase — normes & réglementation bardage |
| Profession | `metier:bardage` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:bardage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos bardages sont mis en œuvre selon les règles de l'art : bardage **bois** selon le **DTU 41.2**, sur support (**DTU 20.1**) ; les bardages composite/fibres-ciment/métalliques/terre cuite sont posés sous **Avis Technique**. » `[C]` ⟦versions/AT exacts à valider par un expert⟧

> **Réglementation** : un bardage modifie l'aspect → **déclaration préalable** d'urbanisme (contraintes **ABF**) ; règles **incendie** (propagation) selon la hauteur du bâtiment. `[C]` ⟦à confirmer selon commune/projet⟧

> **Relations inter-Livres** : le bardage comme *option de revêtement* est vu côté **Façade** ; en peau d'**Isolation Extérieure** (ITE ventilée) ; s'appuie sur la **Charpente** (support/ossature) et rejoint la **Zinguerie** (couronnement/bavettes). `[C]`

## Cadre
- **Normes** : revêtements extérieurs en bois (bardage) **DTU 41.2** ; support en maçonnerie **DTU 20.1** ; bardages composite/fibres-ciment/métallique/terre cuite sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [poser-bardage-rapporte](../../professions/facade/cards/poser-bardage-rapporte.md).
- **Tags** : `metier:bardage famille:enveloppe type:phrase usage:normes cluster:normes cluster:reglementation relation:facade relation:isolation-exterieure relation:charpente relation:zinguerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
