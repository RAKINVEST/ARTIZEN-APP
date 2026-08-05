# Contrôle / maintenance vitrerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-vitrerie` |
| Titre | Contrôle / maintenance vitrerie |
| Profession | `metier:vitrerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:vitrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Vitrages** : pas de fissure/casse ; tenue et calage OK. `[C]`
- [ ] **Mastics/joints** : étanchéité ; parcloses en place. `[C]`
- [ ] **Double vitrage** : pas d'**embuage** (joint isolant). `[C]`
- [ ] **Verre de sécurité** conforme à l'usage (allège/porte/garde-corps). `[A]`
- [ ] **Garde-corps verre** : conformité/tenue (NF P01-012) ; structure = Métallerie. `[A]`
- [ ] Feuillure **drainée** ; rénovation : **amiante** (mastics anciens). `[C]`

## Cadre
- **Normes** : travaux de **vitrerie-miroiterie** **DTU 39** ; menuiseries métalliques recevant le vitrage (**interface**) **DTU 37.1** ; verre de sécurité trempé / feuilleté (**NF EN 12150 / NF EN 14449 / ISO 12543**), vitrage isolant **NF EN 1279**, résistance au choc **NF EN 12600**, garde-corps **NF P01-012** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [entretenir-diagnostiquer-vitrerie](../../professions/vitrerie/cards/entretenir-diagnostiquer-vitrerie.md).
- **Tags** : `metier:vitrerie famille:specialises sous-famille:vitrerie type:checklist cluster:maintenance cluster:verre-securite securite:coupure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
