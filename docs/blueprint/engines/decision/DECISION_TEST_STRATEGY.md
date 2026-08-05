# Decision Test Strategy — Stratégie de test (documentaire)

> **Version** 1.0 — **Status** Validated — **Owner** Decision — **Last Update** 2026-08-02
> **Depends On:** [../../implementation/TEST_STRATEGY.md](../../implementation/TEST_STRATEGY.md) — **Used By:** implémentation — **Niveau:** 3 · Implémentation

## Objective
Décrire **ce qu'il faudra tester** (aucun test écrit ici). Aligné sur [TEST_STRATEGY](../../implementation/TEST_STRATEGY.md).

## Cas de test attendus (par invariant)
| # | Invariant | Test attendu |
|---|---|---|
| T1 | Compréhension | une intention connue produit le bon `Intent` (verbe + cible) |
| T2 | Read-side strict | le pipeline 1→8 **n'écrit rien** (aucune persistance du cœur) |
| T3 | Barrière de validation | **rien** ne s'écrit avant la validation utilisateur (Loi 7/18) |
| T4 | Délégation | sur validation, l'écriture est faite par le **propriétaire** (Quote crée le `Quote`) |
| T5 | Aucune invention | le moteur ne propose que des connaissances **existantes** ; jamais un article/norme inventé |
| T6 | Priorités | un contenu validé/confiance A passe devant un Brouillon/D équivalent |
| T7 | Tenant | ne propose que des données du `company_id` du contexte ; mismatch → introuvable |
| T8 | Aucun montant | aucune étape ne calcule un montant (ADR-023) |
| T9 | Explicabilité | chaque élément proposé a une explication traçable (sources + confiance) |
| T10 | Déterminisme du classement | mêmes entrées → même ordre |
| T11 | Apprentissage borné | l'apprentissage change le **classement**, jamais une Knowledge Card |

## Niveaux
Unitaire (compréhension, scoring déterministe, règles) · Intégration (lecture moteurs, délégation
d'écriture, tenant) · Non-régression. DB réelle sans isolation (limite connue du projet).

## Conformité
S'appuie sur TEST_STRATEGY (STEP 6) ; couvre chaque invariant read-side/validation/no-invention. ✅

## Changelog
- 1.0 (2026-08-02) — Stratégie initiale.
