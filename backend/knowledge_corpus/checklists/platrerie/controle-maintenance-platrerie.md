# Contrôle / maintenance plâtrerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-platrerie` |
| Titre | Contrôle / maintenance plâtrerie |
| Profession | `metier:platrerie` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:platrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Joints/bandes** sans fissure ; angles armés. `[C]`
- [ ] Absence d'**humidité** (plaques saines) ; hydro en pièce humide. `[C]`
- [ ] **Fixations/ossature** solides (pas de jeu). `[C]`
- [ ] **Planéité** ; surface prête à peindre (finition). `[C]`
- [ ] **Trappes de visite** accessibles ; réservations correctes. `[C]`
- [ ] Rénovation : **diagnostic amiante** préalable respecté. `[A]`

> Poussières (ponçage) = **masque/aspiration** ; charges lourdes = **renfort**.

## Cadre
- **Normes** : ouvrages en plaques de plâtre **DTU 25.41** ; doublages / habillages **DTU 25.42** ; plafonds suspendus **DTU 58.1** ; électricité (perc ements / boîtes) **NF C 15-100** ; en rénovation, diagnostic **amiante** avant travaux (Code de la santé) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [diagnostiquer-controler-platrerie](../../professions/platrerie/cards/diagnostiquer-controler-platrerie.md).
- **Tags** : `metier:platrerie famille:finition sous-famille:platrerie type:checklist cluster:diagnostics cluster:reparations securite:poussieres`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
