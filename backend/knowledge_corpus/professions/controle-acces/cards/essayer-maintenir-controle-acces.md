# Essayer / maintenir le contrôle d'accès

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `essayer-maintenir-controle-acces` |
| Titre | Essayer / maintenir le contrôle d'accès |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:controle-acces` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : réaliser les **essais** (dont déverrouillage de sécurité) et la **maintenance** (organes, alimentation secourue, droits). `[C]`
- **Résumé** : tester chaque porte (autorisation/refus, **déverrouillage de sécurité incendie/demande de sortie**), l'état des **organes** (gâche/ventouse), l'**alimentation secourue** (autonomie), la cohérence des **droits** et la journalisation, appliquer les MAJ et documenter ; une porte de secours doit **toujours** s'ouvrir. `[C]`

## Réalisation
- **Étapes** :
  1. Tester autorisation/refus + **déverrouillage de sécurité** (vital). `[A]` → [essai-securite-incendie-deverrouillage](../../../procedures/controle-acces/essai-securite-incendie-deverrouillage.md)
  2. Contrôler organes + **alimentation secourue** (autonomie). `[C]` → [defaut-alimentation-secours-acces](../../../diagnostics/controle-acces/defaut-alimentation-secours-acces.md)
  3. Vérifier **droits**/révocations + journalisation. `[C]`
  4. Appliquer MAJ (cyber) ; documenter. `[C]`
- **Points critiques** : **déverrouillage de sécurité testé** (issue toujours ouvrable) ; alimentation secourue ; droits à jour ; MAJ.
- **Sécurité** : sécurité incendie (essai) ; électrique ; cyber/RGPD. **Fonctionnement en sécurité incendie / déverrouillage d'urgence** : une porte contrôlée sur un **cheminement d'évacuation** doit **toujours permettre la sortie** — déverrouillage automatique sur alarme incendie (**DAS**), **dispositif de demande de sortie** (bouton/barre) — **ne jamais entraver une issue de secours** (danger vital). **Consignation de l'alimentation** avant intervention (**habilité**, NF C 18-510). **Continuité de service / alimentation secourue** : comportement défini en coupure (fail-safe/fail-secure selon la sécurité des personnes). **Cybersécurité / authentification** : lecteurs/contrôleurs IP = cibles (mots de passe, MAJ, segmentation, protocoles sécurisés). **Confidentialité / RGPD / biométrie** : les **données biométriques sont sensibles** → cadre **CNIL** strict (règlement type, **AIPD**, préférer le badge sauf nécessité) ; le **journal des accès** est une donnée personnelle (durée/accès limités). **Arrêt immédiat en cas de danger.** Alimentation & sécurité incendie **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Contrôle** : `a-checklist` → [controle-maintenance-controle-acces](../../../checklists/controle-acces/controle-maintenance-controle-acces.md)

## Relations & tags
- **Tags** : `metier:controle-acces famille:electricite sous-famille:controle-acces intervention:entretenir intervention:controler cluster:essais cluster:maintenance cluster:diagnostic complexite:moyenne type:entretien securite:incendie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
