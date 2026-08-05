# Phrase — normes & réglementation ramonage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-ramonage` |
| Titre | Phrase — normes & réglementation ramonage |
| Profession | `metier:ramonage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ramonage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos prestations de ramonage / fumisterie suivent les règles de l'art (**DTU 24.1** — évacuation des produits de combustion ; **DTU 24.2** — âtrerie) : tubage inox (**NF EN 1856**), tirage dimensionné (**NF EN 13384**), et **ramonage réglementaire** avec **certificat** (Règlement sanitaire départemental). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Frontières** : l'**appareil** de chauffage et son **raccordement gaz/hydraulique** relèvent du **Chauffagiste**, la **souche/sortie de toit** du **Couvreur**, le **conduit maçonné** du **Maçon**, le **diagnostic** (dont amiante → Désamiantage) du **Diagnostiqueur** — métiers distincts, jamais absorbés. `[C]`

> **Sécurité** : le **monoxyde de carbone** et le **feu de conduit** sont des risques mortels ; aucune opération réservée/dangereuse n'est décrite pas à pas. `[C]`

## Cadre
- **Normes** : évacuation des produits de combustion / fumisterie **DTU 24.1** ; âtrerie (cheminées/foyers) **DTU 24.2** ; conduits métalliques **NF EN 1856**, dimensionnement / tirage **NF EN 13384**, obligation de ramonage et **certificat** (**Règlement sanitaire départemental**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [principe-ramonage](../../professions/ramonage/cards/principe-ramonage.md).
- **Tags** : `metier:ramonage famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:chauffage relation:couverture relation:maconnerie relation:diagnostic relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
