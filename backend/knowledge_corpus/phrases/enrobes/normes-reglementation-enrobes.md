# Phrase — normes & réglementation enrobés / voirie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-reglementation-enrobes` |
| Titre | Phrase — normes & réglementation enrobés / voirie |
| Profession | `metier:enrobes` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:enrobes` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos travaux d'enrobés respectent les règles de l'art : exécution des assises et couches (**NF P 98-150**), mélanges bitumineux (**NF EN 13108**), sur un support préparé (**DTU 12**) ; voirie légère en béton selon le **DTU 13.3**. » `[C]` ⟦versions/formules exactes à valider par un expert⟧

> **Réglementation sécurité** : **signalisation temporaire** (IISR 8e partie), autorisation de voirie / arrêté de circulation ; **fumées de bitume** (prévention, VLEP). `[C]` ⟦à confirmer selon voie/chantier⟧

> **Relations inter-Livres** : les enrobés reposent sur la **plateforme** du **Terrassement** et complètent la **VRD** (bordures/caniveaux, réseaux). `[C]`

## Cadre
- **Normes** : support/plateforme **DTU 12** ; voirie légère en béton (dallage) **DTU 13.3** ; enrobés hydrocarbonés **NF P 98-150** / mélanges bitumineux **NF EN 13108** et signalisation temporaire (**IISR 8e partie**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [poser-bordures-caniveaux](../../professions/vrd/cards/poser-bordures-caniveaux.md).
- **Tags** : `metier:enrobes famille:gros-oeuvre type:phrase usage:normes cluster:normes cluster:reglementation relation:vrd relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
