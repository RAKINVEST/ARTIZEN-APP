# Flow Events — Transitions et événements

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [FLOW_STATES.md](FLOW_STATES.md), [../engines/ENGINE_EVENTS.md](../engines/ENGINE_EVENTS.md) — **Used By:** flows/ — **Niveau:** 2 · Architecture

## Objective
Pour chaque transition de flux : déclencheur, événement publié, consommateurs, conséquences.

## Table transition → événement
| Transition | Déclencheur | Événement | Consommateurs | Conséquences |
|---|---|---|---|---|
| Mission créée | ouverture | `MissionCreated` | Companion | apparaît au tableau de bord |
| Mission → état suivant | action artisan | `MissionStateChanged` | Companion, Performance | indicateurs, alertes |
| Intervention ajoutée | ajout | `InterventionAdded` | Decision | suggestions d'oublis |
| Devis envoyé | envoi | `QuoteSent` | Companion | suivi de signature |
| Devis signé | signature client | `QuoteAccepted` | Billing, Performance | transformation en mission possible |
| Devis refusé/expiré | refus/délai | `QuoteRefused`/`QuoteExpired` | Companion | relance ou archivage |
| Facture validée | validation | `InvoiceIssued` | Performance, Companion | suivi de paiement |
| Paiement reçu | encaissement | `PaymentReceived` | Performance | marge réelle |
| Intervention clôturée | clôture | `MissionStateChanged`, `TimeRecorded` | Performance, Knowledge | 5 temps, capitalisation |
| Matériel reçu | réception | `POReceived`, `StockAdjusted` | Stock | mise à jour du stock |
| Suggestion acceptée | choix artisan | `SuggestionAccepted` | Decision | apprentissage (Loi 13) |
| Objet archivé | archivage | `*Archived` | Search | retrait des vues actives |

## Règles
Aucun **événement silencieux** : toute transition significative publie. Un événement porte `schema_version`. Cœur → read-side uniquement.

## Acceptance Criteria
Chaque transition des machines canoniques a son événement, ses consommateurs et ses conséquences.

## Related Documents
[FLOW_STATES.md](FLOW_STATES.md) · [../engines/ENGINE_EVENTS.md](../engines/ENGINE_EVENTS.md)

## Next Reading
[FLOW_ERRORS.md](FLOW_ERRORS.md)

## Changelog
- 1.0 (2026-08-02) — Table transitions/événements.
