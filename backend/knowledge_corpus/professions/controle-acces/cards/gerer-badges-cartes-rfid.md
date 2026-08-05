# Gérer badges, cartes et RFID

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `gerer-badges-cartes-rfid` |
| Titre | Gérer badges, cartes et RFID |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:controle-acces` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : gérer les identifiants **badges RFID / cartes** : encodage, attribution, révocation. `[C]`
- **Résumé** : choisir une technologie **RFID sécurisée** (éviter les cartes clonables anciennes), **encoder/attribuer** les badges/cartes aux utilisateurs avec leurs droits, gérer les pertes par **révocation immédiate**, et tenir l'inventaire ; les badges sont des identifiants liés à des **données personnelles** (RGPD). `[C]` ⟦technologie RFID selon sécurité visée à confirmer⟧

## Réalisation
- **Étapes** :
  1. Choisir une **RFID sécurisée** (éviter le clonable). `[C]` ⟦à confirmer⟧
  2. Encoder/attribuer badges & cartes ; définir les droits. `[C]` → [gerer-droits-utilisateurs-journal](gerer-droits-utilisateurs-journal.md)
  3. **Révocation immédiate** en cas de perte/vol. `[A]`
  4. Tenir l'inventaire (RGPD : lien identifiant↔personne). `[C]`
- **Points critiques** : **RFID sécurisée** (anti-clonage) ; révocation immédiate ; inventaire ; **données personnelles** (RGPD).
- **Sécurité** : confidentialité/RGPD ; cyber (clonage) ; — **Fonctionnement en sécurité incendie / déverrouillage d'urgence** : une porte contrôlée sur un **cheminement d'évacuation** doit **toujours permettre la sortie** — déverrouillage automatique sur alarme incendie (**DAS**), **dispositif de demande de sortie** (bouton/barre) — **ne jamais entraver une issue de secours** (danger vital). **Consignation de l'alimentation** avant intervention (**habilité**, NF C 18-510). **Continuité de service / alimentation secourue** : comportement défini en coupure (fail-safe/fail-secure selon la sécurité des personnes). **Cybersécurité / authentification** : lecteurs/contrôleurs IP = cibles (mots de passe, MAJ, segmentation, protocoles sécurisés). **Confidentialité / RGPD / biométrie** : les **données biométriques sont sensibles** → cadre **CNIL** strict (règlement type, **AIPD**, préférer le badge sauf nécessité) ; le **journal des accès** est une donnée personnelle (durée/accès limités). **Arrêt immédiat en cas de danger.** Alimentation & sécurité incendie **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Couplage armement (alarme)** : `cite-carte` → [configurer-badges-telecommandes-armement](../../../professions/alarme-intrusion/cards/configurer-badges-telecommandes-armement.md)

## Relations & tags
- **Tags** : `metier:controle-acces famille:electricite sous-famille:controle-acces intervention:configurer cluster:badges-rfid cluster:cartes complexite:moyenne type:configuration securite:rgpd relation:alarme-intrusion`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
