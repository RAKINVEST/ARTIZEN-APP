# L'ouverture (gâche) ne fonctionne pas

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `gache-ne-fonctionne-pas` |
| Titre | L'ouverture (gâche) ne fonctionne pas |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:interphonie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- L'appui sur le bouton d'ouverture **ne déverrouille pas** la porte. `[C]`

## Causes probables
1. **Commande** (sortie interphone) ou temporisation mal réglée. `[C]` → [raccorder-commande-gache](../../professions/interphonie/cards/raccorder-commande-gache.md)
2. **Organe** (gâche/ventouse)/alimentation — relève du **Contrôle d'accès**. `[C]` → [poser-organe-verrouillage](../../professions/controle-acces/cards/poser-organe-verrouillage.md)
3. Compatibilité tension/type de gâche. `[C]`

## Résolution
- Vérifier la **commande** côté interphone ; l'organe/le mode de sécurité (incendie) → **Contrôle d'accès**. `[C]`

## Cadre
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [raccorder-commande-gache](../../professions/interphonie/cards/raccorder-commande-gache.md).
- **Tags** : `metier:interphonie famille:electricite sous-famille:interphonie probleme:ouverture cluster:gache-commandee cluster:diagnostic type:diagnostic securite:electrique relation:controle-acces`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
