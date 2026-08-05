# Raccorder la sécurité incendie & le déverrouillage de sortie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `raccorder-securite-incendie-sortie` |
| Titre | Raccorder la sécurité incendie & le déverrouillage de sortie |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:securite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assurer le **déverrouillage de sécurité** : issue de secours toujours ouvrable (incendie/urgence). `[C]`
- **Résumé** : raccorder l'organe de verrouillage au **système de sécurité incendie** (**DAS** : déverrouillage automatique sur alarme/coupure), installer un **dispositif de demande de sortie** (bouton/barre anti-panique) côté intérieur, et un **déverrouillage d'urgence** ; une **issue de secours** ne doit **jamais** être condamnée — conformité **ERP/Code du travail**. `[C]` ⟦dispositifs/asservissements selon réglementation ERP à confirmer⟧

## Réalisation
- **Étapes** :
  1. Asservir au **SSI/DAS** (déverrouillage sur alarme incendie/coupure). `[A]` ⟦selon SSI à confirmer⟧
  2. Poser **demande de sortie** + **déverrouillage d'urgence** (bris de glace). `[A]`
  3. Barre **anti-panique** si issue de secours. `[A]`
  4. Vérifier : issue **toujours ouvrable** de l'intérieur. `[A]` → [essai-securite-incendie-deverrouillage](../../../procedures/controle-acces/essai-securite-incendie-deverrouillage.md)
- **Points critiques** : **la sortie prime toujours** (danger vital) ; asservissement SSI ; demande de sortie ; conformité ERP/Code du travail (réservé).
- **Sécurité** : **sécurité incendie / évacuation** (vital) ; électrique ; — **Fonctionnement en sécurité incendie / déverrouillage d'urgence** : une porte contrôlée sur un **cheminement d'évacuation** doit **toujours permettre la sortie** — déverrouillage automatique sur alarme incendie (**DAS**), **dispositif de demande de sortie** (bouton/barre) — **ne jamais entraver une issue de secours** (danger vital). **Consignation de l'alimentation** avant intervention (**habilité**, NF C 18-510). **Continuité de service / alimentation secourue** : comportement défini en coupure (fail-safe/fail-secure selon la sécurité des personnes). **Cybersécurité / authentification** : lecteurs/contrôleurs IP = cibles (mots de passe, MAJ, segmentation, protocoles sécurisés). **Confidentialité / RGPD / biométrie** : les **données biométriques sont sensibles** → cadre **CNIL** strict (règlement type, **AIPD**, préférer le badge sauf nécessité) ; le **journal des accès** est une donnée personnelle (durée/accès limités). **Arrêt immédiat en cas de danger.** Alimentation & sécurité incendie **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Continuité / alimentation** : `traite-diagnostic` → [defaut-alimentation-secours-acces](../../../diagnostics/controle-acces/defaut-alimentation-secours-acces.md)

## Relations & tags
- **Tags** : `metier:controle-acces famille:electricite sous-famille:securite intervention:realiser cluster:serrures-electriques cluster:controle-d-acces complexite:expert type:installation securite:incendie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
