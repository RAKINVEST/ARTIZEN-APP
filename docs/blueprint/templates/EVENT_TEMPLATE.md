# Événement — <Nom>

> **Version** 0.1 — **Status** Draft — **Owner** <équipe> — **Last Update** AAAA-MM-JJ
> **Depends On:** [../engines/](../engines/README.md) — **Used By:** <moteurs consommateurs> — **Niveau:** 2 · Architecture

## Objective
<Ce que signale cet événement de domaine.>

## Emitter
<Le contexte / agrégat qui l'émet.>

## Consumers
<Les moteurs read-side qui l'écoutent.>

## Payload
| Champ | Type | Description |
|---|---|---|
| … | … | … |

## Schema Version
1 — <politique de versionnement : immuable ; nouvelle version = nouveau schéma, upcasting>.

## Invariants
Immuable après émission (Loi 4/5). Ne mute jamais un agrégat cœur (Loi 7). L'apprentissage n'exploite que les actions **validées** (Loi 13).

## Constraints
## Rules
## Forbidden
Servir de canal d'écriture vers le cœur.

## Acceptance Criteria
Émetteur + consommateurs + version + charge utile déclarés ; aucun consommateur orphelin.

## Related Documents
## Next Reading
## Changelog
- 0.1 (AAAA-MM-JJ) — Création.
