# Flow — Encaisser un paiement

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Facturation

## Nom
Encaisser un paiement

## Mission
Enregistrer un paiement.

## Objectif métier
Enregistrer un paiement.

## Déclencheur
Paiement reçu

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Artisan

## Acteurs secondaires
—

## Objets concernés
Invoice

## Engines concernés
Billing

## Entrées
Montant, date

## Sorties
Facture Paid

## Étapes détaillées
1. **Billing** — Enregistrer le paiement → événement `PaymentReceived` (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Partiel → reste dû · Retard → alerte

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Artisan
  participant E_Billing as Billing
  participant BUS as Bus d'événements
  A->>E_Billing: Enregistrer le paiement
  E_Billing-->>BUS: PaymentReceived
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `PaymentReceived`

## Événements consommés
—

## Permissions
Voir [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md) (famille **Facturation**). Action irréversible → confirmation explicite.

## Validation
Invariants du Domain Model (Step 2) vérifiés ; aucune donnée inventée ; le PDF/source fait foi le cas échéant.

## Erreurs possibles
Voir [../FLOW_ERRORS.md](../FLOW_ERRORS.md) : validation, permission (404 cross-tenant), conflit, ressource absente, échec IA/OCR/stockage/réseau.

## Rollback
Tant que l'objet est un brouillon : annulation directe. Après figement : compensation tracée (ex. avoir), jamais de destruction.

## Historisation
Chaque étape est journalisée (History, append-only — Loi 5).

## UX
Objectif clair ; **≤ 2 étapes** ; retour immédiat (progression, confirmation, annulation) ; langage artisan.

## Performance
Synchrone.

## Fin du processus
Facture Paid

## Critères de réussite
Paiement enregistré, marge réelle mise à jour.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
