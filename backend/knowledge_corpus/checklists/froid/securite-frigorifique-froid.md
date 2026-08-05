# Sécurité frigorifique (froid commercial, F-Gaz)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-frigorifique-froid` |
| Titre | Sécurité frigorifique (froid commercial, F-Gaz) |
| Profession | `metier:froid` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:frigorifique` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Attestation de capacité F-Gaz** de l'intervenant pour tout acte sur le circuit. `[A]`
- [ ] Outillage frigorifique dédié (station récupération, détecteur, manifold). `[B]`
- [ ] **Récupération** du fluide (jamais de rejet à l'atmosphère). `[A]`
- [ ] **Contrôle d'étanchéité périodique** selon charge (équivalent CO₂). `[B]` ⟦seuils/périodicité à confirmer⟧
- [ ] Registre / fiche d'intervention ; ventilation ; EPI. `[B]`

> **Toute manipulation du circuit frigorifique sans qualification F-Gaz est proscrite.** `[A]`

## Cadre
- **Normes** : sécurité des systèmes frigorifiques **NF EN 378** ; installation électrique **NF C 15-100** ; réglementation **F-Gaz** (UE 517/2014) `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [principe-froid-commercial](../../professions/froid/cards/principe-froid-commercial.md).
- **Tags** : `metier:froid equipement:groupe-froid famille:fluides sous-famille:frigorifique type:checklist cluster:securite cluster:reglementation-f-gaz cluster:normes securite:frigorifique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
