# Installer lecteurs et claviers

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `installer-lecteurs-claviers` |
| Titre | Installer lecteurs et claviers |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:controle-acces` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : installer les **lecteurs** (badge/biométrique) et **claviers à code**, câblés au contrôleur. `[C]`
- **Résumé** : poser les **lecteurs** (RFID, **biométriques**) et **claviers** côté non sécurisé de la porte, les câbler au **contrôleur (UTL)** (bus/Wiegand/OSDP/IP), prévoir un **bouton de demande de sortie** côté intérieur, et un lecteur biométrique **uniquement si justifié** (RGPD/CNIL). `[C]` ⟦protocole/type de lecteur selon système à confirmer⟧

## Réalisation
- **Étapes** :
  1. Poser lecteurs/claviers côté **non sécurisé** ; câbler au contrôleur. `[C]`
  2. Protocole sécurisé (**OSDP** > Wiegand) / IP. `[C]` → [cabler-rj45-reseau](../../../professions/reseaux-vdi/cards/cabler-rj45-reseau.md)
  3. Prévoir le **bouton de demande de sortie** (intérieur). `[A]`
  4. **Biométrie** : seulement si justifié (**RGPD/CNIL**). `[A]`
- **Points critiques** : lecteur côté non sécurisé ; **demande de sortie** ; protocole sécurisé ; **biométrie encadrée** (données sensibles).
- **Sécurité** : cyber (protocole) ; RGPD/biométrie ; électrique. **Fonctionnement en sécurité incendie / déverrouillage d'urgence** : une porte contrôlée sur un **cheminement d'évacuation** doit **toujours permettre la sortie** — déverrouillage automatique sur alarme incendie (**DAS**), **dispositif de demande de sortie** (bouton/barre) — **ne jamais entraver une issue de secours** (danger vital). **Consignation de l'alimentation** avant intervention (**habilité**, NF C 18-510). **Continuité de service / alimentation secourue** : comportement défini en coupure (fail-safe/fail-secure selon la sécurité des personnes). **Cybersécurité / authentification** : lecteurs/contrôleurs IP = cibles (mots de passe, MAJ, segmentation, protocoles sécurisés). **Confidentialité / RGPD / biométrie** : les **données biométriques sont sensibles** → cadre **CNIL** strict (règlement type, **AIPD**, préférer le badge sauf nécessité) ; le **journal des accès** est une donnée personnelle (durée/accès limités). **Arrêt immédiat en cas de danger.** Alimentation & sécurité incendie **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Badges / cartes** : `cite-carte` → [gerer-badges-cartes-rfid](gerer-badges-cartes-rfid.md)

## Relations & tags
- **Tags** : `metier:controle-acces famille:electricite sous-famille:controle-acces intervention:poser cluster:lecteurs-de-badges cluster:lecteurs-biometriques cluster:claviers-a-code complexite:avancee type:installation securite:rgpd relation:reseaux-vdi`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
