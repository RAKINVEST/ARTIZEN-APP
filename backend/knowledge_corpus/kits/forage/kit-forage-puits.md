# Kit forage / puits

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-forage-puits` |
| Titre | Kit forage / puits |
| Profession | `metier:forage` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:forage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée (contrôle/entretien ; forage = entreprise spécialisée)
- **Sonde de niveau** (rabattement), débitmètre, flacons d'**analyse d'eau**. `[C]`
- Produit de **désinfection** de l'ouvrage ; brosse/outillage de développement de crépine. `[C]`
- **Capot verrouillable** / dispositif de protection de tête. `[C]`
- **EPI** : détecteur multigaz + harnais/treuil (si accès confiné), gants, lunettes. `[A]`

## Cadre
- **Normes** : puits traditionnel maçonné (margelle/cuvelage) **DTU 20.1** ; alimentation électrique des pompes immergées **NF C 15-100** ; forage d'eau selon les règles de l'art (**NF X10-999**), réglementation (**Code de l'environnement** — loi sur l'eau, déclaration en mairie) et qualité de l'eau (**arrêté du 11 janvier 2007**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [entretenir-controler-forage](../../professions/forage/cards/entretenir-controler-forage.md).
- **Tags** : `metier:forage famille:gros-oeuvre sous-famille:forage type:kit cluster:entretien cluster:protection-sanitaire equipement:sonde-de-niveau`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
