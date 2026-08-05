# Badge refusé / droit incorrect

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `badge-refuse-droit` |
| Titre | Badge refusé / droit incorrect |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:controle-acces` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Un badge/code **refusé** alors qu'il devrait être autorisé (ou l'inverse). `[C]`

## Causes probables
1. **Droit/profil** ou **plage horaire** mal configurés. `[C]` → [gerer-droits-utilisateurs-journal](../../professions/controle-acces/cards/gerer-droits-utilisateurs-journal.md)
2. **Badge** non encodé/révoqué/démagnétisé. `[C]` → [gerer-badges-cartes-rfid](../../professions/controle-acces/cards/gerer-badges-cartes-rfid.md)
3. **Lecteur** défaillant / protocole. `[C]` → [installer-lecteurs-claviers](../../professions/controle-acces/cards/installer-lecteurs-claviers.md)

## Résolution
- Vérifier droits/plages, réémettre/encoder le badge, tester le lecteur ; consulter le **journal**. `[C]`

## Cadre
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [gerer-droits-utilisateurs-journal](../../professions/controle-acces/cards/gerer-droits-utilisateurs-journal.md).
- **Tags** : `metier:controle-acces famille:electricite sous-famille:controle-acces probleme:droit cluster:droits-d-acces cluster:badges-rfid cluster:diagnostic type:diagnostic securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
