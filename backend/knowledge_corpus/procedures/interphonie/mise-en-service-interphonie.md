# Mise en service d'une interphonie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `mise-en-service-interphonie` |
| Titre | Mise en service d'une interphonie |
| Profession | `metier:interphonie` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:interphonie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## But
- Vérifier qu'une interphonie fonctionne complètement avant remise. `[C]`

## Étapes
1. Tester l'**appel** (chaque bouton → bon moniteur, collectif). `[C]`
2. Tester la **communication audio** (les deux sens) et **vidéo** (jour/nuit). `[C]` → [installer-platine-rue](../../professions/interphonie/cards/installer-platine-rue.md)
3. Tester la **commande d'ouverture** (interface gâche) + temporisation. `[C]` → [raccorder-commande-gache](../../professions/interphonie/cards/raccorder-commande-gache.md)
4. IP/SIP : vérifier renvoi/notifications + **sécurité** ; RGPD (visiophone). `[A]`

> En visiophonie, informer/respecter la **vie privée** (champ caméra, enregistrement). `[A]`

## Cadre
- **Normes** : alimentation des équipements **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes d'interphonie de bâtiment **EN 62820**, communication **SIP** (IP), données/images (**RGPD**, **CNIL**) et cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [essayer-maintenir-interphonie](../../professions/interphonie/cards/essayer-maintenir-interphonie.md).
- **Tags** : `metier:interphonie famille:electricite sous-famille:interphonie intervention:controler cluster:essais cluster:communication-video type:procedure securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
