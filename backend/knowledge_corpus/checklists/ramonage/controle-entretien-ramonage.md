# Contrôle / entretien périodique ramonage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-entretien-ramonage` |
| Titre | Contrôle / entretien périodique ramonage |
| Profession | `metier:ramonage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:ramonage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Ramonage** réalisé (périodicité réglementaire) ; **certificat** établi. `[A]`
- [ ] **Vacuité / état** du conduit ; contrôle visuel. `[C]`
- [ ] **Tirage** correct ; **ventilation** / amenée d'air suffisante (CO). `[A]`
- [ ] Absence de **bistre** ; débistrage si besoin. `[C]`
- [ ] **Raccordement / distances** de sécurité (combustibles) ; appareil = Chauffagiste. `[C]`
- [ ] Rénovation : **amiante** (anciens conduits) vérifié. `[A]`

## Cadre
- **Normes** : évacuation des produits de combustion / fumisterie **DTU 24.1** ; âtrerie (cheminées/foyers) **DTU 24.2** ; conduits métalliques **NF EN 1856**, dimensionnement / tirage **NF EN 13384**, obligation de ramonage et **certificat** (**Règlement sanitaire départemental**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [entretenir-diagnostiquer-conduit](../../professions/ramonage/cards/entretenir-diagnostiquer-conduit.md).
- **Tags** : `metier:ramonage famille:specialises sous-famille:ramonage type:checklist cluster:entretien-periodique cluster:certificat securite:monoxyde`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
