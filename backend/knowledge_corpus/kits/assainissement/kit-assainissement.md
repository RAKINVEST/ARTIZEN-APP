# Kit assainissement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-assainissement` |
| Titre | Kit assainissement |
| Profession | `metier:assainissement` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:assainissement` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée (contrôle depuis la surface privilégié)
- **Caméra d'inspection**, jeu de cannes de curage, lève-tampon. `[C]`
- **Détecteur multigaz** (O₂/**H₂S**/LIE), ventilateur/extracteur. `[A]`
- **Harnais + treuil** + trinôme de sécurité (si accès confiné). `[A]`
- **EPI** biologiques (gants, lunettes, combinaison), hygiène. `[A]`

## Cadre
- **Normes** : assainissement non collectif **DTU 64.1** ; évacuation EU/EP **DTU 60.11** ; mise en œuvre/essais des collecteurs **NF EN 1610**, réglementation ANC (**arrêté du 7 sept. 2009**, contrôle **SPANC**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [entretenir-vidanger-assainissement](../../professions/assainissement/cards/entretenir-vidanger-assainissement.md).
- **Tags** : `metier:assainissement famille:gros-oeuvre sous-famille:assainissement type:kit cluster:controle cluster:postes-de-relevage equipement:detecteur-multigaz`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
