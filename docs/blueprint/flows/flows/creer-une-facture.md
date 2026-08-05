# Flow — Créer une facture

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Facturation

## Nom
Créer une facture

## Mission
Émettre une facture.

## Objectif métier
Émettre une facture.

## Déclencheur
« Facturer »

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
Mission/Devis

## Sorties
Facture Draft→Issued

## Étapes détaillées
1. **Billing** — Créer la facture → événement `InvoiceCreated` (contrôle : invariants ; résultat : étape validée).
2. **Billing** — Valider (Issued) → événement `InvoiceIssued` (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Validée → **non modifiable**

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Artisan
  participant E_Billing as Billing
  participant BUS as Bus d'événements
  A->>E_Billing: Créer la facture
  E_Billing-->>BUS: InvoiceCreated
  A->>E_Billing: Valider (Issued)
  E_Billing-->>BUS: InvoiceIssued
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `InvoiceCreated`
- `InvoiceIssued`

## Événements consommés
QuoteAccepted

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
Objectif clair ; **≤ 3 étapes** ; retour immédiat (progression, confirmation, annulation) ; langage artisan.

## Performance
Synchrone.

## Fin du processus
Facture émise

## Critères de réussite
Facture conforme, suivie.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
