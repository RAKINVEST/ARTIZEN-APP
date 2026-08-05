# Contrôle / maintenance contrôle d'accès

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controle-maintenance-controle-acces` |
| Titre | Contrôle / maintenance contrôle d'accès |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:controle-acces` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Points à vérifier
- [ ] **Déverrouillage de sécurité** (demande de sortie/DAS) testé sur chaque porte. `[A]`
- [ ] **Organes** (gâche/ventouse/serrure) : tenue/fonctionnement. `[C]`
- [ ] **Alimentation secourue** (autonomie) vérifiée. `[C]`
- [ ] **Droits/utilisateurs** à jour ; révocations effectuées. `[C]`
- [ ] **Journalisation** conforme (durée/accès limités — RGPD). `[A]`
- [ ] **Cyber** : mots de passe, MAJ, segmentation ; biométrie encadrée. `[A]`

> **Priorité absolue** : aucune porte n'entrave une évacuation ; alimentation = **habilité**.

## Cadre
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `verifie` → [essayer-maintenir-controle-acces](../../professions/controle-acces/cards/essayer-maintenir-controle-acces.md).
- **Tags** : `metier:controle-acces famille:electricite sous-famille:controle-acces type:checklist cluster:maintenance cluster:essais securite:incendie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
