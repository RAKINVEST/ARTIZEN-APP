# Principe du contrôle d'accès

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-controle-acces` |
| Titre | Principe du contrôle d'accès |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:controle-acces` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre l'architecture : **identifiant → lecteur → contrôleur (UTL) → organe de verrouillage**, et la contrainte **sécurité incendie**. `[C]`
- **Résumé** : un contrôle d'accès autorise ou refuse le passage : un **identifiant** (badge, code, biométrie) lu par un **lecteur** est validé par un **contrôleur (UTL)** qui commande l'**organe de verrouillage** (gâche, ventouse, serrure) ; il gère des **droits/plages horaires** et une **journalisation** ; contrainte majeure : la **sécurité incendie** (une issue de secours doit toujours s'ouvrir). `[C]` ⟦architecture/niveau selon site à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Lecteurs** (badge/bio/clavier) + **contrôleur**. `[C]` → [installer-lecteurs-claviers](installer-lecteurs-claviers.md)
  2. **Organe de verrouillage** (gâche/ventouse/serrure). `[C]` → [poser-organe-verrouillage](poser-organe-verrouillage.md)
  3. **Sécurité incendie / déverrouillage d'urgence** (vital). `[A]` → [raccorder-securite-incendie-sortie](raccorder-securite-incendie-sortie.md)
  4. **Droits/utilisateurs/journalisation** (RGPD). `[C]` → [gerer-droits-utilisateurs-journal](gerer-droits-utilisateurs-journal.md)
- **Points critiques** : **sécurité incendie** prioritaire (issue de secours) ; fail-safe/secure selon usage ; **RGPD** (journal/biométrie) ; cyber.
- **Sécurité** : sécurité incendie (évacuation) ; alimentation ; cyber/RGPD. **Fonctionnement en sécurité incendie / déverrouillage d'urgence** : une porte contrôlée sur un **cheminement d'évacuation** doit **toujours permettre la sortie** — déverrouillage automatique sur alarme incendie (**DAS**), **dispositif de demande de sortie** (bouton/barre) — **ne jamais entraver une issue de secours** (danger vital). **Consignation de l'alimentation** avant intervention (**habilité**, NF C 18-510). **Continuité de service / alimentation secourue** : comportement défini en coupure (fail-safe/fail-secure selon la sécurité des personnes). **Cybersécurité / authentification** : lecteurs/contrôleurs IP = cibles (mots de passe, MAJ, segmentation, protocoles sécurisés). **Confidentialité / RGPD / biométrie** : les **données biométriques sont sensibles** → cadre **CNIL** strict (règlement type, **AIPD**, préférer le badge sauf nécessité) ; le **journal des accès** est une donnée personnelle (durée/accès limités). **Arrêt immédiat en cas de danger.** Alimentation & sécurité incendie **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Couplage vidéo** (vérification) : `cite-carte` → [principe-videosurveillance](../../../professions/videosurveillance/cards/principe-videosurveillance.md)

## Relations & tags
- **Tags** : `metier:controle-acces famille:electricite sous-famille:controle-acces intervention:comprendre cluster:controle-d-acces cluster:lecteurs-de-badges cluster:serrures-electriques cluster:droits-d-acces type:principe securite:incendie relation:videosurveillance`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
