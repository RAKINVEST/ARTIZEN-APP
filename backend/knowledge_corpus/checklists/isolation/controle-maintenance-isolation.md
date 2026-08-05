# Contrôle / maintenance de l'isolation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-isolation` |
| Titre | Contrôle / maintenance de l'isolation |
| Profession | `metier:isolation` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:isolation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] Isolant en place, non **tassé**/dégradé. `[C]`
- [ ] Absence d'**humidité**/moisissure/trace d'eau. `[C]`
- [ ] **Pare/frein-vapeur** continu (pas de déchirure). `[C]`
- [ ] **Ponts thermiques** maîtrisés (liaisons). `[C]`
- [ ] **Ventilation** de sous-toiture/logement fonctionnelle. `[C]`
- [ ] Absence de nuisibles/rongeurs. `[C]`

> Combles : circuler **uniquement sur zones porteuses** ; **EPI** poussières/fibres.

## Cadre
- **Normes** : isolation des combles par soufflage **DTU 45.10** ; isolation thermique de combles **DTU 45.11** ; doublage / plaques de plâtre (isolation intérieure) **DTU 25.41** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [diagnostiquer-isolation](../../professions/isolation/cards/diagnostiquer-isolation.md).
- **Tags** : `metier:isolation famille:enveloppe sous-famille:isolation type:checklist cluster:controle cluster:entretien cluster:diagnostic securite:respiratoire relation:ventilation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
