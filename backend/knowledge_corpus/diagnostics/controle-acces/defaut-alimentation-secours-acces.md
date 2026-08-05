# Défaut d'alimentation / secours

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `defaut-alimentation-secours-acces` |
| Titre | Défaut d'alimentation / secours |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:controle-acces` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Défaut **secteur**/batterie signalé ; comportement des portes **incertain** en coupure. `[C]`

> En coupure, chaque porte doit adopter son comportement défini (**fail-safe** sur évacuation) — vérifier la **sécurité des personnes**. `[A]`

## Causes probables
1. **Alimentation secourue** (batterie) en fin de vie. `[C]` → [essayer-maintenir-controle-acces](../../professions/controle-acces/cards/essayer-maintenir-controle-acces.md)
2. **Secteur** absent/défaillant. `[C]` → [controler-tableau-electrique](../../professions/electricite-generale/cards/controler-tableau-electrique.md)
3. Dimensionnement du secours insuffisant. `[C]`

## Résolution
- Remplacer batterie, vérifier l'alimentation (habilité), **tester le comportement en coupure** (évacuation). `[A]`

## Cadre
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [raccorder-securite-incendie-sortie](../../professions/controle-acces/cards/raccorder-securite-incendie-sortie.md).
- **Tags** : `metier:controle-acces famille:electricite sous-famille:controle-acces probleme:alimentation cluster:controle-d-acces cluster:diagnostic type:diagnostic securite:incendie relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
