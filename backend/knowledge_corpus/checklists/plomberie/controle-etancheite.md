# Contrôle d'étanchéité

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-etancheite` |
| Titre | Contrôle d'étanchéité |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] Eau rouverte **progressivement**, air purgé. `[B]`
- [ ] Chaque raccord contrôlé (visuel + sec). `[C]`
- [ ] Maintien en pression + temps d'observation. `[C]`
- [ ] Points sensibles séchés et re-vérifiés. `[C]`
- [ ] Résultat consigné (OK / reprise). `[C]`

## Cadre
- **Normes** : installation sanitaire — **DTU 60.1** `[B]` ⟦référence exacte à confirmer par le validateur⟧. `respecte-norme`
- **Relations** : `verifie` → [controler-etancheite-reseau](../../professions/plomberie/cards/controler-etancheite-reseau.md).
- **Tags** : `metier:plomberie famille:fluides type:checklist controle:etancheite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | consolidation au standard Factory (Brouillon) |
