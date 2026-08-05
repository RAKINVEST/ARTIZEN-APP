# Poser l'organe de verrouillage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-organe-verrouillage` |
| Titre | Poser l'organe de verrouillage |
| Profession | `metier:controle-acces` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:controle-acces` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser l'organe de verrouillage (**gâche** / **ventouse électromagnétique** / **serrure électrique**) selon le mode de sécurité. `[C]`
- **Résumé** : choisir et poser l'organe adapté — **gâche électrique**, **ventouse électromagnétique** ou **serrure motorisée** — en définissant le comportement en coupure : **rupture de sécurité (fail-safe : ouvre en coupure)** pour les issues d'évacuation, **rupture de sûreté (fail-secure)** ailleurs ; l'alimentation relève d'un **habilité**. `[C]` ⟦type/mode de sécurité selon porte et évacuation à confirmer⟧

## Réalisation
- **Étapes** :
  1. Choisir l'organe (gâche/**ventouse**/serrure) selon la porte. `[C]`
  2. Définir le mode : **fail-safe** (évacuation) / fail-secure (ailleurs). `[A]`
  3. Alimentation dédiée (secourue) = **habilité**. `[A]` → [controler-tableau-electrique](../../../professions/electricite-generale/cards/controler-tableau-electrique.md)
  4. Vérifier tenue mécanique + sécurité incendie. `[A]` → [raccorder-securite-incendie-sortie](raccorder-securite-incendie-sortie.md)
- **Points critiques** : **mode de sécurité** (fail-safe sur évacuation) = vital ; alimentation secourue ; tenue mécanique ; ventouse = maintien en coupure ?
- **Sécurité** : **sécurité incendie** (évacuation) ; électrique (alim) ; mécanique. **Fonctionnement en sécurité incendie / déverrouillage d'urgence** : une porte contrôlée sur un **cheminement d'évacuation** doit **toujours permettre la sortie** — déverrouillage automatique sur alarme incendie (**DAS**), **dispositif de demande de sortie** (bouton/barre) — **ne jamais entraver une issue de secours** (danger vital). **Consignation de l'alimentation** avant intervention (**habilité**, NF C 18-510). **Continuité de service / alimentation secourue** : comportement défini en coupure (fail-safe/fail-secure selon la sécurité des personnes). **Cybersécurité / authentification** : lecteurs/contrôleurs IP = cibles (mots de passe, MAJ, segmentation, protocoles sécurisés). **Confidentialité / RGPD / biométrie** : les **données biométriques sont sensibles** → cadre **CNIL** strict (règlement type, **AIPD**, préférer le badge sauf nécessité) ; le **journal des accès** est une donnée personnelle (durée/accès limités). **Arrêt immédiat en cas de danger.** Alimentation & sécurité incendie **réservées aux professionnels compétents**.** `[A]`

## Cadre & suites
- **Normes** : alimentation des organes (serrures/lecteurs) **NF C 15-100** ; consignation à l'intervention **NF C 18-510** ; systèmes de contrôle d'accès électroniques **EN 60839**, sécurité incendie / issues de secours (réglementation ERP / **Code du travail**), données et **biométrie** (**RGPD**, **CNIL** — règlement type / **AIPD**), cybersécurité (**ANSSI**) ⟦en prose, à confirmer⟧ `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Essais sécurité** : `cite-procedure` → [essai-securite-incendie-deverrouillage](../../../procedures/controle-acces/essai-securite-incendie-deverrouillage.md)

## Relations & tags
- **Tags** : `metier:controle-acces famille:electricite sous-famille:controle-acces intervention:poser cluster:serrures-electriques cluster:gaches-electriques cluster:ventouses-electromagnetiques complexite:avancee type:installation securite:incendie relation:electricite-generale`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
