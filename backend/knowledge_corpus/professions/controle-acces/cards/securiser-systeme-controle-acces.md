# Sécuriser le système (cyber, authentification & biométrie)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `securiser-systeme-controle-acces` |
| Titre | Sécuriser le système (cyber, authentification & biométrie) |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:controle-acces` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : sécuriser le système (cybersécurité/authentification) et encadrer la **biométrie** (données sensibles). `[C]`
- **Résumé** : durcir la cybersécurité (mots de passe, **mises à jour**, **segmentation**, protocoles sécurisés **OSDP**, chiffrement), renforcer l'**authentification** (multi-facteurs pour l'administration), et **encadrer la biométrie** : données **sensibles** au sens RGPD → cadre **CNIL** (règlement type, **AIPD**), préférer le badge sauf nécessité démontrée. `[C]` ⟦mesures/AIPD selon contexte à confirmer⟧

## Réalisation
- **Étapes** :
  1. Durcir : mots de passe, **MAJ**, **segmentation**, OSDP/chiffrement. `[A]` → [securiser-maintenir-domotique](../../../professions/domotique/cards/securiser-maintenir-domotique.md)
  2. **Authentification** administration renforcée (MFA). `[C]`
  3. **Biométrie** = données sensibles → **AIPD/CNIL** ; badge par défaut. `[A]`
  4. Protéger le **journal**/les identifiants (RGPD). `[A]`
- **Points critiques** : cyber (protocole sécurisé) ; **biométrie encadrée** (AIPD, badge préféré) ; protection des données (RGPD).
- **Sécurité** : cyber ; RGPD/**biométrie sensible** ; confidentialité. **Fonctionnement en sécurité incendie / déverrouillage d'urgence** : une porte contrôlée sur un **cheminement d'évacuation** doit **toujours permettre la sortie** — déverrouillage automatique sur alarme incendie (**DAS**), **dispositif de demande de sortie** (bouton/barre) — **ne jamais entraver une issue de secours** (danger vital). **Consignation de l'alimentation** avant intervention (**habilité**, NF C 18-510). **Continuité de service / alimentation secourue** : comportement défini en coupure (fail-safe/fail-secure selon la sécurité des personnes). **Cybersécurité / authentification** : lecteurs/contrôleurs IP = cibles (mots de passe, MAJ, segmentation, protocoles sécurisés). **Confidentialité / RGPD / biométrie** : les **données biométriques sont sensibles** → cadre **CNIL** strict (règlement type, **AIPD**, préférer le badge sauf nécessité) ; le **journal des accès** est une donnée personnelle (durée/accès limités). **Arrêt immédiat en cas de danger.** Alimentation & sécurité incendie **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Maintenance** : `cite-carte` → [essayer-maintenir-controle-acces](essayer-maintenir-controle-acces.md)

## Relations & tags
- **Tags** : `metier:controle-acces famille:electricite sous-famille:controle-acces intervention:securiser cluster:lecteurs-biometriques cluster:droits-d-acces complexite:avancee type:configuration securite:cyber securite:rgpd relation:domotique`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
