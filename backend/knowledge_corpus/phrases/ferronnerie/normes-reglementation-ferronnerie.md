# Phrase — normes & réglementation ferronnerie d'art

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-ferronnerie` |
| Titre | Phrase — normes & réglementation ferronnerie d'art |
| Profession | `metier:ferronnerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ferronnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos ouvrages de ferronnerie d'art allient savoir-faire de forge et règles de l'art : mise en œuvre métallique (**DTU 37.1**), garde-corps conformes (**NF P01-012**), assemblages et protection anticorrosion soignés (**NF EN 1090**, **NF EN ISO 12944**). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Distinction** : la **ferronnerie d'art** (ouvrages forgés ornementaux) se distingue strictement de la **serrurerie / métallerie courante** ([principe-serrurerie-metallerie](../../professions/serrurerie-metallerie/cards/principe-serrurerie-metallerie.md)) — activité existante, jamais absorbée. `[C]`

> **Interfaces réservées** : la **motorisation** d'un portail (→ Automatismes), le **vitrage** d'une marquise (→ Vitrerie), le **contrôle d'accès** (→ Contrôle d'accès) et le **retrait d'amiante/plomb** (→ Désamiantage) ne sont **jamais réalisés ici**. `[C]`

## Cadre
- **Normes** : ouvrages métalliques (mise en œuvre, **interface** métallerie) **DTU 37.1** ; garde-corps **NF P01-012** ; exécution des structures acier **NF EN 1090**, qualification de soudage **NF EN ISO 9606**, protection anticorrosion **NF EN ISO 12944** ; motorisation éventuelle d'un portail (**interface** Électricité) **NF C 15-100** ⟦EN 1090 / EN ISO 9606 / ISO 12944 et versions exactes en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [principe-serrurerie-metallerie](../../professions/serrurerie-metallerie/cards/principe-serrurerie-metallerie.md).
- **Tags** : `metier:ferronnerie famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:serrurerie-metallerie relation:automatismes-portails relation:vitrerie relation:controle-acces relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
