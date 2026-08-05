# Anomalie / danger signalé au rapport

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `anomalie-signalee-au-rapport` |
| Titre | Anomalie / danger signalé au rapport |
| Profession | `metier:diagnostic` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Le rapport signale une **anomalie** ou un **danger** (électricité, gaz, amiante, plomb, termites). `[C]`

> Certains dangers sont **immédiats** (gaz/électricité) → **mise en sécurité** et intervention d'un professionnel sans délai. `[A]`

## Conduite à tenir (orientation, jamais intervention improvisée)
1. **Amiante / plomb** → entreprise **certifiée** (Désamiantage). `[A]` → [comprendre-reperage-diagnostics](../../professions/desamiantage/cards/comprendre-reperage-diagnostics.md)
2. **Électricité** → **Électricien** (lever les anomalies). `[A]` → [controler-tableau-electrique](../../professions/electricite-generale/cards/controler-tableau-electrique.md)
3. **Gaz** → **professionnel gaz / chauffagiste**. `[A]` → [entretenir-chaudiere](../../professions/chauffage/cards/entretenir-chaudiere.md)

> Le diagnostic **constate** ; la réparation relève du corps d'état compétent.

## Cadre
- **Normes** : diagnostic de l'installation **électrique** intérieure **NF C 16-600** ; installation électrique de référence **NF C 15-100** ; cadre des diagnostics : **Code de la construction** (dossier de diagnostic technique / DDT), **Code de la santé publique** (amiante, plomb / CREP, ERP), **Code de l'énergie** (DPE, audit), **NF X46-020** (amiante), **NF P03-201** (termites), **Loi Carrez** (mesurage) et **certification des diagnostiqueurs** ⟦en prose, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [comprendre-gaz-electricite](../../professions/diagnostic/cards/comprendre-gaz-electricite.md).
- **Tags** : `metier:diagnostic famille:specialises sous-famille:securite probleme:anomalie cluster:electricite cluster:gaz type:diagnostic securite:reglementaire relation:electricite-generale relation:chauffage relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
