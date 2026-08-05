# Sécurité — amiante, COV & manutention (sols)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-amiante-cov-sol` |
| Titre | Sécurité — amiante, COV & manutention (sols) |
| Profession | `metier:revetements-sol` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Amiante** (rénovation) : diagnostic ; **dalles/colles anciennes** suspectes → **arrêt** ; retrait = **certifié** (jamais ici). `[A]`
- [ ] **Colles / COV / solvants** : produits faible COV, **ventilation** pendant/après, EPI. `[A]`
- [ ] **Inflammabilité** de certaines colles : pas de flamme/source d'ignition. `[A]`
- [ ] **Poussières** (ragréage/ponçage = silice) : masque/aspiration. `[A]`
- [ ] **Manutention** (rouleaux/dalles) : binôme/TMS ; **genoux** (genouillères). `[A]`
- [ ] **Électricité** avant découpe/percement (sols techniques) ; **arrêt** si danger. `[A]`

## Cadre
- **Normes** : revêtements de sol PVC collés **DTU 53.2** ; revêtements textiles / moquettes **DTU 53.1** ; pose flottante des sols stratifiés **DTU 51.11** (interface) ; électricité (avant découpe/percement, sols techniques) **NF C 15-100** ; classement **UPEC**, étiquetage **COV** et diagnostic **amiante** (anciennes dalles/colles) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [diagnostic-amiante-depose-ancien-sol](../../procedures/revetements-sol/diagnostic-amiante-depose-ancien-sol.md).
- **Tags** : `metier:revetements-sol famille:finition sous-famille:securite type:checklist cluster:reglementation securite:amiante securite:cov`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
