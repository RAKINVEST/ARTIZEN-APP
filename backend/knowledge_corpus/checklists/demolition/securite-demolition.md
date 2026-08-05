# Sécurité — démolition

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-demolition` |
| Titre | Sécurité — démolition |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Stabilité / étaiement** des porteurs (risque effondrement). `[A]`
- [ ] **Amiante/plomb** : diagnostic fait ; amiante = **entreprise certifiée**. `[A]`
- [ ] **Réseaux consignés** avant dépose. `[A]`
- [ ] **Poussières (silice)** : voie humide/aspiration + masque ; **bruit**/**vibrations**. `[A]`
- [ ] **Chute d'objets** / projections : périmètre, protections, hauteur. `[A]`
- [ ] **Engins/levage** balisés ; **arrêt immédiat** en cas de danger. `[A]`

## Cadre
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [controler-securiser-chantier-demolition](../../professions/demolition/cards/controler-securiser-chantier-demolition.md).
- **Tags** : `metier:demolition famille:gros-oeuvre sous-famille:securite type:checklist cluster:securite securite:effondrement securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
