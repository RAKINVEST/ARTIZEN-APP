# Matériau suspect amiante / plomb

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `presence-amiante-plomb-suspecte` |
| Titre | Matériau suspect amiante / plomb |
| Profession | `metier:demolition` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:demolition` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Matériau **suspect** rencontré (flocage, dalles vinyle-amiante, colle, fibrociment, ancienne peinture au plomb). `[C]`

> **ARRÊT IMMÉDIAT.** Ne pas percer/casser/poncer. Le **désamiantage** est **réservé à une entreprise certifiée** (sous-section 3/4) — **jamais** en démolition courante. `[A]`

## Causes probables
1. **Amiante** (bâti avant 1997) non repéré / diagnostic incomplet. `[C]` → [realiser-diagnostic-prealable](../../professions/demolition/cards/realiser-diagnostic-prealable.md)
2. **Plomb** (peintures anciennes) — CREP. `[C]`

## Résolution
- **Arrêter**, isoler la zone, faire compléter le diagnostic ; désamiantage par **entreprise certifiée** (interface, hors périmètre démolition). `[A]`

## Cadre
- **Normes** : démolition/reprise d'ouvrages en maçonnerie **DTU 20.1** et en béton **DTU 21** ; diagnostics réglementaires avant travaux (**PEMD** déchets, **amiante**, **plomb/CREP**) et **Code du travail** (étaiement/protection) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [realiser-diagnostic-prealable](../../professions/demolition/cards/realiser-diagnostic-prealable.md).
- **Tags** : `metier:demolition famille:gros-oeuvre sous-famille:demolition probleme:amiante cluster:diagnostic-prealable cluster:reglementation type:diagnostic securite:amiante relation:desamiantage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
