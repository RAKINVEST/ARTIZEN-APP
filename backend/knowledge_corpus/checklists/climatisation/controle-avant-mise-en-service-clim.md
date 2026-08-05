# Contrôle avant mise en service climatiseur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-avant-mise-en-service-clim` |
| Titre | Contrôle avant mise en service climatiseur |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:climatisation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] Fixations des unités intérieure/extérieure. `[C]`
- [ ] **Évacuation des condensats** avec pente/siphon. `[C]`
- [ ] Raccordement électrique conforme (intervenant habilité). `[A]`
- [ ] **Tirage au vide + étanchéité frigorifère** par un attesté F-Gaz. `[A]`
- [ ] Implantation unité ext. dégagée. `[C]`
- [ ] Paramètres de régulation renseignés. `[C]` ⟦selon fabricant⟧

## Cadre
- **Normes** : climatiseurs à détente directe **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [mettre-en-service-split](../../professions/climatisation/cards/mettre-en-service-split.md).
- **Tags** : `metier:climatisation equipement:climatiseur famille:fluides sous-famille:climatisation type:checklist cluster:mise-en-service cluster:controle`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
