# Phrase — normes & réglementation forage / puits

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-forage` |
| Titre | Phrase — normes & réglementation forage / puits |
| Profession | `metier:forage` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:forage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Réglementation » / « Normes »)
> « Nos forages et puits respectent les règles de l'art (**NF X10-999** forage d'eau ; puits maçonné **DTU 20.1** ; électricité des pompes **NF C 15-100**) et la réglementation : **déclaration en mairie**, **loi sur l'eau** (Code de l'environnement), qualité de l'eau (**arrêté du 11 janvier 2007**). » `[C]` ⟦versions/procédures exactes à valider par un expert⟧

> **Protection de la ressource** : **cimentation annulaire** et **protection sanitaire** obligatoires ; **désinfection** + **analyse d'eau** avant usage ; **rebouchage réglementaire** des ouvrages abandonnés (anti-pollution). `[C]`

> **Relations inter-Livres** : le forage partage le **Terrassement** (DICT/fouilles), l'**Électricité** (pompes, réservé), la **Plomberie** (réseau d'eau alimenté) et voisine la **Géothermie** (autre ouvrage de captage). `[C]`

## Cadre
- **Normes** : puits traditionnel maçonné (margelle/cuvelage) **DTU 20.1** ; alimentation électrique des pompes immergées **NF C 15-100** ; forage d'eau selon les règles de l'art (**NF X10-999**), réglementation (**Code de l'environnement** — loi sur l'eau, déclaration en mairie) et qualité de l'eau (**arrêté du 11 janvier 2007**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [controler-champ-de-captage](../../professions/geothermie/cards/controler-champ-de-captage.md).
- **Tags** : `metier:forage famille:gros-oeuvre type:phrase usage:normes cluster:normes cluster:reglementation cluster:hydrogeologie relation:terrassement relation:electricite-generale relation:plomberie relation:geothermie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
