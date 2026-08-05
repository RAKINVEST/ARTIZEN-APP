# Essai du déverrouillage de sécurité (incendie / sortie)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `essai-securite-incendie-deverrouillage` |
| Titre | Essai du déverrouillage de sécurité (incendie / sortie) |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## But
- Vérifier qu'aucune porte contrôlée ne peut **entraver une évacuation** (vital). `[A]`

## Étapes
1. Tester le **dispositif de demande de sortie** (bouton/barre) de chaque porte. `[A]`
2. Simuler une **alarme incendie / coupure** : vérifier le **déverrouillage automatique** (DAS) des portes d'évacuation. `[A]` ⟦selon SSI/ERP à confirmer⟧
3. Vérifier le **déverrouillage d'urgence** (bris de glace) et l'anti-panique. `[A]`
4. Contrôler le comportement en **coupure d'alimentation** (fail-safe). `[A]`

> Une porte de secours qui reste verrouillée = **danger vital** → correction immédiate. `[A]`

## Cadre
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [raccorder-securite-incendie-sortie](../../professions/controle-acces/cards/raccorder-securite-incendie-sortie.md).
- **Tags** : `metier:controle-acces famille:electricite sous-famille:securite intervention:controler cluster:controle-d-acces cluster:essais type:procedure securite:incendie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
