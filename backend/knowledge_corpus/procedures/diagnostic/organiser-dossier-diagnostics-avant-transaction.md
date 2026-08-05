# Organiser le dossier de diagnostics avant transaction (décision)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `organiser-dossier-diagnostics-avant-transaction` |
| Titre | Organiser le dossier de diagnostics avant transaction (décision) |
| Profession | `metier:diagnostic` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:diagnostic` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Organiser la constitution du **dossier de diagnostic technique (DDT)** — **décision/organisation**, sans réaliser aucun diagnostic. `[A]`

## Étapes (organisation / décision — aucune méthode ni mesure de diagnostic)
1. **Identifier** les diagnostics **applicables** (transaction/âge/zone). `[A]` → [comprendre-obligations-vente-location](../../professions/diagnostic/cards/comprendre-obligations-vente-location.md)
2. **Faire réaliser** par un **diagnostiqueur certifié** (indépendant/assuré). `[A]`
3. **Vérifier** la validité et la complétude du **DDT**. `[C]` → [controle-dossier-diagnostic-technique](../../checklists/diagnostic/controle-dossier-diagnostic-technique.md)
4. **Interpréter** les résultats ; orienter les **suites** (travaux réservés si amiante/plomb ; anomalies gaz/élec → professionnels). `[A]`
5. **Danger imminent** signalé → **mise en sécurité** / professionnel sans délai. `[A]`
6. **Documenter / conserver** le DDT. `[C]` `relation:desamiantage`

> Ce contenu **organise et oriente** ; il ne réalise **aucun** diagnostic réglementaire.

## Cadre
- **Normes** : diagnostic de l'installation **électrique** intérieure **NF C 16-600** ; installation électrique de référence **NF C 15-100** ; cadre des diagnostics : **Code de la construction** (dossier de diagnostic technique / DDT), **Code de la santé publique** (amiante, plomb / CREP, ERP), **Code de l'énergie** (DPE, audit), **NF X46-020** (amiante), **NF P03-201** (termites), **Loi Carrez** (mesurage) et **certification des diagnostiqueurs** ⟦en prose, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [principe-diagnostic-immobilier](../../professions/diagnostic/cards/principe-diagnostic-immobilier.md).
- **Tags** : `metier:diagnostic famille:specialises sous-famille:diagnostic intervention:securiser cluster:ddt cluster:organisation type:procedure securite:reglementaire securite:amiante relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
