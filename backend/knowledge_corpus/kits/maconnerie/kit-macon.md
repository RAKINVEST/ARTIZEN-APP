# Kit maçon

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-macon` |
| Titre | Kit maçon |
| Profession | `metier:maconnerie` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:maconnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Truelle, taloche, auge, **niveau/fil à plomb**, cordeau, règle. `[C]`
- Malaxeur/bétonnière ; disqueuse à **aspiration** (silice) ; burineur. `[C]`
- Scellements (chimique/chevilles), fers d'armature (chaînage). `[C]`
- **EPI** : gants, **masque silice**, lunettes, protections antichute (hauteur). `[A]`

## Cadre
- **Normes** : ouvrages en maçonnerie de petits éléments **DTU 20.1** ; cloisons en maçonnerie **DTU 20.13** ; chaînages / éléments en béton **DTU 21** ; calcul **Eurocode 6 (NF EN 1996)** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [monter-mur-cloison](../../professions/maconnerie/cards/monter-mur-cloison.md).
- **Tags** : `metier:maconnerie famille:gros-oeuvre sous-famille:maconnerie type:kit cluster:mortiers cluster:scellements equipement:betonniere`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
