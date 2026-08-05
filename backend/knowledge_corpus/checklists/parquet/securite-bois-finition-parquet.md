# Sécurité — poussières de bois, finitions & amiante (parquet)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-bois-finition-parquet` |
| Titre | Sécurité — poussières de bois, finitions & amiante (parquet) |
| Profession | `metier:parquet` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Poussières de bois (cancérogène)** : ponçage à **aspiration** + masque ; pas de balayage à sec. `[A]`
- [ ] **Produits de finition** (vernis/huiles/solvants) : COV, **ventilation**, EPI, pas de flamme. `[A]`
- [ ] **Chiffons imbibés d'huile** : immerger/étaler (**auto-échauffement / incendie**). `[A]`
- [ ] **Bruit** (ponceuse) : protection auditive ; machines entretenues. `[A]`
- [ ] **Électricité** avant clouage/percement (plancher chauffant/gaines). `[A]`
- [ ] **Amiante** (rénovation) : diagnostic ; retrait = **certifié** (jamais ici) ; **arrêt** si danger. `[A]`

## Cadre
- **Normes** : pose des parquets à clouer **DTU 51.1** ; parquets collés **DTU 51.2** ; pose flottante des parquets contrecollés **DTU 51.11** ; électricité (avant percement, plancher chauffant) **NF C 15-100** ; taux d'humidité du support et diagnostic **amiante** (colles anciennes) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [controle-humidite-amiante-avant-pose](../../procedures/parquet/controle-humidite-amiante-avant-pose.md).
- **Tags** : `metier:parquet famille:finition sous-famille:securite type:checklist cluster:poncage securite:poussieres securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
