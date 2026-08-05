# Eau trouble / contaminée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `eau-trouble-contaminee` |
| Titre | Eau trouble / contaminée |
| Profession | `metier:forage` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:forage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Eau **trouble**, colorée, odeur, ou **analyse non conforme** (bactério/nitrates). `[C]`

> Ne pas consommer une eau non contrôlée ; **analyse obligatoire** avant usage alimentaire. `[A]`

## Causes probables
1. **Protection sanitaire** défaillante (eaux de surface/polluants). `[C]` → [realiser-tete-protection-sanitaire](../../professions/forage/cards/realiser-tete-protection-sanitaire.md)
2. **Cimentation annulaire** absente → communication de nappes. `[C]` → [tuber-equiper-forage](../../professions/forage/cards/tuber-equiper-forage.md)
3. Crépine/développement insuffisant (fines). `[C]`

## Résolution
- Rétablir la protection sanitaire/cimentation, **désinfecter**, refaire analyser ; usage restreint tant que non conforme. `[A]`

## Cadre
- **Normes** : puits traditionnel maçonné (margelle/cuvelage) **DTU 20.1** ; alimentation électrique des pompes immergées **NF C 15-100** ; forage d'eau selon les règles de l'art (**NF X10-999**), réglementation (**Code de l'environnement** — loi sur l'eau, déclaration en mairie) et qualité de l'eau (**arrêté du 11 janvier 2007**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [realiser-tete-protection-sanitaire](../../professions/forage/cards/realiser-tete-protection-sanitaire.md).
- **Tags** : `metier:forage famille:gros-oeuvre sous-famille:forage probleme:contamination cluster:protection-sanitaire cluster:diagnostic type:diagnostic securite:nappe`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
