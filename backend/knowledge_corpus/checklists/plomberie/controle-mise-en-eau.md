# Contrôle de mise en eau (sanitaire)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-mise-en-eau` |
| Titre | Contrôle de mise en eau (sanitaire) |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] Réouverture d'eau **progressive** (éviter le coup de bélier). `[C]`
- [ ] Absence de fuite à chaque raccord (essuyer puis observer). `[C]`
- [ ] Évacuation libre et siphon avec garde d'eau. `[C]`
- [ ] Réservoir/chasse sans écoulement continu (WC). `[C]`
- [ ] Pression correcte, débit satisfaisant aux points de puisage. `[C]`
- [ ] Poste nettoyé, aucune donnée personnelle sur les photos. `[C]`

## Cadre
- **Normes** : installation sanitaire — **DTU 60.1** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [poser-robinet-arret](../../professions/plomberie/cards/poser-robinet-arret.md) ; voir [controle-etancheite](controle-etancheite.md).
- **Tags** : `metier:plomberie famille:fluides type:checklist controle:etancheite controle:mise-en-eau`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
