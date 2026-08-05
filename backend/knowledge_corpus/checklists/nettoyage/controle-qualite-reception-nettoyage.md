# Contrôle qualité / réception nettoyage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-qualite-reception-nettoyage` |
| Titre | Contrôle qualité / réception nettoyage |
| Profession | `metier:nettoyage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:nettoyage` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier (inspection finale)
- [ ] **Dépoussiérage** complet (haut vers bas) ; pas de résidus. `[C]`
- [ ] **Vitrages** propres (sans rayures/traces) ; **sanitaires** hygiéniques. `[C]`
- [ ] **Sols** nettoyés selon revêtement ; non glissants ; non abîmés. `[C]`
- [ ] **Protections** retirées sans traces ; ouvrages **non dégradés**. `[A]`
- [ ] **Déchets** triés / évacués (filière, bordereau). `[A]`
- [ ] **Documentation** (plan, FDS, bordereaux) ; défauts autres corps d'état signalés. `[C]`

## Cadre
- **Normes** : nettoyage des **vitrages** (**interface** vitrerie) **DTU 39** ; nettoyage / protection des **sols** carrelés (**interface**) **DTU 52.2** ; gestion des **déchets de chantier** (Code de l'environnement, tri / bordereau), **fiches de données de sécurité (FDS)** et étiquetage **CLP** des produits ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [controler-qualite-documenter](../../professions/nettoyage/cards/controler-qualite-documenter.md).
- **Tags** : `metier:nettoyage famille:specialises sous-famille:nettoyage type:checklist cluster:controle-qualite cluster:inspection-finale securite:produits-chimiques`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
