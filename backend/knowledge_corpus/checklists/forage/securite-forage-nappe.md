# Sécurité — forage, puits & nappe

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-forage-nappe` |
| Titre | Sécurité — forage, puits & nappe |
| Profession | `metier:forage` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Ouvrage protégé/couvert** (risque de **chute** dans le puits). `[A]`
- [ ] **Effondrement** : tubage/soutènement des parois. `[A]`
- [ ] **Espace confiné** (puits) : détection/ventilation/surveillant/treuil. `[A]`
- [ ] **Contamination de la nappe** : protection sanitaire + cimentation ; désinfection. `[A]`
- [ ] **Électricité pompe immergée** : raccordement réservé (protection diff.). `[A]`
- [ ] **DICT** (réseaux) ; **levage** ; **arrêt immédiat** en cas de danger. `[A]`

## Cadre
- **Normes** : puits traditionnel maçonné (margelle/cuvelage) **DTU 20.1** ; alimentation électrique des pompes immergées **NF C 15-100** ; forage d'eau selon les règles de l'art (**NF X10-999**), réglementation (**Code de l'environnement** — loi sur l'eau, déclaration en mairie) et qualité de l'eau (**arrêté du 11 janvier 2007**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [declaration-forage](../../procedures/forage/declaration-forage.md).
- **Tags** : `metier:forage famille:gros-oeuvre sous-famille:securite type:checklist cluster:securite securite:nappe securite:effondrement`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
