# Déclaration réglementaire avant forage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `declaration-forage` |
| Titre | Déclaration réglementaire avant forage |
| Profession | `metier:forage` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Respecter les obligations administratives **avant** de forer/créer un puits. `[A]`

## Étapes
1. **Déclaration en mairie** (usage domestique — CGCT) avant travaux. `[A]` ⟦à confirmer⟧
2. **Loi sur l'eau** (Code de l'environnement) : déclaration/autorisation selon profondeur/prélèvement (nomenclature). `[A]`
3. **DICT** (réseaux enterrés) + AIPR. `[A]` → [terrasser-reseaux-dict](../../professions/terrassement/cards/terrasser-reseaux-dict.md)
4. Étude **hydrogéologique** ; foreur qualifié ; déclaration de l'ouvrage (BSS). `[C]`

> Forer sans déclaration = infraction + risque pour la **ressource**. Doute → **arrêt**. `[A]`

## Cadre
- **Normes** : puits traditionnel maçonné (margelle/cuvelage) **DTU 20.1** ; alimentation électrique des pompes immergées **NF C 15-100** ; forage d'eau selon les règles de l'art (**NF X10-999**), réglementation (**Code de l'environnement** — loi sur l'eau, déclaration en mairie) et qualité de l'eau (**arrêté du 11 janvier 2007**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [realiser-forage-eau](../../professions/forage/cards/realiser-forage-eau.md).
- **Tags** : `metier:forage famille:gros-oeuvre sous-famille:securite intervention:controler cluster:reglementation cluster:hydrogeologie type:procedure securite:nappe relation:terrassement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
