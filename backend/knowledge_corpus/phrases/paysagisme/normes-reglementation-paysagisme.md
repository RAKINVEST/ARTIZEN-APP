# Phrase — normes & réglementation paysagisme

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-paysagisme` |
| Titre | Phrase — normes & réglementation paysagisme |
| Profession | `metier:paysagisme` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:paysagisme` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos aménagements suivent les **Règles professionnelles des travaux du paysage** (UNEP) : sols et supports de culture (**NF U44-551**), gestion des eaux pluviales (**DTU 60.11**, infiltration privilégiée), petits ouvrages maçonnés (**DTU 20.1**), emploi **encadré** des produits phytosanitaires (**Certiphyto**, ZNT) et respect des **périodes de taille** (biodiversité). » `[C]` ⟦versions/exigences exactes à valider par un expert⟧

> **Frontières** : l'**arrosage automatique**, les **clôtures** et les **terrasses bois** sont des **activités distinctes** (non encore construites) ; la **maçonnerie** structurelle relève de la **Maçonnerie**, le **terrassement** lourd et le **réseau EP** enterré du **Terrassement / VRD** — Livres existants. `[C]`

> **Interface** : le **retrait d'amiante** (rénovation → Désamiantage) et l'**élagage grimpé** (cordiste) ne sont **jamais réalisés ici**. `[C]`

## Cadre
- **Normes** : petits ouvrages maçonnés / soutènements légers (**interface** maçonnerie) **DTU 20.1** ; évacuation / gestion des **eaux pluviales** (**interface**) **DTU 60.11** ; **Règles professionnelles des travaux du paysage** (UNEP/QUALIPAYSAGE), supports de culture **NF U44-551**, réglementation **phytosanitaire** (Certiphyto, ZNT) et **périodes de taille** (Code de l'environnement, nidification) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [gerer-eaux-drainage-paysager](../../professions/paysagisme/cards/gerer-eaux-drainage-paysager.md).
- **Tags** : `metier:paysagisme famille:specialises type:phrase usage:normes cluster:normes cluster:reglementation relation:arrosage relation:cloture relation:terrasse-bois relation:maconnerie relation:vrd relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
