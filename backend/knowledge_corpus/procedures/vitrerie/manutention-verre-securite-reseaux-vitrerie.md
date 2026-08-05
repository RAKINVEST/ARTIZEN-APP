# Manutention, verre de sécurité & réseaux avant travaux de vitrerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `manutention-verre-securite-reseaux-vitrerie` |
| Titre | Manutention, verre de sécurité & réseaux avant travaux de vitrerie |
| Profession | `metier:vitrerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Sécuriser la manutention du verre, garantir le bon **verre de sécurité** et le percement — sans retrait d'amiante. `[A]`

## Étapes
1. **Manutention** : **ventouses** adaptées, binôme/levage ; vitrage **debout** sur chevalet, calé/sanglé (transport/stockage). `[A]`
2. **Coupures** : gants anti-coupure, manches longues ; évacuation immédiate des éclats. `[A]`
3. **Verre de sécurité selon l'usage** : trempé/feuilleté obligatoire (allège/porte/garde-corps/toiture). `[A]` → [poser-vitrage-securite-garde-corps](../../professions/vitrerie/cards/poser-vitrage-securite-garde-corps.md)
4. **Hauteur** : échafaudage/nacelle/harnais (vitrines/verrières). `[A]`
5. **Repérer les réseaux** avant percement/scellement. `[A]`
6. **Mastics anciens** : **diagnostic amiante** ; suspect → **arrêt**, retrait = **certifié**. `[A]` `relation:desamiantage`

## Cadre
- **Normes** : travaux de **vitrerie-miroiterie** **DTU 39** ; menuiseries métalliques recevant le vitrage (**interface**) **DTU 37.1** ; verre de sécurité trempé / feuilleté (**NF EN 12150 / NF EN 14449 / ISO 12543**), vitrage isolant **NF EN 1279**, résistance au choc **NF EN 12600**, garde-corps **NF P01-012** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [poser-remplacer-vitrage](../../professions/vitrerie/cards/poser-remplacer-vitrage.md).
- **Tags** : `metier:vitrerie famille:specialises sous-famille:securite intervention:securiser cluster:manutention cluster:verre-securite type:procedure securite:coupure securite:amiante relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
