# Bois vermoulu / trous / vermoulure

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `bois-vermoulu-trous-vrillure` |
| Titre | Bois vermoulu / trous / vermoulure |
| Profession | `metier:traitement-charpente` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:traitement-charpente` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Trous d'envol**, **vermoulure** (sciure fine), galeries, bois qui sonne creux, poussière sous la charpente. `[C]`

## Causes probables
1. **Insectes xylophages** à larves (capricorne, vrillette, lyctus). `[C]` → [identifier-insectes-xylophages](../../professions/traitement-charpente/cards/identifier-insectes-xylophages.md)
2. **Termites** (galeries internes discrètes, cordons) — réglementation. `[C]` → [diagnostiquer-attaques-biologiques](../../professions/traitement-charpente/cards/diagnostiquer-attaques-biologiques.md)
3. Attaque **ancienne inactive** (à distinguer). `[C]`

## Conduite à tenir
- Identifier l'espèce et l'**activité**, évaluer l'atteinte structurelle, maîtriser l'humidité ; traitement = **applicateur qualifié** (présentation). `[C]`

## Cadre
- **Normes** : charpente / structure bois traitée (**interface** charpente) **DTU 31.1** ; humidité / remédiation du bâti (**interface** maçonnerie) **DTU 20.1** ; classes d'emploi / risque biologique **NF EN 335**, durabilité **NF EN 350**, efficacité des produits de préservation **NF EN 599**, diagnostic **termites** (Code de la construction, déclaration en mairie), **mérule** (obligation d'information) et **Règlement Biocides UE 528/2012 / Certibiocide** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [identifier-insectes-xylophages](../../professions/traitement-charpente/cards/identifier-insectes-xylophages.md).
- **Tags** : `metier:traitement-charpente famille:specialises sous-famille:traitement-charpente probleme:xylophages cluster:insectes-xylophages cluster:diagnostic type:diagnostic securite:biocides`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
