# Sécurité frigorifère climatisation (F-Gaz)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-frigorifique-clim` |
| Titre | Sécurité frigorifère climatisation (F-Gaz) |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:frigorifique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Attestation de capacité F-Gaz** de l'intervenant. `[A]`
- [ ] Outillage frigorifère dédié (station récupération, détecteur, pompe à vide). `[B]`
- [ ] **Récupération** du fluide (jamais de rejet à l'atmosphère). `[A]`
- [ ] Fiche/registre d'intervention. `[B]` ⟦cadre exact à confirmer⟧
- [ ] EPI, ventilation, pression contrôlée. `[B]`

> **Toute manipulation du circuit frigorifère sans qualification F-Gaz est proscrite.** `[A]`

## Cadre
- **Normes** : réglementation **F-Gaz** (UE 517/2014) + **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [controler-circuit-frigorifique-clim](../../professions/climatisation/cards/controler-circuit-frigorifique-clim.md).
- **Tags** : `metier:climatisation equipement:climatiseur equipement:pac famille:fluides sous-famille:frigorifique type:checklist cluster:securite cluster:frigorifique cluster:normes securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
