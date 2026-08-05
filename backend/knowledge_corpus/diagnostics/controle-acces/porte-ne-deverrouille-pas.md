# La porte ne se déverrouille pas

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `porte-ne-deverrouille-pas` |
| Titre | La porte ne se déverrouille pas |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:controle-acces` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Une porte contrôlée **ne s'ouvre pas** (badge valide, ou demande de sortie sans effet). `[C]`

> **DANGER si issue de secours** : une sortie doit toujours être possible → vérifier en priorité le **déverrouillage de sécurité**. `[A]`

## Causes probables
1. **Organe** (gâche/ventouse) ou **alimentation** défaillants. `[C]` → [poser-organe-verrouillage](../../professions/controle-acces/cards/poser-organe-verrouillage.md)
2. **Demande de sortie / DAS** non fonctionnels (sécurité incendie). `[A]` → [raccorder-securite-incendie-sortie](../../professions/controle-acces/cards/raccorder-securite-incendie-sortie.md)
3. **Droit/plage horaire** incorrects (contrôleur). `[C]` → [badge-refuse-droit](badge-refuse-droit.md)

## Résolution
- **Vérifier d'abord la sortie de secours**, puis organe/alim/droits ; côté alimentation → **habilité**. `[A]`

## Cadre
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [essai-securite-incendie-deverrouillage](../../procedures/controle-acces/essai-securite-incendie-deverrouillage.md).
- **Tags** : `metier:controle-acces famille:electricite sous-famille:controle-acces probleme:verrouillage cluster:serrures-electriques cluster:diagnostic type:diagnostic securite:incendie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
