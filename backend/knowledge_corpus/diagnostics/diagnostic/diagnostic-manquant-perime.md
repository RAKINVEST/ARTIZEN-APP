# Diagnostic manquant ou périmé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `diagnostic-manquant-perime` |
| Titre | Diagnostic manquant ou périmé |
| Profession | `metier:diagnostic` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:diagnostic` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Un diagnostic **obligatoire manque** au dossier, ou sa **durée de validité** est dépassée (transaction en cours). `[C]`

## Causes probables
1. **Diagnostic non réalisé** pour la transaction/bien/zone. `[C]` → [comprendre-obligations-vente-location](../../professions/diagnostic/cards/comprendre-obligations-vente-location.md)
2. **Péremption** (validité variable selon le diagnostic). `[C]` → [lire-interpreter-rapport-suites](../../professions/diagnostic/cards/lire-interpreter-rapport-suites.md)
3. Travaux post-diagnostic ayant modifié le bien. `[C]`

## Conduite à tenir (décision, pas réalisation)
- **Faire réaliser/renouveler** le diagnostic par un **diagnostiqueur certifié** avant la transaction ; compléter le **DDT**.

> Un DDT incomplet expose à des **conséquences juridiques** (responsabilité du vendeur/bailleur). `[A]`

## Cadre
- **Normes** : diagnostic de l'installation **électrique** intérieure **NF C 16-600** ; installation électrique de référence **NF C 15-100** ; cadre des diagnostics : **Code de la construction** (dossier de diagnostic technique / DDT), **Code de la santé publique** (amiante, plomb / CREP, ERP), **Code de l'énergie** (DPE, audit), **NF X46-020** (amiante), **NF P03-201** (termites), **Loi Carrez** (mesurage) et **certification des diagnostiqueurs** ⟦en prose, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [comprendre-obligations-vente-location](../../professions/diagnostic/cards/comprendre-obligations-vente-location.md).
- **Tags** : `metier:diagnostic famille:specialises sous-famille:diagnostic probleme:manquant cluster:obligations cluster:duree-validite type:diagnostic securite:reglementaire`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
