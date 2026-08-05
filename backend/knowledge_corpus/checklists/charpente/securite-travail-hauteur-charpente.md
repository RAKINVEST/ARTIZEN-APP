# Sécurité — travail en hauteur (charpente)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-travail-hauteur-charpente` |
| Titre | Sécurité — travail en hauteur (charpente) |
| Profession | `metier:charpente` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Protection antichute** (échafaudage, garde-corps, harnais + point d'ancrage). `[A]`
- [ ] **Météo** favorable (vent, gel, pluie) — sinon report. `[B]`
- [ ] **Stabilité** de l'ouvrage évaluée avant de circuler. `[A]`
- [ ] **Étaiement** prévu pour toute intervention structurelle. `[A]`
- [ ] EPI (casque, chaussures, gants, antichute). `[B]`
- [ ] **Arrêt immédiat** en cas de danger (mouvement, fissuration). `[A]`

## Cadre
- **Normes** : charpente et escaliers en bois **DTU 31.1** ; charpentes assemblées par connecteurs **DTU 31.3** ; calcul des structures bois **Eurocode 5 (NF EN 1995)** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [etaiement-avant-intervention](../../procedures/charpente/etaiement-avant-intervention.md).
- **Tags** : `metier:charpente famille:enveloppe sous-famille:securite type:checklist cluster:securite cluster:travail-en-hauteur securite:hauteur securite:structure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
