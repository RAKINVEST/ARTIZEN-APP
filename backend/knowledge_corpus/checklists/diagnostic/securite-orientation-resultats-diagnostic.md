# Sécurité — résultats & orientation (diagnostic)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-orientation-resultats-diagnostic` |
| Titre | Sécurité — résultats & orientation (diagnostic) |
| Profession | `metier:diagnostic` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Métier certifié** : diagnostics réalisés par un **diagnostiqueur certifié** (jamais soi-même). `[A]`
- [ ] **Amiante / plomb** détectés → travaux **réservés** (entreprise certifiée). `[A]`
- [ ] **Gaz / électricité** : anomalies → professionnel ; **danger imminent = mise en sécurité**. `[A]`
- [ ] **Termites** → traitement (métier dédié). `[C]`
- [ ] **Suites** orientées vers le bon corps d'état ; jamais d'intervention sur le seul rapport. `[A]`
- [ ] **DDT** complet, à jour, conservé (documentation). `[C]`

## Cadre
- **Normes** : diagnostic de l'installation **électrique** intérieure **NF C 16-600** ; installation électrique de référence **NF C 15-100** ; cadre des diagnostics : **Code de la construction** (dossier de diagnostic technique / DDT), **Code de la santé publique** (amiante, plomb / CREP, ERP), **Code de l'énergie** (DPE, audit), **NF X46-020** (amiante), **NF P03-201** (termites), **Loi Carrez** (mesurage) et **certification des diagnostiqueurs** ⟦en prose, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [organiser-dossier-diagnostics-avant-transaction](../../procedures/diagnostic/organiser-dossier-diagnostics-avant-transaction.md).
- **Tags** : `metier:diagnostic famille:specialises sous-famille:securite type:checklist cluster:orientation securite:reglementaire securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
