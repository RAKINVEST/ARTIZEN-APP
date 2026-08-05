# Contrôle / maintenance cuisine

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-cuisine` |
| Titre | Contrôle / maintenance cuisine |
| Profession | `metier:cuisine` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:cuisine` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Caissons** de niveau/solidarisés ; meubles bas stables. `[C]`
- [ ] **Meubles hauts** : **fixation** sûre (charge) — pas de jeu. `[A]`
- [ ] **Plan de travail** : jonctions/chants ; **joints** évier/crédence étanches. `[C]`
- [ ] **Façades/tiroirs** alignés, jeux réguliers, quincaillerie OK. `[C]`
- [ ] **Évier/électroménager** : étanchéité/ventilation ; raccordements par les **corps d'état** (Plomberie/Élec). `[C]`
- [ ] Rénovation : **amiante** (éléments anciens) vérifié. `[A]`

> Manutention plans (**pierre**) = binôme ; découpe = **silice/poussières**.

## Cadre
- **Normes** : meubles / caissons (menuiserie intérieure) **DTU 36.2** ; électricité de la cuisine (circuits spécialisés, **interface**) **NF C 15-100** ; plomberie évier / robinetterie (**interface**) **DTU 60.1** ; diagnostic **amiante** (ouvrages anciens) et **ventilation** des appareils ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [entretenir-diagnostiquer-cuisine](../../professions/cuisine/cards/entretenir-diagnostiquer-cuisine.md).
- **Tags** : `metier:cuisine famille:finition sous-famille:cuisine type:checklist cluster:reglages-de-facades cluster:maintenance securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
