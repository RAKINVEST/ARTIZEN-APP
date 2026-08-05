# Résultat DPE défavorable (passoire thermique)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `resultat-dpe-defavorable` |
| Titre | Résultat DPE défavorable (passoire thermique) |
| Profession | `metier:diagnostic` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:diagnostic` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **DPE** classé **F ou G** (« passoire thermique »), étiquettes énergie/GES défavorables. `[C]`

## Interprétation / conséquences
1. **Impact** sur la vente/location (information, restrictions selon calendrier réglementaire). `[A]` → [comprendre-dpe-audit-energetique](../../professions/diagnostic/cards/comprendre-dpe-audit-energetique.md)
2. **Audit énergétique** (présentation) proposant des scénarios de travaux. `[C]`
3. Postes d'amélioration (isolation, ventilation, chauffage). `[C]`

## Suites (orientation)
- Orienter vers un **audit** et des **travaux** (isolation/chauffage/ventilation) par les corps d'état concernés ; le diagnostic n'exécute pas les travaux.

> Le DPE est **opposable** : s'appuyer sur des données à jour. `[A]`

## Cadre
- **Normes** : diagnostic de l'installation **électrique** intérieure **NF C 16-600** ; installation électrique de référence **NF C 15-100** ; cadre des diagnostics : **Code de la construction** (dossier de diagnostic technique / DDT), **Code de la santé publique** (amiante, plomb / CREP, ERP), **Code de l'énergie** (DPE, audit), **NF X46-020** (amiante), **NF P03-201** (termites), **Loi Carrez** (mesurage) et **certification des diagnostiqueurs** ⟦en prose, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [comprendre-dpe-audit-energetique](../../professions/diagnostic/cards/comprendre-dpe-audit-energetique.md).
- **Tags** : `metier:diagnostic famille:specialises sous-famille:diagnostic probleme:dpe cluster:dpe cluster:audit-energetique type:diagnostic securite:reglementaire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
