# Cloquage / écaillage de peinture

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `cloquage-ecaillage-peinture` |
| Titre | Cloquage / écaillage de peinture |
| Profession | `metier:peinture` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:peinture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Peinture qui **cloque**, **écaille**, se décolle. `[C]`

## Causes probables
1. **Humidité** / support non sec (support maçonné/plâtre humide). `[C]`
2. **Défaut d'adhérence** (support non préparé/gras/farinant, pas d'impression). `[C]` → [preparer-support-peinture](../../professions/peinture/cards/preparer-support-peinture.md)
3. **Incompatibilité** (glycéro sur aqueux, métal non protégé). `[C]` → [appliquer-impression](../../professions/peinture/cards/appliquer-impression.md)

## Résolution
- Traiter la cause (humidité), **décaper/poncer** le non adhérent, impression adaptée, refaire ; en rénovation → **plomb** (CREP). `[C]`

## Cadre
- **Normes** : travaux de peinture des bâtiments **DTU 59.1** ; électricité (dépose/protection des appareillages) **NF C 15-100** ; teneur en **COV** (**directive 2004/42/CE**, étiquetage émissions A+/A/B/C), diagnostic **plomb (CREP)** avant travaux (Code de la santé) et prévention (**INRS**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [preparer-support-peinture](../../professions/peinture/cards/preparer-support-peinture.md).
- **Tags** : `metier:peinture famille:finition sous-famille:peinture probleme:ecaillage cluster:preparation-des-supports cluster:diagnostics type:diagnostic securite:poussieres`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
