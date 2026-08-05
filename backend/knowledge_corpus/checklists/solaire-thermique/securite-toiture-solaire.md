# Sécurité — toiture & fluide chaud (solaire)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-toiture-solaire` |
| Titre | Sécurité — toiture & fluide chaud (solaire) |
| Profession | `metier:solaire-thermique` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Travail en toiture** : protections collectives / **EPI antichute** ; météo. `[A]`
- [ ] **Manutention des capteurs** (lourds, prise au vent) à plusieurs. `[A]`
- [ ] **Brûlures** : capteurs/fluide très chauds — **refroidir avant** intervention. `[A]`
- [ ] **Pression** du circuit : purge/soupape avant ouverture. `[A]`
- [ ] **Fluide caloporteur** (glycol) : EPI, élimination tracée. `[B]`
- [ ] **Élec régulation** réservée ; **arrêt immédiat** en cas de danger. `[A]`

## Cadre
- **Normes** : installations de capteurs solaires à circulation de liquide **DTU 65.12** ; électricité de la régulation/circulateur **NF C 15-100** ; capteurs **NF EN 12975**, systèmes **NF EN 12976**, certification **Solar Keymark** / label **RGE QualiSol** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [poser-capteurs-solaires](../../professions/solaire-thermique/cards/poser-capteurs-solaires.md).
- **Tags** : `metier:solaire-thermique famille:fluides sous-famille:securite type:checklist cluster:securite securite:hauteur securite:brulure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
