# Contrôle documentaire (DTA, repérages, traçabilité)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-documentaire-dta-amiante` |
| Titre | Contrôle documentaire (DTA, repérages, traçabilité) |
| Profession | `metier:desamiantage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:desamiantage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier (avant / pendant travaux sur bâti ancien)
- [ ] **Repérage amiante** (DTA / RAT) **consulté** avant intervention. `[A]`
- [ ] Bâtiment **avant 1997** : vigilance renforcée MPCA. `[A]`
- [ ] Repérage **manquant/incomplet** → **réclamer / arrêter**. `[A]`
- [ ] **Signalements / arrêts / orientations** tracés. `[C]`
- [ ] Interfaces (couverture/plomberie/chauffage/élec/menuiseries…) informées. `[C]`
- [ ] En cas de présence : **entreprise certifiée** (SS3) ; déchets = filière dédiée. `[A]`

## Cadre
- **Normes** : **cadre réglementaire amiante** : **Code du travail** (R.4412-94 et s. — **SS3/SS4**), **Code de la santé publique** (repérage / DTA), **NF X46-020** (repérage avant travaux) et arrêtés (8 avril 2013, 26 juin 2019) ⟦références non détectées — à confirmer par un expert⟧ ; côté **interfaces** où l'amiante est fréquent : conduits / fumisterie **DTU 24.1**, anciens équipements électriques **NF C 15-100** ⟦interfaces, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [maintenir-documentation-dta](../../professions/desamiantage/cards/maintenir-documentation-dta.md).
- **Tags** : `metier:desamiantage famille:specialises sous-famille:desamiantage type:checklist cluster:maintenance-documentaire cluster:reperage securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
