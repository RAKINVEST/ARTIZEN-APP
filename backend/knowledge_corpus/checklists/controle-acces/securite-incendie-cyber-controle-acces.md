# Sécurité — incendie, alimentation & cyber/RGPD (contrôle d'accès)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securite-incendie-cyber-controle-acces` |
| Titre | Sécurité — incendie, alimentation & cyber/RGPD (contrôle d'accès) |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **B** |

## Points à vérifier
- [ ] **Sécurité incendie** : issue de secours **toujours ouvrable** (DAS/demande de sortie). `[A]`
- [ ] **Consignation** de l'alimentation avant intervention (**habilité**). `[A]`
- [ ] **Alimentation secourue** ; comportement défini en coupure (fail-safe/secure). `[A]`
- [ ] **Cyber / authentification** : mots de passe, MAJ, segmentation, OSDP. `[A]`
- [ ] **RGPD / biométrie** : données sensibles encadrées (AIPD/CNIL), journal limité. `[A]`
- [ ] **Arrêt immédiat** en cas de danger. `[A]`

## Cadre
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-procedure` → [essai-securite-incendie-deverrouillage](../../procedures/controle-acces/essai-securite-incendie-deverrouillage.md).
- **Tags** : `metier:controle-acces famille:electricite sous-famille:securite type:checklist cluster:controle-d-acces securite:incendie securite:cyber`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
