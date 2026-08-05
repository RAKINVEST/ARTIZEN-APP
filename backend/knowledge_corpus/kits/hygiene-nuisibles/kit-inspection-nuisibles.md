# Kit d'inspection nuisibles (surveillance, pas application)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-inspection-nuisibles` |
| Titre | Kit d'inspection nuisibles (surveillance, pas application) |
| Profession | `metier:hygiene-nuisibles` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:hygiene-nuisibles` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée (**inspection / surveillance** — pas d'application de biocides)
- **Lampe**, appareil photo, miroir d'inspection, loupe, fiches d'identification (rongeurs/insectes). `[C]`
- **Pièges de détection / monitoring** (plaques de glu de suivi, détecteurs), marqueurs de zones, thermo-hygromètre. `[C]`
- **Boîtes d'appât sécurisées** (verrouillables) pour la surveillance, registre d'intervention. `[C]`
- **EPI** : gants, masque, protection ; détecteur/consignes zoonoses. `[A]`

> **Ce kit ne contient aucun produit biocide ni matériel d'application professionnelle** : le traitement relève d'un **applicateur qualifié** (Certibiocide). `[A]`

## Cadre
- **Normes** : accès des nuisibles par les réseaux (siphons / clapets anti-rongeurs, **interface** plomberie) **DTU 60.1** ; **ventilation** contre l'humidité favorisant les nuisibles (**interface**) **DTU 68.3** ; services de lutte antiparasitaire **NF EN 16636** (certification CEPA), **Règlement Sanitaire Départemental**, **Règlement Biocides UE 528/2012 / Certibiocide** et **HACCP** (locaux alimentaires) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [inspecter-diagnostiquer-infestation](../../professions/hygiene-nuisibles/cards/inspecter-diagnostiquer-infestation.md).
- **Tags** : `metier:hygiene-nuisibles famille:specialises sous-famille:hygiene-nuisibles type:kit cluster:inspection cluster:surveillance equipement:pieges-monitoring`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
