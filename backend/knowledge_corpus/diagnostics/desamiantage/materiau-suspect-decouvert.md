# Matériau suspect découvert en cours de travaux

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `materiau-suspect-decouvert` |
| Titre | Matériau suspect découvert en cours de travaux |
| Profession | `metier:desamiantage` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Découverte d'un **matériau suspect** (avant 1997) non identifié au repérage : plaque, dalle, enduit, joint, calorifuge. `[C]`

> **ARRÊT IMMÉDIAT** : ne pas percer/poncer/découper/casser/déplacer ; ne pas « gratter pour voir » ; baliser et **signaler**. `[A]`

## Conduite à tenir (décision, pas intervention)
1. **Arrêter** et isoler la zone (protection des occupants). `[A]` → [arreter-signaler-en-cas-de-doute](../../professions/desamiantage/cards/arreter-signaler-en-cas-de-doute.md)
2. **Signaler** au maître d'ouvrage ; faire **repérer/analyser** (diagnostiqueur/labo). `[A]` → [comprendre-reperage-diagnostics](../../professions/desamiantage/cards/comprendre-reperage-diagnostics.md)
3. **Orienter** vers une **entreprise certifiée** si présence confirmée. `[A]`

> Le retrait/confinement n'est **jamais** réalisé par l'artisan ni décrit ici.

## Cadre
- **Normes** : **cadre réglementaire amiante** : **Code du travail** (R.4412-94 et s. — **SS3/SS4**), **Code de la santé publique** (repérage / DTA), **NF X46-020** (repérage avant travaux) et arrêtés (8 avril 2013, 26 juin 2019) ⟦références non détectées — à confirmer par un expert⟧ ; côté **interfaces** où l'amiante est fréquent : conduits / fumisterie **DTU 24.1**, anciens équipements électriques **NF C 15-100** ⟦interfaces, à confirmer⟧ `[B]` ⟦cadre réglementaire à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [conduite-arret-signalement-orientation](../../procedures/desamiantage/conduite-arret-signalement-orientation.md).
- **Tags** : `metier:desamiantage famille:specialises sous-famille:securite probleme:decouverte cluster:arret-travaux cluster:diagnostic type:diagnostic securite:amiante`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
