# Contrôle avant démolition

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-avant-demolition` |
| Titre | Contrôle avant démolition |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:demolition` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Diagnostics** amiante avant travaux / plomb (CREP) / **PEMD** réunis. `[A]`
- [ ] **Structure** analysée (porteur ? étaiement prévu). `[A]`
- [ ] **Réseaux consignés** (élec/gaz/eau). `[A]`
- [ ] **Périmètre balisé** ; protection contre chute d'objets. `[A]`
- [ ] **Filières de tri** (PEMD) identifiées. `[C]`
- [ ] **EPI** (poussières/silice, bruit, antichute) ; moyens engins/levage. `[A]`

> Amiante suspect → **arrêt** + entreprise certifiée ; danger structurel → **étaiement/évacuation**.

## Cadre
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [controler-securiser-chantier-demolition](../../professions/demolition/cards/controler-securiser-chantier-demolition.md).
- **Tags** : `metier:demolition famille:gros-oeuvre sous-famille:demolition type:checklist cluster:controle cluster:diagnostic-prealable cluster:securite securite:effondrement relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
