# Flow — Inviter un collaborateur

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../FLOW_CATALOG.md](../FLOW_CATALOG.md) — **Used By:** implementation, ui — **Niveau:** 2 · Architecture · **Catégorie:** Onboarding

## Nom
Inviter un collaborateur

## Mission
Inviter un collaborateur par e-mail.

## Objectif métier
Inviter un collaborateur par e-mail.

## Déclencheur
Admin invite

## Préconditions
Utilisateur authentifié ; tenant Company ; droits requis (voir FLOW_PERMISSIONS).

## Acteur principal
Admin

## Acteurs secondaires
Collaborateur

## Objets concernés
User

## Engines concernés
User, Notification

## Entrées
E-mail

## Sorties
Invitation envoyée

## Étapes détaillées
1. **User** — Créer l'invitation → événement `UserInvited` (contrôle : invariants ; résultat : étape validée).
2. **Notification** — Envoyer l'invitation (async) → événement `NotificationRaised` (contrôle : invariants ; résultat : étape validée).

## Décisions & branches possibles
Acceptée → User actif · Expirée → relance

## Diagramme de séquence
```mermaid
sequenceDiagram
  actor A as Admin
  participant E_User as User
  participant E_Notification as Notification
  participant BUS as Bus d'événements
  A->>E_User: Créer l'invitation
  E_User-->>BUS: UserInvited
  A->>E_Notification: Envoyer l'invitation (async)
  E_Notification-->>BUS: NotificationRaised
```

## États
Voir les machines canoniques : [../FLOW_STATES.md](../FLOW_STATES.md).

## Événements publiés
- `UserInvited`

## Événements consommés
—

## Permissions
Voir [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md) (famille **Onboarding**). Action irréversible → confirmation explicite.

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
Envoi asynchrone + notification.

## Fin du processus
Invitation acceptée

## Critères de réussite
Collaborateur rejoint l'entreprise.

## Related Documents
[../FLOW_STATES.md](../FLOW_STATES.md) · [../FLOW_EVENTS.md](../FLOW_EVENTS.md) · [../FLOW_ERRORS.md](../FLOW_ERRORS.md) · [../FLOW_PERMISSIONS.md](../FLOW_PERMISSIONS.md)

## Next Reading
[../FLOW_CATALOG.md](../FLOW_CATALOG.md)

## Changelog
- 1.0 (2026-08-02) — Fiche de flux initiale.
