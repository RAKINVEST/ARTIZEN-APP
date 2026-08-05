# Contrôle du dossier de diagnostic technique (DDT)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-dossier-diagnostic-technique` |
| Titre | Contrôle du dossier de diagnostic technique (DDT) |
| Profession | `metier:diagnostic` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:diagnostic` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier (documentaire)
- [ ] **Diagnostics applicables** présents (selon transaction/âge/zone). `[A]`
- [ ] **DPE** (et audit si requis) ; étiquettes lisibles. `[C]`
- [ ] **Amiante / plomb (CREP)** selon ancienneté du bâti. `[A]`
- [ ] **Gaz / électricité** (installations anciennes) ; anomalies notées. `[A]`
- [ ] **Termites / ERP / mesurage** selon zone/bien. `[C]`
- [ ] **Durées de validité** à jour ; réalisés par **certifié** ; DDT conservé. `[A]`

## Cadre
- **Normes** : diagnostic de l'installation **électrique** intérieure **NF C 16-600** ; installation électrique de référence **NF C 15-100** ; cadre des diagnostics : **Code de la construction** (dossier de diagnostic technique / DDT), **Code de la santé publique** (amiante, plomb / CREP, ERP), **Code de l'énergie** (DPE, audit), **NF X46-020** (amiante), **NF P03-201** (termites), **Loi Carrez** (mesurage) et **certification des diagnostiqueurs** ⟦en prose, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [comprendre-obligations-vente-location](../../professions/diagnostic/cards/comprendre-obligations-vente-location.md).
- **Tags** : `metier:diagnostic famille:specialises sous-famille:diagnostic type:checklist cluster:ddt cluster:duree-validite securite:reglementaire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
