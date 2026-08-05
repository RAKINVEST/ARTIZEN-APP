# Phrase — normes & réglementation menuiserie extérieure

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-menuiserie-reference` |
| Titre | Phrase — normes & réglementation menuiserie extérieure |
| Profession | `metier:menuiserie-exterieure` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:menuiserie-exterieure` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos menuiseries extérieures sont posées selon le **DTU 36.5** (fenêtres et portes extérieures), le **DTU 39** (vitrerie) et le **DTU 34.1** (fermetures/volets), avec un **classement AEV** adapté à l'exposition. » `[C]` ⟦versions/classement exacts à valider par un expert⟧

> **Réglementation** : performance thermique (**Uw**) selon **RE2020** / rénovation ; aides (**MaPrimeRénov'**) via artisan **RGE** ; remplacement modifiant l'aspect → **déclaration préalable** (contraintes **ABF**). `[C]` ⟦critères à confirmer selon dispositif/commune⟧

> **Relations inter-Livres (frontières)** : calfeutrement/joints → **Façade** ; tableau → **Isolation Extérieure** ; appui/seuil → **Étanchéité** ; pont thermique/étanchéité à l'air → **Isolation** ; encadrement → **Bardage** ; motorisation → **Électricité**. `[C]`

## Cadre
- **Normes** : mise en œuvre des fenêtres et portes extérieures **DTU 36.5** ; vitrerie-miroiterie **DTU 39** ; fermetures / volets **DTU 34.1** ; performance **classement AEV (Air-Eau-Vent)** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [refaire-joints-facade](../../professions/facade/cards/refaire-joints-facade.md).
- **Tags** : `metier:menuiserie-exterieure famille:enveloppe type:phrase usage:normes cluster:normes cluster:reglementation relation:facade relation:isolation-exterieure relation:etancheite relation:isolation relation:bardage relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
