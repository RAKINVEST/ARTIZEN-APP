# Phrase — normes & réglementation ITE

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-ite` |
| Titre | Phrase — normes & réglementation ITE |
| Profession | `metier:isolation-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation » / « RE2020 »)
> « Nos systèmes d'ITE (ETICS) sont mis en œuvre selon leur **Avis Technique** (référentiel **CPT 3035** / **ETAG 004**), sur support maçonné (**DTU 20.1**) ; en variante ventilée à bardage bois, selon le **DTU 41.2**. » `[C]` ⟦références/versions exactes à valider par un expert⟧

> **Réglementation / RE2020** : performances visées selon la **RE2020** (neuf) et la réglementation énergétique de l'existant ; aides (**MaPrimeRénov'**) conditionnées à un artisan **RGE** et à des critères de R ; une ITE modifie l'aspect → **déclaration préalable** d'urbanisme (contraintes **ABF**). `[C]` ⟦à confirmer selon dispositif/commune⟧

> **Relations inter-Livres** : complémentaire du Livre **Isolation** (théorie thermique R/λ, ITI, `relation:isolation`) et distinct du Livre **Façade** (enduits sur maçonnerie) ; interfaces **Couverture**/**Charpente** (débords) et **Ventilation** (entrées d'air). `[C]`

## Cadre
- **Normes** : systèmes **ETICS** relevant du **CPT 3035 (CSTB)** / **ETAG 004–EAD** et d'**Avis Techniques** ⟦cadre exact à confirmer⟧ ; support en maçonnerie **DTU 20.1** ; ITE ventilée à bardage rapporté bois **DTU 41.2** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [principe-isolation](../../professions/isolation/cards/principe-isolation.md).
- **Tags** : `metier:isolation-exterieure famille:enveloppe type:phrase usage:normes cluster:normes cluster:reglementation cluster:re2020 relation:isolation relation:facade relation:couverture relation:charpente relation:ventilation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
