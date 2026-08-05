# Gérer droits, utilisateurs & journalisation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `gerer-droits-utilisateurs-journal` |
| Titre | Gérer droits, utilisateurs & journalisation |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:controle-acces` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : gérer les **droits d'accès**, les **utilisateurs** (profils, plages horaires) et la **journalisation** dans le respect du RGPD. `[C]`
- **Résumé** : définir des **profils de droits** (qui / où / quand : zones + **plages horaires**), gérer le cycle de vie des utilisateurs (arrivée/départ/**révocation**), configurer la **journalisation** des accès (nécessaire mais = **donnée personnelle** : durée/accès limités, information) et documenter ; conformité **RGPD/CNIL**. `[C]` ⟦profils/durée de journalisation selon RGPD à confirmer⟧

## Réalisation
- **Étapes** :
  1. Définir **profils de droits** (zones + **plages horaires**). `[C]`
  2. Gérer le cycle de vie utilisateurs (**révocation** au départ). `[A]`
  3. **Journalisation** des accès : durée/accès **limités** (RGPD). `[A]`
  4. Informer les personnes ; documenter. `[C]` → [securiser-systeme-controle-acces](securiser-systeme-controle-acces.md)
- **Points critiques** : moindre privilège ; révocation à jour ; **journal = donnée personnelle** (durée/accès limités, information RGPD).
- **Sécurité** : confidentialité/**RGPD** (journal) ; cyber ; — **Fonctionnement en sécurité incendie / déverrouillage d'urgence** : une porte contrôlée sur un **cheminement d'évacuation** doit **toujours permettre la sortie** — déverrouillage automatique sur alarme incendie (**DAS**), **dispositif de demande de sortie** (bouton/barre) — **ne jamais entraver une issue de secours** (danger vital). **Consignation de l'alimentation** avant intervention (**habilité**, NF C 18-510). **Continuité de service / alimentation secourue** : comportement défini en coupure (fail-safe/fail-secure selon la sécurité des personnes). **Cybersécurité / authentification** : lecteurs/contrôleurs IP = cibles (mots de passe, MAJ, segmentation, protocoles sécurisés). **Confidentialité / RGPD / biométrie** : les **données biométriques sont sensibles** → cadre **CNIL** strict (règlement type, **AIPD**, préférer le badge sauf nécessité) ; le **journal des accès** est une donnée personnelle (durée/accès limités). **Arrêt immédiat en cas de danger.** Alimentation & sécurité incendie **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-controle-acces](../../../kits/controle-acces/kit-controle-acces.md)

## Relations & tags
- **Tags** : `metier:controle-acces famille:electricite sous-famille:controle-acces intervention:configurer cluster:droits-d-acces cluster:gestion-des-utilisateurs cluster:journalisation complexite:moyenne type:configuration securite:rgpd`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
