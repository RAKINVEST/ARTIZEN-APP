# Event Contracts — Conventions d'événements

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../events/README.md](../events/README.md) — **Used By:** contracts/events, engines — **Niveau:** 2 · Architecture

## Objective
Fixer la forme de chaque événement de domaine. Modèle : [../templates/EVENT_TEMPLATE.md](../templates/EVENT_TEMPLATE.md).

## Forme d'un événement
| Élément | Règle |
|---|---|
| **Nom** | `SujetVerbePassé` (`MissionCompleted`, `QuoteAccepted`) |
| **Publisher** | un seul moteur émetteur (Loi 1) |
| **Subscribers** | moteurs read-side ; jamais le cœur en retour |
| **Payload** | ids + valeurs nécessaires ; jamais un agrégat entier ; jamais de secret |
| **Version** | `schema_version` obligatoire ; évolution par upcasting |
| **Déclencheur** | une transition métier précise |
| **Garanties** | au-moins-une-fois ; consommateurs **idempotents** |
| **Ordonnancement** | par agrégat (clé = id) ; pas d'ordre global garanti |
| **Idempotence** | rejouer un événement ne double aucun effet |
| **Historisation** | l'événement est immuable, conservé (Loi 4/5) |

## Event Map (Mermaid)
```mermaid
flowchart LR
  MIS[Mission]:::c --> E1((MissionCompleted))
  QT[Quote]:::c --> E2((QuoteAccepted))
  E1 --> PERF[Performance]:::r & KN[Knowledge]:::r & COMP[Companion]:::r
  E2 --> BILL[Billing]:::c & PERF
  classDef c fill:#e8e2ff,stroke:#6b4fbb; classDef r fill:#e2f0ff,stroke:#3b74bb;
```

## Rules
Aucun événement ne mute un agrégat cœur (Loi 7). On apprend uniquement des actions validées (`*Accepted`, Loi 13). Jamais d'événement silencieux.

## Acceptance Criteria
Chaque événement a nom, publisher, subscribers, payload, version, garanties, ordonnancement, idempotence, historisation.

## Related Documents
[COMMAND_CONTRACTS.md](COMMAND_CONTRACTS.md) · [../engines/ENGINE_EVENTS.md](../engines/ENGINE_EVENTS.md)

## Next Reading
[COMMAND_CONTRACTS.md](COMMAND_CONTRACTS.md)

## Changelog
- 1.0 (2026-08-02) — Conventions événements + map initiales.
