# Sécurité — manutention, électrique & amiante (menuiserie intérieure)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-manutention-electrique-menuiserie` |
| Titre | Sécurité — manutention, électrique & amiante (menuiserie intérieure) |
| Profession | `metier:menuiserie-interieure` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Manutention** blocs-portes/portes : binôme/levage ; **écrasement/pincement**. `[A]`
- [ ] **Machines électroportatives** : capots/entretien ; **poussières de bois** (aspiration/masque). `[A]`
- [ ] **Bruit** : protection auditive. `[A]`
- [ ] **Fixation** adaptée au support (un bloc-porte mal fixé tombe). `[A]`
- [ ] **Repérage réseaux / électrique** avant perçage (consignation si CF). `[A]`
- [ ] **Amiante** (ouvrages anciens) : diagnostic ; retrait = **certifié** (jamais ici) ; **arrêt** si danger. `[A]`

## Cadre
- **Normes** : menuiseries intérieures en bois **DTU 36.2** ; menuiserie bois **DTU 36.1** ; électricité (avant perçage, à proximité des réseaux) **NF C 15-100** ; accessibilité (largeurs de passage) et diagnostic **amiante** (ouvrages anciens) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [reperage-reseaux-amiante-avant-pose](../../procedures/menuiserie-interieure/reperage-reseaux-amiante-avant-pose.md).
- **Tags** : `metier:menuiserie-interieure famille:finition sous-famille:securite type:checklist cluster:blocs-portes securite:manutention securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
