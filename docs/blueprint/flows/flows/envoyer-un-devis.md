# Flow — Envoyer un devis

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Devis

## Nom
Envoyer un devis

## Mission
Transmettre le devis au client.

## Objectif métier
Transmettre le devis au client.

## Déclencheur
« Envoyer »

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Artisan

## Acteurs secondaires
Client

## Objets concernés
Quote

## Engines concernés
Quote, PDF

## Entrées
Devis Draft

## Sorties
Devis Sent

## Étapes détaillées
1. **PDF** — Rendre le PDF (contrôle : invariants ; résultat : étape validée).
2. **Quote** — Passer à Sent + envoyer → événement `QuoteSent` (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Envoi ok → Sent · échec → réessai

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Artisan
  participant E_PDF as PDF
  participant E_Quote as Quote
  participant BUS as Bus d'événements
  A->>E_PDF: Rendre le PDF
  A->>E_Quote: Passer à Sent + envoyer
  E_Quote-->>BUS: QuoteSent
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `QuoteSent`

## Événements consommés
—

## Permissions
Voir [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md) (famille **Devis**). Action irréversible → confirmation explicite.

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
Rendu synchrone, envoi asynchrone ; confirmation requise.

## Fin du processus
Devis Sent

## Critères de réussite
Client a reçu le devis (confirmation).

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
