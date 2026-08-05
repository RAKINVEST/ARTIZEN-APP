# Contrôle avant remise en service (robinetterie / sanitaire)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-avant-remise-en-service` |
| Titre | Contrôle avant remise en service (robinetterie / sanitaire) |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] Raccords serrés sans surserrage (joints non écrasés). `[C]`
- [ ] Réouverture d'eau **progressive**, air purgé (jet franc). `[B]`
- [ ] Absence de fuite à chaque raccord (essuyer puis observer 1–2 min). `[C]`
- [ ] Équilibre eau chaude/froide correct (mitigeur). `[C]`
- [ ] Évacuation libre, siphon étanche. `[C]`
- [ ] Poste de travail nettoyé, aucune donnée personnelle sur les photos. `[C]`

## Cadre
- **Normes** : installation sanitaire — **DTU 60.1** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [poser-mitigeur-evier](../../professions/plomberie/cards/poser-mitigeur-evier.md) ; `verifie` → [detartrage-mousseur](../../procedures/plomberie/detartrage-mousseur.md).
- **Tags** : `metier:plomberie famille:fluides type:checklist controle:etancheite equipement:mitigeur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-03 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
