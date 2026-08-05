# Sécurité — réseaux, manutention & découpe (clôture)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-reseaux-manutention-cloture` |
| Titre | Sécurité — réseaux, manutention & découpe (clôture) |
| Profession | `metier:cloture` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **DT-DICT** : réseaux enterrés repérés avant chaque trou de poteau. `[A]`
- [ ] **Terrassement léger** : effondrement des trous, tarière/engins. `[A]`
- [ ] **Scellement béton** : EPI ciment ; charges. `[A]`
- [ ] **Manutention** : poteaux/panneaux/rouleaux → binôme/moyens. `[A]`
- [ ] **Découpe/électroportatif** : disque adapté, lunettes/gants ; **fil sous tension** (fouet). `[A]`
- [ ] **Bordure de voie** : signalisation ; **amiante** (rénovation) = certifié. `[A]`

## Cadre
- **Normes** : béton de scellement des poteaux (**interface**) **DTU 21** ; ouvrages métalliques / portillons (**interface** métallerie) **DTU 37.1** ; grillages **NF EN 10223**, protection anticorrosion **NF EN ISO 1461 / NF EN ISO 12944**, règles d'**urbanisme** (PLU : hauteur/aspect), **bornage** (Code civil, géomètre) et **DT-DICT** (réseaux) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [dict-reseaux-scellement-avant-travaux-cloture](../../procedures/cloture/dict-reseaux-scellement-avant-travaux-cloture.md).
- **Tags** : `metier:cloture famille:specialises sous-famille:securite type:checklist cluster:securite securite:reseaux securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
