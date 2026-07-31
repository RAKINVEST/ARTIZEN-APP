# La Constitution d'ARTIZEN — carte des documents fondateurs

Ces documents ne sont pas une simple collection de fichiers. **Chacun répond à
une question différente** ; ensemble, ils forment la constitution du projet — et
montrent que la technique est une *conséquence*, la promesse une *cause*.

```
                 CONSTITUTION
                      │
      ┌───────────────┴───────────────┐
      │                               │
  BRAND.md          EXTRACTION_SPEC.md · REPRODUCTION_SPEC.md
   (la cause)                     │
      │                 GOLD_STANDARD_PROTOCOL.md
      │                               │
      └───────────────┬───────────────┘
                      │
               DECISION_LOG.md
                      │
          ┌───────────┴───────────┐
          │                       │
    UNKNOWNS.md            EXPERIMENTS.md
                      │
               SUCCESS_CRITERIA.md
```

## Chaque document, une question

| Document | Répond à |
|---|---|
| [BRAND.md](BRAND.md) | **Pourquoi existons-nous ?** (et sa règle d'or : *« Je ne vois pas la différence avec le mien. »*) |
| [EXTRACTION_SPEC.md](../backend/app/document_clone/EXTRACTION_SPEC.md) | Comment le moteur **décrit**-il le document ? |
| [REPRODUCTION_SPEC.md](../backend/app/document_clone/REPRODUCTION_SPEC.md) | Comment le renderer **redessine**-t-il à l'identique ? |
| [GOLD_STANDARD_PROTOCOL.md](../backend/app/document_clone/GOLD_STANDARD_PROTOCOL.md) | Comment garantir que nos références sont fiables ? |
| [DECISION_LOG.md](../backend/app/document_clone/DECISION_LOG.md) | Pourquoi avons-nous fait ce choix ? |
| [UNKNOWNS.md](../backend/app/document_clone/UNKNOWNS.md) | Que ne savons-nous pas encore ? |
| [EXPERIMENTS.md](../backend/app/document_clone/EXPERIMENTS.md) | Comment allons-nous le découvrir ? |
| [SUCCESS_CRITERIA.md](../backend/app/document_clone/SUCCESS_CRITERIA.md) | Quand considérerons-nous l'objectif atteint ? |

## Études et journaux — la gouvernance qui évolue

Autour de cette constitution *stable*, des documents **vivants** : ils tranchent
une question par la mesure (études) ou tiennent la trace du progrès (journaux).
On les fait évoluer sans jamais toucher aux fondations.

| Document | Répond à |
|---|---|
| [DECISIONS.md](DECISIONS.md) | Quelles décisions **produit** ne se rediscutent pas ? (8 règles, dont la protection de l'identité documentaire) |
| [TYPOGRAPHY_STRATEGY.md](../backend/app/document_clone/TYPOGRAPHY_STRATEGY.md) | Comment reproduire les **polices** ? (étude → décision E) |
| [ETUDE-SECURISATION-JURIDIQUE.md](ETUDE-SECURISATION-JURIDIQUE.md) | Comment **protéger** l'identité contre un usage tiers ? (→ Décision 8) |
| [PERFORMANCE_HISTORY.md](../backend/app/document_clone/PERFORMANCE_HISTORY.md) | Où en est la **qualité**, étape après étape ? (E-004 → E-012) |
| [P1_FINAL_REPORT.md](P1_FINAL_REPORT.md) | **Rapport de clôture du programme P1** — l'histoire complète, réussites et échecs (référence historique) |

## L'ordre de lecture

Un nouvel arrivant lit **[BRAND.md](BRAND.md) en premier** : la promesse avant la
technique. Ensuite seulement le reste, dans le sens de la flèche — du *pourquoi*
(la marque) vers le *comment* (le moteur), puis le *pourquoi de nos choix*
(décisions), l'*inconnu* (questions), sa *résolution* (expériences), et enfin la
*définition du succès*.

**BRAND.md est stable ; tout le reste peut évoluer.** C'est cette asymétrie qui
garantit qu'ARTIZEN évoluera pendant dix ans sans perdre ce qui le rend unique.

## Gel du référentiel documentaire *(décision PO — 2026-07-31)*

Le **référentiel opérationnel de mise en production** est **GELÉ** :
`ADR`, `DECISIONS.md`, `CLAUDE.md`, `MASTER_EXECUTION_PLAN_FINAL.md`,
`RC1_DOSSIER.md`, `DEPLOYMENT_INPUTS.md`, `DEPLOYMENT-T3.md`,
`BACKUP_RESTORE.md`, `KNOWN_LIMITATIONS.md`.

Aucune modification de ces documents n'est autorisée, **sauf** déclenchée par l'un
des trois événements suivants :

1. une **décision explicite du PO** ;
2. une **exigence juridique ou réglementaire** ;
3. un **retour d'expérience observé en production**.

Les corrections de style, de formulation, de structure, de présentation ou de
**perfectionnement** sont désormais **interdites**. Toute proposition de
modification doit **nommer explicitement** son événement déclencheur parmi ces
trois catégories. À défaut, la réponse est exactement :
**« Référentiel gelé — aucune modification autorisée. »**
